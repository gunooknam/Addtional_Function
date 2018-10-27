package com.kwce.controller;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kwce.dao.BoardDAO;
import com.kwce.domain.BoardVO;
import com.kwce.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class testpageCriteria {
	
	
	@Autowired
	private BoardDAO dao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Test
	public void testPage() throws Exception {
	
//		PageCriteria cri = new PageCriteria();
//		cri.setPage(3); //1페이지 처음 30개 => //2페이지 다음 30개 => //3페이지 마지막 잔여물 5개
//		cri.setPerpageNum(30);
//		
//		List<BoardVO> list = dao.listCriteria(cri);
//		for(BoardVO vo: list) {
//			logger.info(vo.getBno()+":"+vo.getTitle());
//		}
		logger.info(":HELL"+dao.countPaging());
		
	}
	
}
