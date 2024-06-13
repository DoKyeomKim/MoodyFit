package com.mf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.Paging;
import com.mf.mapper.MainMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainService {
	@Autowired
	private MainMapper mainMapper;
	
	public List<CategoryDto> getCategory() {
		return mainMapper.getCategory();
	}

	// 임시로 만든 전체 포스팅 관련 내용 갖고오기
	public List<Map<String, Object>> getPostingAll() {
			
		List<Map<String, Object>> result = mainMapper.getPostingAll();
		
		return result;
	}

	// 검색 결과
	public List<Map<String, Object>> getSearchResult(String keyword, int startIndex, int pageSize) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("keyword", keyword);
	    params.put("startIndex", startIndex);
	    params.put("pageSize", pageSize);
	    return mainMapper.getSearchResult(params);
	}

	public int getPostingCountByKeyword(String keyword) {
		return mainMapper.getPostingCountByKeyword(keyword);
	}

	public Paging calculatePagingInfo(String keyword, int page, int pageSize) {
		int totalCount = getPostingCountByKeyword(keyword); // 게시글 총 개수
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수
	    
	    int pageNum_cnt = 10; // 한번에 보여줄 페이지 수
	    int endPageNum = (int) (Math.ceil((double) page / pageNum_cnt) * pageNum_cnt); // 마지막 페이지 번호
	    int startPageNum = endPageNum - (pageNum_cnt - 1); // 시작 페이지 번호
	    
	    // 마지막 페이지 번호 다시 검증
	    int endPageNum_tmp = (int) (Math.ceil((double) totalCount / pageSize));
	    if (endPageNum > endPageNum_tmp) {
	        endPageNum = endPageNum_tmp;
	    }
	    
	    boolean prev = startPageNum > 1; // 이전 페이지 존재 여부
	    boolean next = endPageNum * pageSize < totalCount; // 다음 페이지 존재 여부
	    
	    Paging paging = new Paging();
	    paging.setTotalPages(totalPages);
	    paging.setStartPageNum(startPageNum);
	    paging.setEndPageNum(endPageNum);
	    paging.setPrev(prev);
	    paging.setNext(next);
		
		return paging;
	}


}




