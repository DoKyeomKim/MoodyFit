package com.mf.jpa;

import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProductQuantityRepository extends JpaRepository<ProductQuantity, Long> {

	Optional<ProductQuantity> findByProductInfo(ProductInfo productInfo);
    // 추가 쿼리 메서드 선언

}
