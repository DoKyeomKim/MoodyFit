package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminReviewDto {
 private Long postingReviewIdx;
 private String title;
 private String content;
 private int rating;
 private Date createDate;
}
