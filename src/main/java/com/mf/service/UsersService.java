package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;
import com.mf.mapper.UsersMapper;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UsersService {
	@Autowired
	private UsersMapper usersMapper;
	
	
	  @Autowired private BCryptPasswordEncoder bCryptPasswordEncoder;
	

	// 개인 회원가입 진행
	@Transactional
    public void joinProcess(UsersDto usersDto, PersonDto personDto, PersonSpecDto personSpecDto) {
		
		// 비밀번호 암호화
		 String encodedPassword = bCryptPasswordEncoder.encode(usersDto.getPw());
		 usersDto.setPw(encodedPassword);
		
		// users에 넣을 정보
        usersMapper.joinProcess(usersDto);
        // person에 넣을 정보
        usersMapper.joinDetailProcess(personDto);
        // person_spec에 넣을 정보
        usersMapper.specProcess(personSpecDto);
    }

	// 가맹점 회원 가입 진행
	@Transactional
	public void storeJoinProcess(UsersDto usersDto, StoreDto storeDto) {
		
		// 비밀번호 암호화
		 String encodedPassword = bCryptPasswordEncoder.encode(usersDto.getPw());
		 usersDto.setPw(encodedPassword);
		 
		 // users에 넣을 정보
		 usersMapper.storeJoinProcess(usersDto);
		 // store에 넣을 정보
		 usersMapper.storeJoinDetailProcess(storeDto);
		
	}
	
	// 로그인
    public UsersDto findById(String id) {
        return usersMapper.findById(id);
    }

    // 회원가입 아이디 중복체크
	public String getId(String id) {
		return usersMapper.getId(id);
	}

	// 회원가입 닉네임 중복체크
	public String getNickname(String nickName) {
		return usersMapper.getNickName(nickName);
	}


}




