package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
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
}
