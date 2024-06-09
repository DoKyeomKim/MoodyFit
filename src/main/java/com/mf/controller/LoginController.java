package com.mf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;
import com.mf.service.UsersService;


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
	public String joinProcess(UsersDto usersDto,PersonDto personDto,PersonSpecDto personSpecDto) {
		
		usersService.joinProcess(usersDto,personDto,personSpecDto);
		
		return "redirect:/login";
	}
	
	// 가맹점 회원가입 진행
	@PostMapping("/storeJoinProcess")
	public String storeJoinProcess(UsersDto usersDto,StoreDto storeDto) {
		usersService.storeJoinProcess(usersDto,storeDto);
		return "redirect:/login";
	}
	
	
    // 실패 페이지 추가
    @GetMapping("/loginFail")
    public String loginFail() {
        return "/loginFail"; // 실패 시 보여줄 페이지
    }
    
	// 아이디 중복체크
	@GetMapping("/IdCheck")
	@ResponseBody
	public String IdCheck(@RequestParam("id") String id) {
		
		String resultId = usersService.getId(id);
		if(resultId==null) {
			return "<small style='color:green'>사용가능한 아이디입니다</small>";
		}  else {
		return "<small style='color:red'>사용할 수 없는 아이디입니다</small>";
		}

	}
	
	// 닉네임 중복체크
	@GetMapping("/nickNameCheck")
	@ResponseBody
	public String nickNameCheck(@RequestParam("nickName") String nickName) {
		
		String resultNickname = usersService.getNickname(nickName);
		if(resultNickname==null) {
			return "<small style='color:green'>사용가능한 닉네임입니다</small>";
		}  else {
		return "<small style='color:red'>사용할 수 없는 닉네임입니다</small>";
		}

	}
	
}
