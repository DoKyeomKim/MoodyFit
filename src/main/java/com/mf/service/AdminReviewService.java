package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.dto.AdminReviewDto;
import com.mf.mapper.AdminReviewMapper;

@Service
public class AdminReviewService {
	 @Autowired
	    private AdminReviewMapper adminReviewMapper;
	 public List<AdminReviewDto> getAllAdminReviews() {
		 
        return adminReviewMapper.getAllAdminReviews();
    }
}


