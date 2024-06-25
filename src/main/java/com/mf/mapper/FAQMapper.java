package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.mf.dto.CsFaqDto;
@Mapper
public interface FAQMapper {
	void addFAQ(CsFaqDto faqDTO);
	 List<CsFaqDto> getAllFAQs();
	 
	
	
		void updateFAQ(CsFaqDto faq);
		void deleteFAQ(Long faqIdx);
		
		CsFaqDto getFaqByFaqIdx(Long faqIdx);
}