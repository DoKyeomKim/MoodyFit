package com.mf.jpa;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface OrderCartRepository extends JpaRepository<OrderCart, Long> {
/*
	  @Modifying
	    @Transactional
	    @Query(value = "INSERT INTO order_cart (order_idx, cart_idx) VALUES (:orderIdx, :cartIdx)", nativeQuery = true)
	    void insertOrderCart(@Param("orderIdx") Long orderIdx, @Param("cartIdx") Integer cartIdx);
	  */
	  @Modifying
	  @Transactional
	  @Query(value = "INSERT INTO order_cart (order_idx, cart_idx) VALUES (?1, ?2)", nativeQuery = true)
	  void insertOrderCart(Long orderIdx, Integer cartIdx);

	// List<OrderCart> findByOrder_OrderIdx(Long orderIdx);
	
//	  @Query(value = "SELECT oc.cart_idx FROM order_cart oc WHERE oc.order_idx = ?1", nativeQuery = true)
//	    List<OrderCart> findOrderCartsByOrderIdx(Long orderIdx);
	
	  // void save(Long orderIdx, Integer cartIdx);
}
