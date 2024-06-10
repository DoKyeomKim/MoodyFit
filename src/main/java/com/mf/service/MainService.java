package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.MainMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MainService {
    @Autowired
    private MainMapper mainMapper;
    
    public List<CategoryDto> getCategory() {
        return mainMapper.getCategory();
    }
    
    // 카테고리 영어 이름 기준으로 서브 카테고리 목록 가져오는 메소드
    public List<SubCategoryDto> getSubCategoriesByCategoryEngName(String categoryEngName) {
        return mainMapper.getSubCategoriesByCategoryEngName(categoryEngName);
    }
    
    // 영어 이름으로 특정 카테고리의 All 서브 카테고리 가져오는 메소드
    public SubCategoryDto getAllSubCategoryByCategoryEngName(String categoryEngName) {
        return mainMapper.getAllSubCategoryByCategoryEngName(categoryEngName);
    }
    
    // 서브 카테고리 이름과 카테고리 이름으로 특정 서브 카테고리를 가져오는 메소드
    public SubCategoryDto getSubCategoryByNameAndCategoryEngName(String subCategoryName, String categoryEngName) {
        return mainMapper.getSubCategoryByNameAndCategoryEngName(subCategoryName, categoryEngName);
    }
    
    // 키워드를 사용해 필터링된 카테고리 목록 가져오는 메소드
	public List<CategoryDto> getCategoriesByKeyword(String keyword) {
		return mainMapper.getCategoriesByKeyword(keyword);
	}
	
	// 카테고리 코드로 서브 카테고리 목록 가져오는 메소드
	public List<SubCategoryDto> getSubCategoriesByCategoryCode(String categoryCode) {
        List<SubCategoryDto> subCategories = mainMapper.getSubCategoriesByCategoryCode(categoryCode);
        log.info("Fetched subcategories for categoryCode {}: {}", categoryCode, subCategories);
        return subCategories;
    }
}
