package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductQuantityDto {
	private Long productQuantityIdx;  
	private int  quantity;
	private String updateDate;
	private Long productInfoIdx;
}
