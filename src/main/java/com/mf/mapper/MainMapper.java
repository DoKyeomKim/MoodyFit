package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.CategoryDto;
import com.mf.dto.PersonDto;

@Mapper
public interface MainMapper {

	List<CategoryDto> getCategory();


}
