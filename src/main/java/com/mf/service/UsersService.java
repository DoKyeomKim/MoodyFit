package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
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
    public void joinProcess(UsersDto usersDto, PersonDto personDto) {
		
		// 비밀번호 암호화
		 String encodedPassword = bCryptPasswordEncoder.encode(usersDto.getPw());
		 usersDto.setPw(encodedPassword);
		
		// users에 넣을 정보
        usersMapper.joinProcess(usersDto);
        // person에 넣을 정보
        usersMapper.joinDetailProcess(personDto);
    }

	// 가맹점 회원 가입 진행
	@Transactional
	public void storeJoinProcess(UsersDto usersDto, StoreDto storeDto) {
		
		// 비밀번호 암호화
		 String encodedPassword = bCryptPasswordEncoder.encode(usersDto.getPw());
		 usersDto.setPw(encodedPassword);
		 
		 // users에 넣을 정보
		 usersMapper.storeJoinProcess(usersDto);
		 usersMapper.storeJoinDetailProcess(storeDto);
		
	}
	
    public UsersDto findById(String id) {
        return usersMapper.findById(id);
    }

	public String getId(String id) {
		return usersMapper.getId(id);
	}


}




