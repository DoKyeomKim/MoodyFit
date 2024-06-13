package com.mf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mf.service.MainService;


@Controller
public class MyPageController {
	
	@Autowired
	private MainService mainService;
	
	@GetMapping("/storeMypage")
	public ModelAndView mypage() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/storemypage");
		return mv;
		
	}
	
	
}
