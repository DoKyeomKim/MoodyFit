package com.mf.jpa;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Setter
@Getter
@Entity
public class Orders {
	
    @Id
    private Long orderIdx;

    private int price;
    private int quantity;
    private String merchantUid;
    private int deliveryPrice;
    private int totalPrice;
    private LocalDateTime orderDate;
    private Long personIdx;
    private String state;
    private String impUid;
    private Long deliveryIdx;

    // Getters and Setters
    // ...
    // Constructor with fields
    public Orders(Long orderIdx, int price, int quantity, String merchantUid, int deliveryPrice, int totalPrice, LocalDateTime orderDate, Long personIdx, String state, String string, Long deliveryIdx) {
        this.orderIdx = orderIdx;
    	this.price = price;
        this.quantity = quantity;
        this.merchantUid = merchantUid;
        this.deliveryPrice = deliveryPrice;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.personIdx = personIdx;
        this.state = state;
        this.deliveryIdx = deliveryIdx;
    }
// 다른 필드들...
    
//    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
//    private List<OrderCart> orderCarts;
//
//    // 생성자, getter, setter 등 필요한 메서드들...
//
//    public List<OrderCart> getOrderCarts() {
//        return orderCarts;
//    }
//    
//    public void setOrderCarts(List<OrderCart> orderCarts) {
//        this.orderCarts = orderCarts;
//    }
}