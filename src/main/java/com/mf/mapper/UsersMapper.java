package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;

@Mapper
public interface UsersMapper {

	UsersDto findById(String id);

	// 개인 회원가입 진행
	void joinProcess(UsersDto usersDto);
	void joinDetailProcess(PersonDto personDto);
	
	//아이디 중복 체크
	String getId(String id);
	//=========================
	
	//가맹점 회원가입 진행
	void storeJoinProcess(UsersDto usersDto);
	void storeJoinDetailProcess(StoreDto storeDto);


}
