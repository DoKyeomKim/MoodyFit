package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.UsersDto;

@Mapper
public interface UsersMapper {

	void joinProcess(UsersDto usersDto);

	UsersDto findById(String id);

}
