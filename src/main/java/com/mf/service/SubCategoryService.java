package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.SubCategoryMapper;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class SubCategoryService {
	 @Autowired
	    private SubCategoryMapper SubcategoryMapper;

	    public List<SubCategoryDto> getAllSubCategorys() {
	        return SubcategoryMapper.getAllSubCategorys();
	    }
	    public void addSubCategory(SubCategoryDto SubcategoryDTO) {
	        try {
	            SubcategoryMapper.addSubCategory(SubcategoryDTO);
	            log.info("FAQ successfully added: " + SubcategoryDTO);
	        } catch (Exception e) {
	            log.error("Error adding FAQ: " + e.getMessage());
	        }
	    }
	
	
}
