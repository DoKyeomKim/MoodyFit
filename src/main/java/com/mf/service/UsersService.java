package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mf.dto.UsersDto;
import com.mf.mapper.UsersMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UsersService {
	@Autowired
	private UsersMapper usersMapper;
	
	/*
	 * @Autowired private BCryptPasswordEncoder bCryptPasswordEncoder;
	 */

    public void joinProcess(UsersDto usersDto) {
		/*
		 * String encodedPassword =
		 * bCryptPasswordEncoder.encode(usersDto.getPassword());
		 * usersDto.setPassword(encodedPassword);
		 */
        usersMapper.joinProcess(usersDto);
    }

    public UsersDto findById(String id) {
        return usersMapper.findById(id);
    }

}




