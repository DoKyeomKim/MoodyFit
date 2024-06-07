package com.mf.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
import com.mf.dto.UsersDto;

@Mapper
public interface UsersMapper {

	UsersDto findById(String id);

	void joinProcess(UsersDto usersDto);

	void joinDetailProcess(PersonDto personDto);

}
