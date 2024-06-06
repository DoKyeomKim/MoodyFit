package com.mf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.mf.dto.UsersDto;
import com.mf.service.UsersService;


@Controller
public class LoginController {
	@Autowired
	private UsersService usersService;

	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/join";
	}
	
	@PostMapping("/joinProcess")
	public String joinProcess(UsersDto usersDto) {
		
		usersService.joinProcess(usersDto);
		
		return "redirect:/login";
	}
	
}
