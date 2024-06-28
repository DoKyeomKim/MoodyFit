package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminReviewDto;
import com.mf.dto.ReviewLikesDto;

@Mapper
public interface AdminReviewMapper {


	public List<AdminReviewDto> getAllAdminReviews();

	public List<AdminReviewDto> searchReviewsById(String searchId);

	public void addReview(AdminReviewDto reviewDto);

	public void addReviewFile(AdminReviewDto reviewDto);

	public List<AdminReviewDto> findAll();

	public Long getPersonIdxByUserIdx(Long userIdx);

	public int checkLikes(Long postingReviewIdx, Long userIdx);

	public void deleteLikes(ReviewLikesDto reviewLikesDto);

	public void addLikes(Long userIdx, Long postingReviewIdx);

	public void deleteLikes(Long userIdx, Long postingReviewIdx);

	}
