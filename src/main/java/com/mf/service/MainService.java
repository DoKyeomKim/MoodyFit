package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.PersonDto;
import com.mf.mapper.MainMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainService {
	@Autowired
	private MainMapper mainMapper;
	
	public List<CategoryDto> getCategory() {
		return mainMapper.getCategory();
	}

	/*
	 * public List<Map<String, Object>> getPostingAll() {
	 * 
	 * List<Map<String, Object>> result = mainMapper.getPostingAll();
	 * 
	 * return result; }
	 */


}




