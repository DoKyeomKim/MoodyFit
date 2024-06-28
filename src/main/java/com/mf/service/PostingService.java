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
    public void addPosting(PostingDto postingDto) {
    	// null 값일 경우 기본 storeIdx 설정
    	if (postingDto.getStoreIdx() == null) {
    		throw new IllegalArgumentException("storeIdx cannot be null");
        }
    	
    	// posting 테이블에 새로운 판매글 삽입
    	postingMapper.insertPosting(postingDto);
    	
    	// posting_product 테이블에 해당 제품 정보 삽입
        if (postingDto.getProductInfoIdx() != null) {
            PostingProductDto postingProductDto = new PostingProductDto();
            postingProductDto.setPostingIdx(postingDto.getPostingIdx());
            postingProductDto.setProductInfoIdx(postingDto.getProductInfoIdx());
            postingMapper.insertPostingProduct(postingProductDto);
        }
    }
    
    public List<PostingProductDto> getPostingProduct(Long userIdx) {
		return postingMapper.getPostingProduct(userIdx);
	}
    
    
    @Transactional
    public void createPosting(PostingDto postingDto) {
        postingMapper.insertPosting(postingDto);

        Long postingIdx = postingDto.getPostingIdx();

        // 파일 저장 및 DB에 파일 정보 삽입
        if (postingDto.getPostingFiles() != null && !postingDto.getPostingFiles().isEmpty()) {
            for (MultipartFile file : postingDto.getPostingFiles()) {
                savePostingFile(postingIdx, file);
            }
        }

        if (postingDto.getProductInfoIdx() != null) {
            PostingProductDto postingProductDto = new PostingProductDto();
            postingProductDto.setPostingIdx(postingIdx);
            postingProductDto.setProductInfoIdx(postingDto.getProductInfoIdx());
            postingMapper.insertPostingProduct(postingProductDto);
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

            // 파일 정보를 DB에 저장
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

    
    // 상품 상세 정보 & 다중 레코드 정보 로드
  	public List<Map<String, Object>> getAllProductDetailsWithInventory() {
  		return postingMapper.getAllProductDetailsWithInventory();
  	}
    
    // 비동기로 상품 정보 로드
	public Map<String, Object> getProductDetailsByProductIdx(Long productIdx) {
		return postingMapper.getProductDetailsByProductIdxForPosting(productIdx);
	}
	
}
