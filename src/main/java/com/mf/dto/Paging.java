package com.mf.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Paging {
    private int totalPages;
    private int startPageNum;
    private int endPageNum;
    private boolean prev;
    private boolean next;
    private String keyword;
}