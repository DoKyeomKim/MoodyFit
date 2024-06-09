package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonSpecDto {
	private Long personSpecIdx;
	private Long gender;
	private Long height;
	private Long weight;
	private Long foot;
	private String top;
	private String bottom;
	private Long personIdx;
}
