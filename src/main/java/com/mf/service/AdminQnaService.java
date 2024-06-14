package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminQuestionDto;
import com.mf.dto.CsFaqDto;
import com.mf.dto.CsQnaDto;
import com.mf.mapper.AdminQnaMapper;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminQnaService {
	@Autowired
	private AdminQnaMapper adminQnaMapper;

	public List<Map<String, Object>> getAllAdminQnas() {
		return adminQnaMapper.getAllAdminQnas();
	}

	@Transactional
	public void addQuestion(AdminQuestionDto qnaDTO, Long userIdx, CsQnaDto csQna) {
		adminQnaMapper.setCsQna(csQna);
		qnaDTO.setUserIdx(userIdx);
		adminQnaMapper.addQuestion(qnaDTO);
	}

}
