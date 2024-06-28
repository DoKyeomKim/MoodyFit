package com.mf.dto;

import lombok.Data;

@Data
public class PostingFileDto {
    private Long postingFileIdx;  
    private String originalName;  
    private String filePath;      
    private String fileSize;      
    private Long postingIdx;      
}
