package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewFileDto {
private Long postingReviewFileIdx;
private String filePath;
private String originalName;
private String fileSize;
private Long postingReviewIdx;
}
