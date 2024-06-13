package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.mapper.PersonMapper;
@Service
public class PersonService {
	 @Autowired
	    private PersonMapper personMapper;

	    public List<PersonDto> getAllPersons() {
	        return personMapper.getAllPersons();
	    }

		public void dropUser(Long userIdx) {
			personMapper.dropUser(userIdx);
			
		}

	
}
