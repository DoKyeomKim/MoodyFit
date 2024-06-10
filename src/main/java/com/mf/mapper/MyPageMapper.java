package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;

@Mapper
public interface MyPageMapper {

	// 세션 저장된 userIdx로 닉네임 갖고오기
	PersonDto getNickNameByUserIdx(Long userIdx);

}
