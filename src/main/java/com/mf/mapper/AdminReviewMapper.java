package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminReviewDto;

@Mapper
public interface AdminReviewMapper {


	public List<AdminReviewDto> getAllAdminReviews();

	public List<AdminReviewDto> searchReviewsById(String searchId);

	public void addReview(AdminReviewDto reviewDto);

	public void addReviewFile(AdminReviewDto reviewDto);

	public List<AdminReviewDto> findAll();

	}
