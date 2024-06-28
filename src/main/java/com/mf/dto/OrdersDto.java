package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDto {
	
	private int cartIdx;
	private int price;
	private int quantity;
	private Long userIdx;
	private String state;
	
	private Long orderIdx;
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
	
	 public Long getOrderIdx() {
	        return orderIdx;
	    }

	    public void setOrderIdx(Long orderIdx) {
	        this.orderIdx = orderIdx;
	    }

	    public String getTitle() {
	        return title;
	    }

	    public void setTitle(String title) {
	        this.title = title;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public int getPrice() {
	        return price;
	    }

	    public void setPrice(int price) {
	        this.price = price;
	    }

	    public String getFilePath() {
	        return filePath;
	    }

	    public void setFilePath(String filePath) {
	        this.filePath = filePath;
	    }

}
