package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EditorPickDto {
	
	private Long pickIdx;
	private String originalName;
	private String filePath;
	private Long fileSize;
	private String startDate;
	private String endDate;
	private Long postingIdx;
}
