package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.domain.jaxb.SpringDataJaxb.OrderDto;

import com.mf.dto.CartDto;
import com.mf.dto.DeliveryDto;
import com.mf.dto.OrderDetailDto;
import com.mf.dto.OrdersDto;

@Mapper
public interface OrderMapper {

	List<CartDto> selectCart(Long userIdx);

	List<CartDto> selectCart2(Long userIdx);

	List<DeliveryDto> selectDelivery(Long userIdx);

	void insertOrderDetail(OrderDetailDto orderDetailDto);

	List<OrdersDto> selectOrder(Long userIdx);

	Integer selectPrice(OrdersDto ordersDto);

	void insertDelivery(DeliveryDto deliveryDto);

	int selectPersonIdx(Long userIdx);

	void selectTotalPrice(OrdersDto ordersDto);

	DeliveryDto selectDelivery2(Long userIdx);
	

}
