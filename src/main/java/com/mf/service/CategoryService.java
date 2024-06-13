package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.CategoryMapper;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class CategoryService {
	 @Autowired
	    private CategoryMapper categoryMapper;

	    public List<CategoryDto> getAllCategorys() {
	        return categoryMapper.getAllCategorys();
	    }

		 public void addCategory(CategoryDto categoryDTO) {
	        try {
	            categoryMapper.addCategory(categoryDTO);
	            log.info("FAQ successfully added: " + categoryDTO);
	        } catch (Exception e) {
	            log.error("Error adding FAQ: " + e.getMessage());
	        }
	    }
		 
		 
		 
		 
		 
		 
		 public void updateCategory(CategoryDto category) {
		        categoryMapper.updateCategory(category);
		    }

		    public void deleteCategory(Long categoryIdx) {
		        categoryMapper.deleteCategory(categoryIdx);
		    }

			
		

		}


