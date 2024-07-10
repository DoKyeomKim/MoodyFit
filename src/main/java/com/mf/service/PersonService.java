package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.mapper.PersonMapper;
@Service
public class PersonService  implements PagingServiceImpl {
	 @Autowired
	    private PersonMapper personMapper;

	    public List<PersonDto> getAllPersons() {
	        return personMapper.getAllPersons();
	    }

		public void dropUser(Long userIdx) {
			personMapper.dropUser(userIdx);
			
		}
		  @Override
		    public List<PersonDto> getPersons(int offset, int noOfRecords) {
		        return personMapper.getPersons(offset, noOfRecords);
		    }

		    @Override
		    public int getNoOfRecords() {
		        return personMapper.getNoOfRecords();
		    }
		    
		    public List<PersonDto> searchUsersById(String searchId) {
		    	System.out.println("Searching for ID: " + searchId); // 로그 추가
		        return personMapper.searchUsersById(searchId);
		    }
		
}
