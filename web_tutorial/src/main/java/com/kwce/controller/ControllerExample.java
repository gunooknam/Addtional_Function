package com.kwce.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kwce.domain.ExampleVO;

@Controller
public class ControllerExample {

	private static final Logger logger = LoggerFactory.getLogger(ControllerExample.class);
	
	@RequestMapping("/urlA")
	public String doA( @ModelAttribute("msg") String msg) {
		msg=" urlA Test";
		logger.info("urlA called...." +msg);
		return "resultA";
	}
	
	@RequestMapping("/urlB")
	public String doB(Model model) {
		logger.info("urlB called....");
		ExampleVO ex=new ExampleVO("Test",5);
		model.addAttribute(ex);
		return "resultB";
	}
	
	@RequestMapping("/urlC")
	public String doC(Model model) {
		logger.info("urlC called....");
		String msg2="urlC Test";
		model.addAttribute("msg",msg2);
		return "resultC";
	}
	
	@RequestMapping(value = "/urlF", method = RequestMethod.GET)
	public String get(Model model) {
		logger.info("urlF get called....");
		return "GetandPost";
	}
	
	@RequestMapping(value = "/urlF", method = RequestMethod.POST)
	public String post(String StudentID, String name) {
		logger.info("urlF post called....");
		System.out.println(StudentID);
		System.out.println(name);
		return "redirect:/";
	}
	
}
