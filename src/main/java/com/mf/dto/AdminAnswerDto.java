package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminAnswerDto {
	private Long answerIdx;
	private String title;
	private String content;
	private Date createDate;
	private Date updateDate;
	
}
