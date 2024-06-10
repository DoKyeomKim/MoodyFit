package com.mf.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MypageController {
	@GetMapping("/storeMypage")
	public ModelAndView mypage() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/storemypage");
		return mv;
		
	}
	
}
