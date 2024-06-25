package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminOrderDto;
import com.mf.mapper.AdminOrderMapper;

@Service
public class AdminOrderService {
	 @Autowired
	    private AdminOrderMapper adminOrderMapper;
	 public List<AdminOrderDto> getAllAdminOrders() {
	        return adminOrderMapper.getAllAdminOrders();
	}
	public List<AdminOrderDto> searchOrdersById(String searchId) {

		return adminOrderMapper.searchOrdersById(searchId);
	}

	}
