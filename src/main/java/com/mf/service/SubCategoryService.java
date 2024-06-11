package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.SubCategoryDto;
import com.mf.mapper.SubCategoryMapper;
@Service
public class SubCategoryService {
	 @Autowired
	    private SubCategoryMapper SubcategoryMapper;

	    public List<SubCategoryDto> getAllSubCategorys() {
	        return SubcategoryMapper.getAllSubCategorys();
	    }

}
