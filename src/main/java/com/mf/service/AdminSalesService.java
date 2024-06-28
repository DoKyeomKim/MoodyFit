package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminSalesDto;
import com.mf.mapper.AdminSalesMapper;

@Service
public class AdminSalesService {

	@Autowired AdminSalesMapper adminSalesMapper;
	
	public List<AdminSalesDto> getAllSaless() {
		return adminSalesMapper.getAllAdminSaless();
	}

	public List<AdminSalesDto> searchSalessById(String searchId) {
		return adminSalesMapper.searchSalessById(searchId);
	}

	public int getTotalOrderCount() {
		return adminSalesMapper.getTotalOrderCount();
	
	}

	public double getTotalRevenue() {
		return adminSalesMapper.getTotalRevenue();
	}


}
