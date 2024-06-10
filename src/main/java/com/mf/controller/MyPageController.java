package com.mf.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.PersonDto;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	@Autowired
	private MyPageService myPageService;
	
	
	// 마이페이지 메인
	@GetMapping("/myPage")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		
		// 마이페이지 로직처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		// 서비스에서 넘어온 person안에 들어가 있는 person_idx와 nickname 꺼내기
		PersonDto person = (PersonDto) result.get("person");
		
		
		mv.addObject("person",person);
		mv.setViewName("/myPage");
		return mv;
	}
	
	
	
	
}
