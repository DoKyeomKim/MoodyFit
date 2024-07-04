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
    List<Map<String, Object>> getAllProductDetailsWithInventory();
    
    // 상세보기 로드
	List<Map<String, Object>> getPostingDetail(Long postingIdx);
	Map<String, Object> getPostingInfo(Long postingIdx);
    void addPostingBuy(@Param("userIdx") Long userIdx, @Param("productInfoIdx") Long productInfoIdx, @Param("postingProductIdx") Long postingProductIdx);
}
