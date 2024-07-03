package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.PostingDto;
import com.mf.dto.PostingFileDto;
import com.mf.dto.PostingProductDto;
import com.mf.mapper.PostingMapper;

import jakarta.transaction.Transactional;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class PostingService {

    @Autowired
    private PostingMapper postingMapper;

    @Transactional
    public void createPosting(PostingDto postingDto, String productInfoIdxs) {
        postingMapper.insertPosting(postingDto);
        Long postingIdx = postingDto.getPostingIdx();

        if (postingDto.getPostingFiles() != null && !postingDto.getPostingFiles().isEmpty()) {
            for (MultipartFile file : postingDto.getPostingFiles()) {
                savePostingFile(postingIdx, file);
            }
        }

        if (productInfoIdxs != null && !productInfoIdxs.isEmpty()) {
            String[] productInfoIdxArray = productInfoIdxs.split(", ");
            for (String productInfoIdx : productInfoIdxArray) {
                PostingProductDto postingProductDto = new PostingProductDto();
                postingProductDto.setPostingIdx(postingIdx);
                postingProductDto.setProductInfoIdx(Long.parseLong(productInfoIdx));
                postingMapper.insertPostingProduct(postingProductDto);
            }
        }
    }

    private void savePostingFile(Long postingIdx, MultipartFile file) {
        if (file.isEmpty()) {
            return;
        }

        String originalFileName = file.getOriginalFilename();
        String newFileName = System.currentTimeMillis() + "_" + originalFileName;
        String filePath = "/Users/sinminjae/dev/postingImage/" + newFileName;

        try {
            File dest = new File(filePath);
            file.transferTo(dest);

            PostingFileDto postingFileDto = new PostingFileDto();
            postingFileDto.setOriginalName(originalFileName);
            postingFileDto.setFilePath(filePath);
            postingFileDto.setFileSize(String.valueOf(file.getSize()));
            postingFileDto.setPostingIdx(postingIdx);
            postingMapper.insertPostingFile(postingFileDto);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, Object>> getAllProductDetailsWithInventory() {
        return postingMapper.getAllProductDetailsWithInventory();
    }
}
