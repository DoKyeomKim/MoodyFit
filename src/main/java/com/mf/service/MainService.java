package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
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



}




