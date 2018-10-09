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
import com.kwce.domain.SearchCriteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class testDynamic {

	@Autowired
	private BoardDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(testDynamic.class);
	
/*	@Test 
	public void testSearch() throws Exception {
		SearchCriteria sc=new SearchCriteria("c","새로운");	
		List<BoardVO> list = dao.listSearch(sc);
		for (BoardVO boardVO : list) { //향상된 for문
			logger.info(boardVO.getBno()+ ":" + boardVO.getTitle());
		}
	}*/

}
