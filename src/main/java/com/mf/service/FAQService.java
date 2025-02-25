package com.mf.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminQuestionDto;
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
	  public CsFaqDto getFaqByFaqIdx(Long faqIdx) {
	        return faqMapper.getFaqByFaqIdx(faqIdx);
	    }

	  public void updateFAQ(CsFaqDto faq) {
	        faqMapper.updateFAQ(faq);
	    }

	    public void deleteFAQ(Long faqIdx) {
	        faqMapper.deleteFAQ(faqIdx);
	    }
		public List<AdminQuestionDto> searchFaqsById(String searchId) {
			// TODO Auto-generated method stub
			return faqMapper.searchFaqsById(searchId);
		}

		
	}
	   
	

	



