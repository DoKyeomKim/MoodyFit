package com.mf.controller;

import java.util.HashMap;
import java.util.Map;

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
		return "login/login";
	}
	
	// 회원가입 선택 페이지
	@GetMapping("/totalJoin")
	public String totalJoin(){
		
		return "login/totalJoin";
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public String join() {
		return "login/join";
	}
	
	// 가맹점 회원가입 페이지이동
	@GetMapping("/storeJoin")
	public String storeJoin() {
		
		return "login/storeJoin";
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
        return "login/loginFail"; // 실패 시 보여줄 페이지
    }
    
	// 아이디 중복체크
	@GetMapping("/idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("id") String id) {
		
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
	// 상호명 중복체크
	@GetMapping("/storeNameCheck")
	@ResponseBody
	public String storeNameCheck(@RequestParam("storeName") String storeName) {
		
		String resultNickname = usersService.getStoreName(storeName);
		if(resultNickname==null) {
			return "<small style='color:green'>사용가능한 상호명입니다</small>";
		}  else {
			return "<small style='color:red'>사용할 수 없는 상호명입니다</small>";
		}
		
	}
	
	@GetMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(@RequestParam("email") String email) {
		
		
		String resultEmail = usersService.getEmail(email);
		if(resultEmail==null) {
			return "<small style='color:green'>사용가능한 이메일입니다</small>";
		}  else {
			return "<small style='color:red'>사용중인 이메일 입니다.</small>";
		}
		
	}
	
	// 아이디 찾기
	@PostMapping("/findId")
	@ResponseBody
	public String findId(@RequestParam("findIdMethod") String findIdMethod,
	                     @RequestParam("phone") String phone,
	                     @RequestParam("email") String email) {
	    String id = null;

	    if ("email".equals(findIdMethod) && email != null) {
	        id = usersService.getIdByEmail(email);
	    } else if ("phone".equals(findIdMethod) && phone != null) {
	        id = usersService.getIdByPhone(phone);
	    } 
	    return id != null ? "<small>찾으시는 ID는</small><div style='color:green; font-size: 20px;'>" + 
	    id + "</div><small>입니다.</small>" 
	    : "<small style='color:red;'>찾으시는 ID가 없습니다.<br> 다시 확인해주세요.</small>";
	}
	
}
