package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PersonDto;
@Mapper
public interface PersonMapper {
    List<PersonDto> getAllPersons();

	void dropUser(Long userIdx);

}
