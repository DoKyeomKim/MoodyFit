package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.PersonDto;
@Mapper
public interface PersonMapper {
    List<PersonDto> getAllPersons();

	void dropUser(Long userIdx);
	 List<PersonDto> getPersons(@Param("offset") int offset, @Param("noOfRecords") int noOfRecords);
	    int getNoOfRecords();
	    List<PersonDto> searchUsersById(@Param("searchId") String searchId);

		List<PersonDto> selectPerson(Long userIdx);
	    
}
