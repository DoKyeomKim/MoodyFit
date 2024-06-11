package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminReviewDto;
import com.mf.dto.CsFaqDto;
import com.mf.mapper.AdminReviewMapper;
import com.mf.mapper.FAQMapper;

@Service
public class AdminReviewService {
	 @Autowired
	    private AdminReviewMapper adminReviewMapper;
	 public List<AdminReviewDto> getAllAdminReviews() {
		 
        return adminReviewMapper.getAllAdminReviews();
    }

	}


