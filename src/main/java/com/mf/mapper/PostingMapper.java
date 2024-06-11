package com.mf.mapper;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface PostingMapper {
    List<Map<String, Object>> getAllPostings();

}
