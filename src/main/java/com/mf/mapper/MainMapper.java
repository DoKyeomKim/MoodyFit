package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.CategoryDto;
import com.mf.dto.PersonDto;

@Mapper
public interface MainMapper {

	List<CategoryDto> getCategory();
	/*
	 * List<Map<String, Object>> getPostingAll();
	 * 
	 */
}
