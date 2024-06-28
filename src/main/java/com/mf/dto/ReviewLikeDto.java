package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewLikeDto {
		private Long reviewLikeIdx;
		private Long personIdx;
		private Long postingReviewIdx;
}
