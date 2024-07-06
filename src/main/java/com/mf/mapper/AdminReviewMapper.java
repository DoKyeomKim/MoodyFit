package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

	public int checkLikes(@Param(value = "userIdx")Long postingReviewIdx, @Param(value = "postingReviewIdx") Long userIdx);

	public void addLikes(@Param(value = "userIdx") Long userIdx, @Param(value = "postingReviewIdx") Long postingReviewIdx);

	public void deleteLikes(@Param(value = "userIdx") Long userIdx, @Param(value = "postingReviewIdx") Long postingReviewIdx);

	public int getReviewLikeCount(Long postingReviewIdx);

	public List<AdminReviewDto> getReviewsStore(Long postingIdx);

	}
