package com.mf.jpa;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface OrdersRepository extends JpaRepository<Orders, Long> {
    @Query("SELECT COALESCE(MAX(o.orderIdx), 0) + 1 FROM Orders o")
    Long getNextOrderIdx();

    @Query("SELECT CONCAT(FUNCTION('TO_CHAR', CURRENT_DATE, 'YYYYMMDD'), '00', COALESCE(MAX(o.orderIdx), 0) + 1) FROM Orders o")
    String generateMerchantUid();

    Orders findByImpUid(String impUid);
    

}
