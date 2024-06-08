package com.mf.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CategoryDto;
import com.mf.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@Autowired
	private MainService mainService;

	// 메인 페이지
	@GetMapping("/")
	public  ModelAndView main() {
		ModelAndView mv = new ModelAndView();
		List<CategoryDto> category = mainService.getCategory();
		
		 
		mv.addObject("category", category);
		mv.setViewName("/main");
		return mv; 	
	}
	@GetMapping("/search")
	public ModelAndView search() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/search");
		return mv;
	}
	
	@GetMapping("/{engName}")
	public ModelAndView category() {
	ModelAndView mv = new ModelAndView();
	
	mv.setViewName("/main");
	return mv;
	}
	
	
}

















