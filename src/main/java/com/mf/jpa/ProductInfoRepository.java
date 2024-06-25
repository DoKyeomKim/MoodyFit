package com.mf.jpa;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProductInfoRepository extends JpaRepository<ProductInfo, Long> {
    // 추가 쿼리 메서드 선언

}
