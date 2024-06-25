package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WishDto {
	private Long wishIdx;
	private Long personIdx;
	private Long postingIdx;
}
