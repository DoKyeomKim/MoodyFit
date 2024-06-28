package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminSalesDto;

@Mapper
public interface AdminSalesMapper {

	List<AdminSalesDto> getAllAdminSaless();

	List<AdminSalesDto> searchSalessById(String searchId);

	int getTotalOrderCount();

	double getTotalRevenue();

}
