package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.PostingDto;
import com.mf.dto.PostingFileDto;
import com.mf.dto.PostingProductDto;

@Mapper
public interface PostingMapper {
    void insertPosting(PostingDto postingDto);
    void insertPostingProduct(PostingProductDto postingProductDto);
    void insertPostingFile(PostingFileDto postingFileDto);
    List<Map<String, Object>> getAllProductDetailsWithInventory();
}
