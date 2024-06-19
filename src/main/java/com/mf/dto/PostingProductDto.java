package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingProductDto {
    private Long postingProductIdx;  
    private Long postingIdx;         
    private Long productInfoIdx;

}

