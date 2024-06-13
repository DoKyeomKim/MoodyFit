package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDto {
	
	private int cartIdx;
	private int cartQuantity;
	private int productInfoIdx;
	private int personIdx;
	private int price;
	private Long userIdx;
	private String title;
	private String name;
	private String filePath;
	
	
}
