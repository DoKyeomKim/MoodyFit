package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductColorDto {
    private Long productColorIdx; // 색상 고유번호
    private String color;         // 색상 이름
}
