package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.PostingDto;
import com.mf.dto.PostingFileDto;
import com.mf.dto.PostingProductDto;

@Mapper
public interface PostingMapper {
    void insertPosting(PostingDto postingDto);
    void insertPostingProduct(PostingProductDto postingProductDto);
    void insertPostingFile(PostingFileDto postingFileDto);
    List<Map<String, Object>> getAllProductDetailsWithInventory(Long userIdx);
    
    List<Map<String, Object>> getAllPostingDetails(Long storeIdx);
	List<Map<String, Object>> getOnHoldPostingDetails(Long storeIdx);
	void updatePostingState(@Param("postingIdx") Long postingIdx, @Param("state") int state);

    
    // 상세보기 로드
	List<Map<String, Object>> getPostingDetail(Long postingIdx);
	Map<String, Object> getPostingInfo(Long postingIdx);
    void addPostingBuy(@Param("userIdx") Long userIdx, @Param("productInfoIdx") Long productInfoIdx, @Param("postingProductIdx") Long postingProductIdx);
	List<Map<String, Object>> getPostingQuestion(Long postingIdx);
}
