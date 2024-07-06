package com.mf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.PostingDto;
import com.mf.dto.PostingFileDto;
import com.mf.dto.PostingProductDto;
import com.mf.mapper.PostingMapper;

import jakarta.transaction.Transactional;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class PostingService {

    @Autowired
    private PostingMapper postingMapper;

    @Transactional
    public void createPosting(PostingDto postingDto, List<Long> productInfoIdxs) {
        postingMapper.insertPosting(postingDto);
        Long postingIdx = postingDto.getPostingIdx();

        // Save content with image URLs
        String content = postingDto.getContent();
        List<String> imageUrls = extractImageUrls(content);

        for (String imageUrl : imageUrls) {
            savePostingFile(postingIdx, imageUrl);
        }

        if (productInfoIdxs != null && !productInfoIdxs.isEmpty()) {
            for (Long productInfoIdx : productInfoIdxs) {
                PostingProductDto postingProductDto = new PostingProductDto();
                postingProductDto.setPostingIdx(postingIdx);
                postingProductDto.setProductInfoIdx(productInfoIdx);
                postingMapper.insertPostingProduct(postingProductDto);
            }
        }
    }

    private void savePostingFile(Long postingIdx, String imageUrl) {
        PostingFileDto postingFileDto = new PostingFileDto();
        postingFileDto.setOriginalName(imageUrl.substring(imageUrl.lastIndexOf('/') + 1));
        postingFileDto.setFilePath(imageUrl);
        postingFileDto.setFileSize("unknown"); // 파일 크기를 알 수 없기 때문에 "unknown"으로 설정
        postingFileDto.setPostingIdx(postingIdx);
        postingMapper.insertPostingFile(postingFileDto);
    }

    private List<String> extractImageUrls(String content) {
        List<String> imageUrls = new ArrayList<>();
        String imgTagPattern = "<img[^>]+src=[\"']([^\"']+)[\"'][^>]*>";
        Pattern pattern = Pattern.compile(imgTagPattern);
        Matcher matcher = pattern.matcher(content);

        while (matcher.find()) {
            imageUrls.add(matcher.group(1));
        }

        return imageUrls;
    }

    public List<Map<String, Object>> getAllProductDetailsWithInventory(Long userIdx) {
        return postingMapper.getAllProductDetailsWithInventory(userIdx);
    }
    
    
    // =============================== 판매글 상세보기 ======================================
    public List<Map<String, Object>> getPostingDetail(Long postingIdx) {
        return postingMapper.getPostingDetail(postingIdx);
    }

	public Map<String, Object> getPostingInfo(Long postingIdx) {
		return postingMapper.getPostingInfo(postingIdx);

	}

	public void addPostingBuy(Long userIdx, Long productInfoIdx, Long postingProductIdx) {
		postingMapper.addPostingBuy(userIdx,productInfoIdx,postingProductIdx);
	}

	public List<Map<String, Object>> getPostingQuestion(Long postingIdx) {
		return postingMapper.getPostingQuestion(postingIdx);
	}
    
	// 기존의 List<Map<String, Object>> 반환
	public List<Map<String, Object>> getAllPostingDetails(Long storeIdx) {
        return postingMapper.getAllPostingDetails(storeIdx);
    }
	

    public List<Map<String, Object>> getOnHoldPostingDetails(Long storeIdx) {
        return postingMapper.getOnHoldPostingDetails(storeIdx);
    }

    public void updatePostingState(Long postingIdx, int state) {
        postingMapper.updatePostingState(postingIdx, state);
    }

	
}
