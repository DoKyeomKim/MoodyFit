package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailsDto {
	private Long productIdx;
	private Long productInfoIdx;
	private Long subCategoryIdx;
	private Long storeIdx;
	private Long productColorIdx;
	private Long productSizeIdx;
    private String name;              
    private int price;                
    private String manufactureName;   
    private String color;             
    private String size;              
    private String category;          
    private String subCategory;       
    private int quantity;     
    private String updateDate;          
}
