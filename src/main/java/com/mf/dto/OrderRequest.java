package com.mf.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderRequest {
	
	 // insertOrder 
	private String test;
    private int price;
    private int quantity;
    private int deliveryPrice;
    private int totalPrice;
    private Long deliveryIdx;
    private Long personIdx; 
   
	/*
    private BigDecimal price; // 폼에서 name="price"에 해당
    private int quantity; // 폼에서 name="quantity"에 해당
    private BigDecimal deliveryPrice; // 폼에서 name="deliveryPrice"에 해당
    private BigDecimal totalPrice; // 폼에서 id="finalPrice"에 해당
    private Long deliveryIdx; // 배송지 인덱스
    private Long personIdx; // 사용자 인덱스
    
    
    private String impUid;
    private String merchantUid;
    private int orderIdx;
    private String orderDate;
    private String state;
    private Long itemId;
    private String title;
    private String name;
    private int cartIdx;
    private String postCode;
    private String address;
    private String detailAddress;
    private String content;
    private String deliveryName;
*/
}
