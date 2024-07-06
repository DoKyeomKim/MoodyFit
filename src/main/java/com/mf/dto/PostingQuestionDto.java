package com.mf.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingQuestionDto {
		private Long postingQuestionIdx;
		private String title;
		private String content;
		private int state;
		private Long personIdx;
		private Long postingIdx;
		private Long userIdx;
		private Date createDate;
		private String name;
}
