package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.mapper.PostingMapper;

@Service
public class PostingService {
	 @Autowired
	    private PostingMapper postingMapper;
	   public List<Map<String, Object>> getAllPostings() {
	        return postingMapper.getAllPostings();
	    }

}
