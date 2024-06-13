package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.CategoryDto;
import com.mf.dto.PersonDto;

@Mapper
public interface MainMapper {

	List<CategoryDto> getCategory();

	// 임시로 만든 전체 포스팅 내용 갖고오기
	List<Map<String, Object>> getPostingAll();

	// 검색결과
	List<Map<String, Object>> getSearchResult(Map<String, Object> params);

	// 총 검색 결과량
	int getPostingCountByKeyword(String keyword);
}
