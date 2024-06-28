package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.mf.dto.DeliveryDto;
import com.mf.mapper.OrderMapper;

@Service
public class DeliveryService {

	
	private final OrderMapper orderMapper;
	
	@Autowired
    public DeliveryService(OrderMapper orderMapper) {
        this.orderMapper = orderMapper;
    }
	
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MyPageService myPageService;

	public DeliveryDto getDeliveryById(Long deliveryIdx) {
        return orderMapper.selectDelivery3(deliveryIdx); // DeliveryMapper를 통해 데이터베이스에서 데이터 조회
    }


   
	
}