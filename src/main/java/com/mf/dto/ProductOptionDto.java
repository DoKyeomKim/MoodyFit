package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductOptionDto {
	private Long colorIdx;
	private Long sizeIdx;
	private int  quantity;
}
