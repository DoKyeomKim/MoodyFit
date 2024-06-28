package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminSalesDto {
 private String storeName;
 private String orderCount;
 private Long totalPrice;
 
}
