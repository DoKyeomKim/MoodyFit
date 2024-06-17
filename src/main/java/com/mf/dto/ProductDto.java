package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
    private Long productIdx;     
    private String name;
    private String manufactureName;
    private int price;
    private Long subCategoryIdx;     
    private Long storeIdx;           
}
