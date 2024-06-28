package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewLikesDto {
	private Long review_like_idx;
	private Long personIdx;
	private Long postingReviewIdx;
}
