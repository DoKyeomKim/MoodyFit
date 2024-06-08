package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.UsersDto;

@Mapper
public interface UsersMapper {

	UsersDto findById(String id);

	// 개인 회원가입 진행
	void joinProcess(UsersDto usersDto);
	void joinDetailProcess(PersonDto personDto);
	//=========================
	
	//가맹점 회원가입 진행
	void storeJoinProcess(UsersDto usersDto);

}
