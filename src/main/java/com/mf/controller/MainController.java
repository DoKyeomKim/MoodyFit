package com.mf.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CategoryDto;
import com.mf.service.CustomUserDetails;
import com.mf.service.MainService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@Autowired
	private MainService mainService;

	// 메인 페이지
	@GetMapping("/")
	public ModelAndView main(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		// 시큐리티 로그인하면서 세션에 저장되게 한 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");

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

	@GetMapping("/myPage")
	public ModelAndView getMethodName() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("/myPage");
		return mv;
	}

}
