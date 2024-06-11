package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.CsFaqDto;
@Mapper
public interface FAQMapper {
	void addFAQ(CsFaqDto faqDTO);
	 List<CsFaqDto> getAllFAQs();
	 
	  CsFaqDto getFaqById(@Param("id") int id);
}