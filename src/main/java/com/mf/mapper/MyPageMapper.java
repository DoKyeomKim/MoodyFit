package com.mf.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;

@Mapper
public interface MyPageMapper {

	// 세션 저장된 userIdx로 닉네임 갖고오기
	PersonDto getNickNameByUserIdx(Long userIdx);
	// 개인회원 정보 전체 갖고 오기(정보수정용)
	Map<String, Object> getPersonInfo(Long userIdx);
	
	// 정보 수정용 비밀번호 일치 확인
	UsersDto getUserById(Long userIdx);
	// 개인회원 users 수정
	void personUsersUpdate(UsersDto users);
	// 개인회원 person 수정
	void personUpdate(PersonDto person);
	// 개인회원 person_spec 수정
	void personSpecUpdate(PersonSpecDto personSpec);	
	
	
	//=====================================================
	//=======================가맹점========================
	//=====================================================
	
	// 세션 저장된 userIdx로 상호명 갖고오기
	StoreDto getStoreNameByUserIdx(Long userIdx);




}
