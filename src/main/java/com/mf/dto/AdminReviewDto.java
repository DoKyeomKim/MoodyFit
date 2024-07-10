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
    private String height;
    private String weight;
    private String sizes;
    private String foot;
    private int colorSatis;
    private int sizesSatis;
    private Long postingIdx;
    private Long personIdx;
    private String filePath;
    private String originalName;
    private Long fileSize;
    private Long postingReviewFileIdx;
    private int reviewLikeCount;
}
