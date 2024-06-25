package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.jaxb.SpringDataJaxb.OrderDto;

import com.mf.dto.CartDto;
import com.mf.dto.DeliveryDto;
import com.mf.dto.OrderDetailDto;
import com.mf.dto.OrderRequest;
import com.mf.dto.OrdersDto;

@Mapper
public interface OrderMapper {

	List<CartDto> selectCart(Long userIdx);

	List<CartDto> selectCart2(Long userIdx);

	List<DeliveryDto> selectDelivery(Long userIdx);

	void insertOrderDetail(OrderDetailDto orderDetailDto);

	OrdersDto selectOrder(Long userIdx);

	Integer selectPrice(OrdersDto ordersDto);

	void insertDelivery(DeliveryDto deliveryDto);

	int selectPersonIdx(Long userIdx);

	Long selectTotalPrice(Long userIdx);

	DeliveryDto selectDelivery2(Long userIdx);

	OrdersDto selectOrderList(Long userIdx);

	void updateImpUid(String impUid);

	void insertOrder(OrderRequest orderRequest);

	 void updateImpUid(@Param("impUid") String impUid, @Param("personIdx") Long personIdx);

	List<Integer> selectCartIdxByImpUid(String impUid);

	void updateCartStateToComplete(Integer cartIdx);
	

}
