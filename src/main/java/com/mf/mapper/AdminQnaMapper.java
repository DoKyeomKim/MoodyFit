package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminAnswerDto;
import com.mf.dto.AdminQuestionDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.CsQnaDto;
import com.mf.dto.PostingAnswerDto;
import com.mf.dto.PostingQuestionDto;
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


		void addQuestion2(PostingQuestionDto qna2dto);


		List<Map<String, Object>> getAllQna2s();


		PostingQuestionDto getQna2ByquestionIdx(Long postingQuestionIdx);


		List<PostingAnswerDto> getAnswers2ByPostingQuestionIdx(Long postingQuestionIdx);


		void insertAnswer2(PostingAnswerDto answer2Dto);
	}

	
			
		

	

