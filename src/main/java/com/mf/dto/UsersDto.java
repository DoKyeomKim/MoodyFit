package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UsersDto {
	private Long userIdx;
	private String id;
	private String pw;
	private Long state;
	private String role; 
	
	
}
