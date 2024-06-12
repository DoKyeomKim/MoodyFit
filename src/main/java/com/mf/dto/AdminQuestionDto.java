package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminQuestionDto {
		private Long questionIdx;
		private String title;
		private String content;
		private Date createDate;
		private Date updateDate;
		private int state;
		
		
}
