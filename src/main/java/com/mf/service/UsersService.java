package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.UsersDto;
import com.mf.mapper.UsersMapper;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UsersService {
	@Autowired
	private UsersMapper usersMapper;
	
	
	  //@Autowired private BCryptPasswordEncoder bCryptPasswordEncoder;
	

	@Transactional
    public void joinProcess(UsersDto usersDto) {
		
		  //String encodedPassword = bCryptPasswordEncoder.encode(usersDto.getPw());
		 // usersDto.setPw(encodedPassword);
		 
        usersMapper.joinProcess(usersDto);
    }

    public UsersDto findById(String id) {
        return usersMapper.findById(id);
    }

}




