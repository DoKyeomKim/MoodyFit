package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreDto {
	private Long storeIdx;
	private String storeName;
	private String managerName;
	private String businessNumber;
	private String email;
	private String phone;
	private String postCode;
	private String address;
	private String detailAddress;
	private Long userIdx;
}
