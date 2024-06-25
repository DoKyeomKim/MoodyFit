package com.mf.jpa;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class ProductQuantity {
	
		@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long productQuantityIdx;

	    private int quantity;

	    @ManyToOne
	    @JoinColumn(name = "product_info_idx")
	    private ProductInfo productInfo;

    // getter, setter 등
}