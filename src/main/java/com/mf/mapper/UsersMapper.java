package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;

@Mapper
public interface UsersMapper {

	UsersDto findById(String id);

	// 개인 회원가입 진행
	void joinProcess(UsersDto usersDto);
	void joinDetailProcess(PersonDto personDto);
	void specProcess(PersonSpecDto personSpecDto);
	
	//아이디 중복 체크
	String getId(String id);
	//닉네임 중복 체크
	String getNickName(String nickName);
	//=========================
	
	//가맹점 회원가입 진행
	void storeJoinProcess(UsersDto usersDto);
	void storeJoinDetailProcess(StoreDto storeDto);

	// 상호명 중복체크
	String getStoreName(String storeName);

	
	// OAuth 확인용 email
	UsersDto getUserById(String id);


	// OAuth users 저장
	void OAuthJoin(UsersDto users);
	// OAuth person 저장
	void OAuthPersonJoin(PersonDto person);
	// OAuth person_spec 저장
	void OAuthSpecJoin();

	// OAuth 회원탈퇴 후 정보 겹치는거 방지
	UsersDto getUserByIdAndState(String id);













}
