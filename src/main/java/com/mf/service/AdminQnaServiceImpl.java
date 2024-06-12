package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.mapper.AdminQnaMapper;

@Service
public class AdminQnaServiceImpl {
	 @Autowired
	    private AdminQnaMapper adminQnaMapper;
	   public List<Map<String, Object>> getAllAdminQnas() {
	        return adminQnaMapper.getAllAdminQnas();
	    }
	
}
