package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDto {
	
	private int cartIdx;
	private int price;
	private int quantity;
	private Long userIdx;
	private String state;
	
	private int orderIdx;
	private String merchantUid;
	private String deliveryPrice;
	private int totalPrice;
	private String orderDate;
	private String impUid;
	private int personIdx;
	private int deliveryIdx;
	private String dename;
	private String email;
	private String phone;
	private String postcode;
	private String address;
	private String detailAddress;

	private String title;
	private String name;
	private String filePath;
	

}
