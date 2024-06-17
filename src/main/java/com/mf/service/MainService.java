package com.mf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.CategoryDto;
import com.mf.dto.Paging;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.MainMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MainService {
	@Autowired
	private MainMapper mainMapper;

	public List<CategoryDto> getCategory() {
		return mainMapper.getCategory();
	}

	// 카테고리 영어 이름 기준으로 서브 카테고리 목록 가져오는 메소드
	public List<SubCategoryDto> getSubCategoriesByCategoryEngName(String categoryEngName) {
		return mainMapper.getSubCategoriesByCategoryEngName(categoryEngName);
		}

		// 임시로 만든 전체 포스팅 관련 내용 갖고오기
	public Map<String, List<Map<String, Object>>> getPostingAll() {
		// 리턴을 위한 객체 선언.
        Map<String, List<Map<String, Object>>> result = new HashMap<>();
		
		// 전체 포스팅 갖고오기(임시)
        // 후에는 editor's pick 뭐 이런걸로 변경예정
		List<Map<String, Object>> all = mainMapper.getPostingAll();
		// 최신 포스팅 8개 갖고오기
		List<Map<String, Object>> recent = mainMapper.getRecentPosting();

		
        result.put("all", all);
        result.put("recent", recent);
		
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


	public Paging calculatePagingInfo(String keyword, int page, int pageSize) {
		int totalCount = mainMapper.getPostingCountByKeyword(keyword); // 게시글 총 개수
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

	// 영어 이름으로 특정 카테고리의 All 서브 카테고리 가져오는 메소드
	public SubCategoryDto getAllSubCategoryByCategoryEngName(String categoryEngName) {
		return mainMapper.getAllSubCategoryByCategoryEngName(categoryEngName);
	}

	
	
	// 서브 카테고리 이름과 카테고리 이름으로 특정 서브 카테고리를 가져오는 메소드
	public SubCategoryDto getSubCategoryByNameAndCategoryEngName(String subCategoryName, String categoryEngName) {
		return mainMapper.getSubCategoryByNameAndCategoryEngName(subCategoryName, categoryEngName);
	}

	// 키워드를 사용해 필터링된 카테고리 목록 가져오는 메소드
	public List<CategoryDto> getCategoriesByKeyword(String keyword) {
		return mainMapper.getCategoriesByKeyword(keyword);
	}

	// 카테고리 코드로 서브 카테고리 목록 가져오는 메소드
	public List<SubCategoryDto> getSubCategoriesByCategoryCode(String categoryCode) {
		List<SubCategoryDto> subCategories = mainMapper.getSubCategoriesByCategoryCode(categoryCode);
		return subCategories;
	}

	public List<CategoryDto> searchCategoriesAndSubCategories(String keyword) {
		return mainMapper.searchCategoriesAndSubCategories(keyword);
	}

	// 카테고리가 같은 공고 전체 갖고 오기(All)
	public List<Map<String, Object>> getAllPostingByCategory(String categoryEngName, int pageSize, int startIndex) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("categoryEngName", categoryEngName);
	    params.put("startIndex", startIndex);
	    params.put("pageSize", pageSize);
		return mainMapper.getAllPostingByCategory(params);
	}
	// 카테로기 같은 공고 전체 페이징 설정 
	public Paging calculatePagingInfoByCategory(String categoryEngName, int page, int pageSize) {
		int totalCount = mainMapper.getPostingCountBycategoryEngName(categoryEngName); // 게시글 총 개수
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
	
	
	// 카테고리가 같은 공고 중 서브카테리가 같은 공고 갖고오기
	public List<Map<String, Object>> getSelectedPostingBySubCategory(String subCategoryName, int pageSize, int startIndex) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("subCategoryName", subCategoryName);
	    params.put("startIndex", startIndex);
	    params.put("pageSize", pageSize);
		return mainMapper.getSelectedPostingBySubCategory(params);
	}

	public Paging calculatePagingInfoBySubCategory(String subCategoryName, int page, int pageSize) {
		int totalCount = mainMapper.getPostingCountBysubCategoryName(subCategoryName); // 게시글 총 개수
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

	// 현재 찜 목록 상태 확인
	public boolean checkWish(Long postingIdx, Long userIdx) {
		return mainMapper.checkWish(postingIdx,userIdx) > 0;
	}

	// 찜 목록 추가
	public void addWish(Long postingIdx, Long userIdx) {
		mainMapper.insertWish(postingIdx,userIdx);
	}
	

	// 찜 목록 삭제
	public void deleteWish(Long postingIdx, Long userIdx) {
		mainMapper.deleteWish(postingIdx,userIdx);
	}

	
}
