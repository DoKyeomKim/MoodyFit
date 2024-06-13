package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDto {
	
	private int cartIdx;
	private int orderDetailIdx;
	private int price;
	private int quantity;
	private Long userIdx;
	private String state;

	
	
	
	
	
	
}
