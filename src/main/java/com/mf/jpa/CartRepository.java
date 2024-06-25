package com.mf.jpa;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface CartRepository extends JpaRepository<Cart, Integer> {

	Optional<Cart> findById(Integer cartIdx);
    // 추가 쿼리 메서드 선언
	
	 @Transactional
	    @Modifying
	    @Query("UPDATE Cart c SET c.state = '결제완료' WHERE c.cartIdx IN :cartIdxs")
	    void updateCartStateToComplete(Integer cartIdx);

	// void updateCartStateToComplete(Integer cartIdx);

}
