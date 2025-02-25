package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductInfoDto {
    private Long productInfoIdx;                   
    private Long productColorIdx;    
    private Long productSizeIdx;     
    private Long productIdx;              
    private Integer quantity;
    private String color;
    private String sizes;
}
