package com.mf.service;

import java.util.List;

import com.mf.dto.PersonDto;

public interface PagingServiceImpl {
	 List<PersonDto> getPersons(int offset, int noOfRecords);
	    int getNoOfRecords();
}
