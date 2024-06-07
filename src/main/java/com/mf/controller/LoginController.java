package com.mf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.mf.dto.PersonDto;
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
	
	@GetMapping("/totalJoin")
	public String totalJoin(){
		
		return "/totalJoin";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/join";
	}
	
	@PostMapping("/joinProcess")
	public String joinProcess(UsersDto usersDto,PersonDto personDto) {
		
		usersService.joinProcess(usersDto,personDto);
		
		return "redirect:/login";
	}
	
}
