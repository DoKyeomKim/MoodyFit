package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NearbyDto {
	private Long productIdx;
	private Long subCategoryIdx;
	private Long storeIdx;
    private String name;
    private Integer price;
    private String manufactureName;
    private String color;
    private String sizes;
    private Integer quantity;
    private String filePaths;
    
    private Long postingIdx;
    private String storeName;
    private String title;
    private String address;
    private String detailAddress;
    private String filePath;
    private String engName;
    private Date updateDate;
    private Long rating;
    private Long reviewCount;
    
}
