package com.mf.dto;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonDto {
	private Long userIdx;
	private Long personIdx;
	private String name;
	private String nickName;
	private String email;
	private String phone;
	private String postCode;
	private String address;
	private String detailAddress;
	private String social;
	private String socialRoot;
	private int state;
}
