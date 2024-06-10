package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;

@Mapper
public interface MainMapper {
    List<CategoryDto> getCategory();
    
    List<CategoryDto> getCategoriesByKeyWord(@Param("keyword") String keyword);
    
    List<SubCategoryDto> getSubCategoriesByCategoryEngName(@Param("categoryEngName") String categoryEngName);
    
    SubCategoryDto getAllSubCategoryByCategoryEngName(@Param("categoryEngName") String categoryEngName);
    
    // 서브 카테고리 이름과 카테고리 이름으로 서브 카테고리를 가져오는 메서드
    SubCategoryDto getSubCategoryByNameAndCategoryEngName(@Param("subCategoryName") String subCategoryName,
                                                          @Param("categoryEngName") String categoryEngName);

	List<CategoryDto> getCategoriesByKeyword(String keyword);
	
	List<SubCategoryDto> getSubCategoriesByCategoryCode(@Param("categoryCode") String categoryCode);
}
