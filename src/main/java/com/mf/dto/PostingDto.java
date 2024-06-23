package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingDto {
    private Long postingIdx;
    private String title;
    private String content;
    private Long productInfoIdx;
    private Long storeIdx;
    private Integer state;
    	
}
