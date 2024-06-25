package com.mf.dto;

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
		private int state;
		private Long qnaIdx;
		private Long userIdx;
		private String id;
}
