package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryDto {
	

	private Long userIdx;
	private int deliveryIdx;
	private String name;
	private String deliveryName;
	private String email;
	private String phone;
	private String postCode;
	private String address;
	private String detailAddress;
	private String content;
	private int personIdx;
	
	
	
	
	
}
