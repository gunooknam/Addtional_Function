package com.kwce.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kwce.domain.Criteria;
import com.kwce.domain.PageMaker;
import com.kwce.domain.ReplyVO;
import com.kwce.service.ReplyService;

@RestController  //@RestController 방식으로 사용

@RequestMapping("/replies")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Inject
	private ReplyService service;
	@RequestMapping(value="", method=RequestMethod.POST) //POST 방식으로 전송
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){ 
		// 데이터의 전송으로 JSON 포맷을 이용할 것이므로 이를 처리하는                                  
		// @RequestBody 애노테이션이 필요                                                             
		// 리턴타입이 저것이므로 실패하면 예외의 원인 메세지를 전송할 것
		ResponseEntity<String> entity = null;
		try {
			service.addReply(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			// 에외의 원인 메세지를 전송하고 사용자에게는  BAD_REQUEST(400)를 결과로 전송
		}
		return entity;
	}
	
	// 뒤에 bno를 붙인다. 반환 형식은 List 이다. 
	// 댓글 무더기를 반환한다. 
	@RequestMapping(value="/all/{bno}", method=RequestMethod.GET) //특정 게시물의 전체 댓글의 목록은 GET 방식으로 처리돼야 하고, 반드시 특정 게시물 번호(bno) 필요
	public ResponseEntity<List<ReplyVO>> list (@PathVariable("bno") Integer bno){
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			// 메소드이 처리가 성공하는 경우에는 HttpStatus.OK 헤더 전송 전달할 것의 타입을 제네릭으로 정의 
			entity = new ResponseEntity<List<ReplyVO>>(service.listReply(bno), HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}",method={RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("rno") Integer rno, @RequestBody ReplyVO vo){
		ResponseEntity<String> entity = null;
		
		logger.info("update ajax page PUT......");
		
		try { // 객체를 받아가지고 넣고 
			vo.setRno(rno);
			service.modifyReply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}", method=RequestMethod.DELETE)
	public ResponseEntity<String> remove(
	@PathVariable("rno") Integer rno){	
		ResponseEntity<String> entity = null;
		try {
			service.removeReply(rno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(
				e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//Ajax로 호출될 것이므로 Model을 사용하지 못한다는 점이다.
	@RequestMapping(value="/{bno}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>>listPage(
			@PathVariable("bno") Integer bno, 
			@PathVariable("page") Integer page) {
			// URI에 파리미터를 쓰겠당 
		ResponseEntity<Map<String,Object>> entity = null;
		
		try {
			Criteria cri=new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyVO> list = service.listReplyPage(bno, cri);
			
			map.put("list", list);
			// 가져올 댓글들을 리스트로 담았다. 
			
			int replyCount = service.count(bno);
			pageMaker.setTotalCount(replyCount);
			
			map.put("pageMaker", pageMaker);
			// 페이징에 대한 정보를 담음 
			// 그리고 REST 방식으로 전송 맵으로 전송하였다. 
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace(); 
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}


