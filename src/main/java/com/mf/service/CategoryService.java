package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.mapper.CategoryMapper;
@Service
public class CategoryService {
	 @Autowired
	    private CategoryMapper categoryMapper;

	    public List<CategoryDto> getAllCategorys() {
	        return categoryMapper.getAllCategorys();
	    }

}
