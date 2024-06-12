package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.CategoryDto;

@Mapper
public interface CategoryMapper {



	List<CategoryDto> getAllCategorys();

	void addCategory(CategoryDto categoryDTO);

}
