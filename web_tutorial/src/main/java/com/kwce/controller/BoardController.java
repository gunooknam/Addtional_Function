package com.kwce.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kwce.domain.BoardVO;
import com.kwce.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired 
	private BoardService service;
	
	@RequestMapping(value= "/list",method = RequestMethod.GET)
	public String list(Model model) throws Exception{
		logger.info("list page get....");
		model.addAttribute("list",service.listAll());
		return "board/list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerGET(BoardVO board, Model model)throws Exception {
		logger.info("register page get......");	
		return "board/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr)throws Exception {
		logger.info("register page post......");	
		logger.info(board.toString());
		service.regist(board);
		rttr.addFlashAttribute("msg","SUCCESS");
		return "redirect:/board/list"; 
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(@RequestParam("bno") int bno,
					 Model model)throws Exception{
		logger.info("read page get....");
		model.addAttribute(service.read(bno)); 
		return "board/read";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyGET(@RequestParam("bno") int bno, Model model)throws Exception{
		logger.info("modify page get....");
		model.addAttribute(service.read(bno)); 
		return "board/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("modify page post......");	
		logger.info(board.toString());
		service.modify(board);
		rttr.addFlashAttribute("msg","SUCCESS");
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno,
			RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		logger.info("remove page post......");	
		rttr.addFlashAttribute("msg","SUCCESS");
		return "redirect:/board/list"; 
	}
	
}
