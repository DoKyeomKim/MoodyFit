package com.mf.jpa;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class ProductInfo {
	 @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long productInfoIdx;

	    // Other fields and relationships

	    @OneToMany(mappedBy = "productInfo")
	    private List<ProductQuantity> quantities;

	    
	    
    // getter, setter 등
}