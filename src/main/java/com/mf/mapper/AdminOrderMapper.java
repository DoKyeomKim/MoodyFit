package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminOrderDto;

@Mapper
public interface AdminOrderMapper {

	List<AdminOrderDto> getAllAdminOrders();
}
