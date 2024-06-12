package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;

@Mapper
public interface SubCategoryMapper {



	List<SubCategoryDto> getAllSubCategorys();

	void addSubCategory(SubCategoryDto subcategoryDTO);

}
