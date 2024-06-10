package com.mf.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.mapper.MyPageMapper;

@Service
public class MyPageService {
	@Autowired
	private MyPageMapper myPageMapper;

	public Map<String, Object> getPersonMyPage(Long userIdx) {
		// 닉네임과 personIdx 갖고오기
		PersonDto person = myPageMapper.getNickNameByUserIdx(userIdx);
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("person", person);
		
		return result;
	}
}
