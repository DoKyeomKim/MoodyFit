package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonLevelDto {
	private Long levelIdx; 
	private String name; 
	private Long purchase; 
	private Double benefit;
}
