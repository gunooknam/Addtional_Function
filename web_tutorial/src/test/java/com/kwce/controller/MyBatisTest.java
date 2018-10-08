package com.kwce.controller;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MyBatisTest {
	
	@Autowired
	private SqlSessionFactory sqlFactory;
	     // 주입과 관련된 객체
	@Test
	public void testFactory(){
		System.out.println(sqlFactory);
	}
	@Test
	public void testSession() throws Exception {
		try{
	      //실제 데이터베이스와 연결을 담당하는 객체
			SqlSession session=sqlFactory.openSession();
			System.out.println(session);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
