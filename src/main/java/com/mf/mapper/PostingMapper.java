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

	 void insertPostingProduct(@Param("postingIdx") Long postingIdx, @Param("productInfoIdx") Long productInfoIdx);

    void insertPostingFile(PostingFileDto postingFileDto);
    
    // posting_product 테이블에 해당 제품 정보 삽입
    void insertPostingProduct(PostingProductDto postingProductDto);
    
    List<Map<String, Object>> getAllProductDetailsWithInventory();
    
	
	List<PostingProductDto> getPostingProduct(Long userIdx);
}


