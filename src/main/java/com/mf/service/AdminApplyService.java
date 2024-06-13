package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminApplyDto;
import com.mf.mapper.AdminApplyMapper;
@Service
public class AdminApplyService {
	 @Autowired
	    private AdminApplyMapper adminApplyMapper;
	 public List<AdminApplyDto> getAllAdminApplys() {
	        return adminApplyMapper.getAllAdminApplys();
	}
	public void updateStatus(Long postingIdx, String state) {
		
			adminApplyMapper.updateStatus(postingIdx, state);
		}

	

}

