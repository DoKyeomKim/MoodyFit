package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonSpecDto {
	private Long personSpecIdx;
	private String gender;
	private String height;
	private String weight;
	private String foot;
	private String top;
	private String bottom;
	private Long personIdx;
}
