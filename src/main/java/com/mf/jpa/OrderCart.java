package com.mf.jpa;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "order_cart")
public class OrderCart {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_idx", nullable = false)
    private Orders order;

    @ManyToOne
    @JoinColumn(name = "cart_idx", nullable = false)
    private Cart cart;

    // Constructors, getters, and setters

    public OrderCart() {
    }

    public OrderCart(Orders order, Cart cart) {
        this.order = order;
        this.cart = cart;
    }

}
	