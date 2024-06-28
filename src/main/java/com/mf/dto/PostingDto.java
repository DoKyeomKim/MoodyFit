package com.mf.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostingDto {
    private Long postingIdx;
    private String title;
    private String content;
    private Long productInfoIdx;
    private Long storeIdx;
    private Integer state;
    private List<MultipartFile> postingFiles;
}
