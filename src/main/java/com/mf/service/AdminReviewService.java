package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.dto.AdminReviewDto;
import com.mf.dto.PostingQuestionDto;
import com.mf.mapper.AdminReviewMapper;

@Service
public class AdminReviewService {
	 @Autowired
	    private AdminReviewMapper adminReviewMapper;
	 public List<AdminReviewDto> getAllAdminReviews() {
		 
        return adminReviewMapper.getAllAdminReviews();
    }
	public List<AdminReviewDto> searchReviewsById(String searchId) {
		// TODO Auto-generated method stub
		return adminReviewMapper.searchReviewsById(searchId);
	}
	public void addReview(AdminReviewDto reviewDto) {

	adminReviewMapper.addReview(reviewDto);
	
	}
	public void addReviewFile(AdminReviewDto reviewDto) {
		
		adminReviewMapper.addReviewFile(reviewDto);
	}
	public List<AdminReviewDto> getAllReviews() {
        return adminReviewMapper.findAll();
    }
	public Long getPersonIdxByUserIdx(Long userIdx) {
		
		return adminReviewMapper.getPersonIdxByUserIdx(userIdx);
	}

	}

		


