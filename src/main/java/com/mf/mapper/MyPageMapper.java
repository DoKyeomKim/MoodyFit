package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;

@Mapper
public interface MyPageMapper {

	// 세션 저장된 userIdx로 닉네임 갖고오기
	PersonDto getNickNameByUserIdx(Long userIdx);

	// 세션 저장된 userIdx로 상호명 갖고오기
	StoreDto getStoreNameByUserIdx(Long userIdx);

}
