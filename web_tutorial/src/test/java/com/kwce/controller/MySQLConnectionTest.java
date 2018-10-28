package com.kwce.controller;
import java.sql.Connection;
import java.sql.DriverManager;
import org.junit.Test;

public class MySQLConnectionTest {
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";  
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/web_tutorial?serverTimezone=UTC&useSSL=false";
	private static final String USER ="root";
	private static final String PW ="123456"; // Enter your password
	
	@Test // add build path 
	public void testConnection() throws Exception {
		
		Class.forName(DRIVER);
		
		try(Connection con = DriverManager.getConnection(URL, USER, PW)){
			
			System.out.println(con);
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}
	}

}
