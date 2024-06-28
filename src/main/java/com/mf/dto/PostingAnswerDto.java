package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingAnswerDto {
	
private Long postingAnswerIdx;
private String content;
private Date createDate;
private Long postingQuestionIdx;
private String title;

}
