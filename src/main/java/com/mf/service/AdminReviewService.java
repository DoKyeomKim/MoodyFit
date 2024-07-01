package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.dto.AdminReviewDto;
import com.mf.dto.PostingQuestionDto;
import com.mf.dto.ReviewLikesDto;
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
	
	// 현재 좋아요 상태 확인
	public boolean checkLikes(Long postingReviewIdx, Long userIdx) {
		return adminReviewMapper.checkLikes(postingReviewIdx,userIdx) > 0;
	}
	
	// 좋아요 하기
	public void addLikes(Long userIdx, Long postingReviewIdx) {
		adminReviewMapper.addLikes(userIdx,postingReviewIdx);
	}
	
	// 좋아요 삭제
	public void deleteLikes(Long userIdx, Long postingReviewIdx) {
		adminReviewMapper.deleteLikes(userIdx,postingReviewIdx);
	}
	
	// 좋아요 수 확인(업데이트용)
	public int getReviewLikeCount(Long postingReviewIdx) {
        return adminReviewMapper.getReviewLikeCount(postingReviewIdx);
	}

}

		


