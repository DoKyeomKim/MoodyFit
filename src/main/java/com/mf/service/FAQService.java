package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CsFaqDto;
import com.mf.mapper.FAQMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FAQService {
	 @Autowired
	    private FAQMapper faqMapper;

	 public void addFAQ(CsFaqDto faqDTO) {
	        try {
	            faqMapper.addFAQ(faqDTO);
	            log.info("FAQ successfully added: " + faqDTO);
	        } catch (Exception e) {
	            log.error("Error adding FAQ: " + e.getMessage());
	        }
	    }
	  public List<CsFaqDto> getAllFAQs() {
	        return faqMapper.getAllFAQs();
	    }
	  public CsFaqDto getFaqById(int id) {
	        return faqMapper.getFaqById(id);
	    }
	
	}

	



