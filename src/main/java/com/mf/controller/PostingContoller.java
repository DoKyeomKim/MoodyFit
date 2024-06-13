package com.mf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PostingContoller {
	@GetMapping("/storeMypage/postingDetail")
	public ModelAndView productDetail() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("posting/postingdetail");
		return mv;
	}
}
