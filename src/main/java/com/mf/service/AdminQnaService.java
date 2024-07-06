package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.AdminAnswerDto;
import com.mf.dto.AdminQuestionDto;
import com.mf.dto.CsFaqDto;
import com.mf.dto.CsQnaDto;
import com.mf.dto.PostingAnswerDto;
import com.mf.dto.PostingQuestionDto;
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

	public AdminQuestionDto getQnaByquestionIdx(Long questionIdx) {

		return adminQnaMapper.getQnaByquestionIdx(questionIdx);
	}
	
	 public void addAnswer(AdminAnswerDto answerDto) {
	        adminQnaMapper.insertAnswer(answerDto);
	    }

	    public List<AdminAnswerDto> getAnswersByQuestionIdx(Long questionIdx) {
	        return adminQnaMapper.getAnswersByQuestionIdx(questionIdx);
	    }

		public List<AdminQuestionDto> searchQnasById(String searchId) {
			
			return adminQnaMapper.searchQnasById(searchId);
		}

		 public int qna1(Long questionIdx) {
		        return adminQnaMapper.qna1(questionIdx);
		    }

		 public void addQuestion2(PostingQuestionDto qna2dto, Long personIdx) {
		        qna2dto.setPersonIdx(personIdx);
		        adminQnaMapper.addQuestion2(qna2dto);		    
		    }

		public List<Map<String, Object>> getAllQna2s(Long userIdx) {
			
			return adminQnaMapper.getAllQna2s(userIdx);
		}

		public PostingQuestionDto getQna2ByPostingQuestionIdx(Long postingQuestionIdx) {
			
			return adminQnaMapper.getQna2ByquestionIdx(postingQuestionIdx);
		}

		public List<PostingAnswerDto> getAnswers2ByPostingQuestionIdx(Long postingQuestionIdx) {
			
			return adminQnaMapper.getAnswers2ByPostingQuestionIdx(postingQuestionIdx);
		}

		public void addAnswer2(PostingAnswerDto answer2Dto) {
			adminQnaMapper.insertAnswer2(answer2Dto);
			
		}

		public Long getPersonIdxByUserIdx(Long userIdx) {
			return adminQnaMapper.getPersonIdxByUserIdx(userIdx);
		}

		public List<Map<String, Object>> getUsersQnas(Long userIdx) {
			return adminQnaMapper.getUsersQnas(userIdx);
		}

		public List<Map<String, Object>> getAllStoreQna(Long userIdx) {
			return adminQnaMapper.getAllStoreQna(userIdx);
		}

	
	

	
		
}
