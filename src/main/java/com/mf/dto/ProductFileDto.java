package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductFileDto {
	private Long productFileIdx;
	private String originalName;
	private String filePath;
	private String fileSize;
	private Long productInfoIdx;
}
