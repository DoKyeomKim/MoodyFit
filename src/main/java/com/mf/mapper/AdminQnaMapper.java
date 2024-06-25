package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminAnswerDto;
import com.mf.dto.AdminQuestionDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.CsQnaDto;
@Mapper
public interface AdminQnaMapper {


	    List<Map<String, Object>> getAllAdminQnas();

	  
	void addQuestion(AdminQuestionDto qnaDTO);


	void setCsQna(CsQnaDto csQna);


	AdminQuestionDto getQnaByquestionIdx(Long questionIdx);


	List<AdminAnswerDto> getAnswersByQuestionIdx(Long questionIdx);


	void insertAnswer(AdminAnswerDto answerDto);


	List<AdminQuestionDto> searchQnasById(String searchId);



	    int qna1(Long questionIdx);
	}

	
			
		

	

