package com.mf.jpa;

import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class Cart {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cartIdx;

    private int quantity;

    @ManyToOne
    @JoinColumn(name = "product_info_idx")
    private ProductInfo productInfo;
    
    @Column(name = "state")
    private String state;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL)
    private Set<OrderCart> orderCarts;

    // getter, setter 등
}