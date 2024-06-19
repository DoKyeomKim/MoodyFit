package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminReviewDto;

@Mapper
public interface AdminReviewMapper {


	public List<AdminReviewDto> getAllAdminReviews();

	}
