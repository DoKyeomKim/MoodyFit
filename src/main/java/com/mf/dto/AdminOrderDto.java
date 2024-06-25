package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminOrderDto {

	    private Long orderIdx;
	    private int amount;
	    private double deliveryPrice;
	    private double totalPrice;
	    private Date orderDate;
	    private double price;
	    private String name;	    
	    private Long orderDetailIdx;
	    private String id;
}
