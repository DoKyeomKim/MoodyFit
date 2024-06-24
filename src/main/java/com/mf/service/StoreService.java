package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;
import com.mf.mapper.StoreMapper;
import com.mf.mapper.UsersMapper;

@Service
public class StoreService {
	 @Autowired
	    private StoreMapper storeMapper;
	

	    public List<StoreDto> getAllStores() {
	        return storeMapper.getAllStores();
	    }

		public void dropUser(Long userIdx) {
		
			storeMapper.dropUser(userIdx);
		}

		  public List<StoreDto> searchStoresById(String searchId) {
		    	System.out.println("Searching for ID: " + searchId); // 로그 추가
		        return storeMapper.searchStoresById(searchId);
		    }

		

	
		}

		


