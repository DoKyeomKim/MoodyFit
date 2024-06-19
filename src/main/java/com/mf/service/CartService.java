package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.dto.PersonDto;

import jakarta.servlet.http.HttpSession;

@Service
public class CartService {

	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MyPageService myPageService;

    @Transactional
    public void updateCartAndCreateOrder(List<Long> selectedItems, Map<String, String> allParams, Long personIdx) {
    	
    	
    	
    	// 1. 장바구니 항목 업데이트
        for (Long cartIdx : selectedItems) {
            int quantity = Integer.parseInt(allParams.get("quantity_" + cartIdx));
            double price = Double.parseDouble(allParams.get("price_" + cartIdx));

            String updateCartSql = "UPDATE cart SET quantity = ?, price = ?, state = '결제중' WHERE cart_idx = ?";
            jdbcTemplate.update(updateCartSql, quantity, price, cartIdx);
        }
        /*
        // 2. 주문 생성 로직
        // 장바구니에 담긴 상품들의 총 가격과 수량 계산
        String totalPriceSql = "SELECT SUM(TO_NUMBER(price)) FROM cart WHERE state = '결제중'";
        Double totalPrice = jdbcTemplate.queryForObject(totalPriceSql, Double.class, selectedItems);

        String totalQuantitySql = "SELECT SUM(TO_NUMBER(quantity)) FROM cart WHERE state = '결제중'";
        Integer totalQuantity = jdbcTemplate.queryForObject(totalQuantitySql, Integer.class, selectedItems);

        // 주문에 필요한 값 설정
        double deliveryPrice = 1000; // 배송비
        double totalOrderPrice = totalPrice + deliveryPrice; // 총 주문 가격

        String insertOrderSql = "INSERT INTO orders (price, quantity, merchant_uid, delivery_price, total_price, order_date, imp_uid, person_idx, delivery_idx) " +
                                "VALUES (?, ?, ?, ?, ?, SYSDATE, ?, ?, ?)";
        jdbcTemplate.update(insertOrderSql,
                totalPrice,           // 장바구니에 담긴 상품들의 총 가격
                totalQuantity,        // 장바구니에 담긴 상품들의 총 수량
                "merchantUid",        // 임시 값
                deliveryPrice,        // 배송비
                totalOrderPrice,      // 총 주문 가격
                "impUid",             // 임시 값
                personIdx,                    // person_idx 예시 값
                1                     // delivery_idx 예시 값
        );

        // 3. 생성된 order_idx 가져오기
        Long orderId = jdbcTemplate.queryForObject("SELECT order_seq.currval FROM dual", Long.class);

        // 4. order_cart 테이블에 데이터 입력
        for (Long cartIdx : selectedItems) {
            String insertOrderCartSql = "INSERT INTO order_cart (order_idx, cart_idx) VALUES (?, ?)";
            jdbcTemplate.update(insertOrderCartSql, orderId, cartIdx);
        }
        */
    }
}