package com.mf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mf.dto.PersonDto;
import com.mf.dto.UsersDto;
import com.mf.service.UsersService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class LoginController {
	@Autowired
	private UsersService usersService;

	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	
	// 회원가입 선택 페이지
	@GetMapping("/totalJoin")
	public String totalJoin(){
		
		return "/totalJoin";
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public String join() {
		return "/join";
	}
	
	// 가맹점 회원가입 페이지이동
	@GetMapping("/storeJoin")
	public String storeJoin() {
		
		return "/storeJoin";
	}
	
	// 일반유저 회원가입 진행
	@PostMapping("/joinProcess")
	public String joinProcess(UsersDto usersDto,PersonDto personDto) {
		
		usersService.joinProcess(usersDto,personDto);
		
		return "redirect:/login";
	}
	
	// 가맹점 회원가입 진행
	@PostMapping("/storeJoinProcess")
	public String storeJoinProcess(UsersDto usersDto) {
		usersService.storeJoinProcess(usersDto);
		
		return "redirect:/login";
	}
	
	
    // 실패 페이지 추가
    @GetMapping("/loginFail")
    public String loginFail() {
        return "/loginFail"; // 실패 시 보여줄 페이지
    }
	
}
