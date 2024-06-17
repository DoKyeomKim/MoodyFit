package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;
import com.mf.dto.WishDto;

@Mapper
public interface MainMapper {
    List<CategoryDto> getCategory();
    
    
    List<CategoryDto> getCategoriesByKeyWord(@Param("keyword") String keyword);
    
    List<SubCategoryDto> getSubCategoriesByCategoryEngName(@Param("categoryEngName") String categoryEngName);
    
    SubCategoryDto getAllSubCategoryByCategoryEngName(@Param("categoryEngName") String categoryEngName);
    
    // 서브 카테고리 이름과 카테고리 이름으로 서브 카테고리를 가져오는 메서드
    SubCategoryDto getSubCategoryByNameAndCategoryEngName(@Param("subCategoryName") String subCategoryName,
                                                          @Param("categoryEngName") String categoryEngName);


	List<CategoryDto> getCategoriesByKeyword(String keyword);
	
	List<SubCategoryDto> getSubCategoriesByCategoryCode(@Param("categoryCode") String categoryCode);
	
	List<CategoryDto> searchCategoriesAndSubCategories(@Param("keyword") String keyword);


	// 임시로 만든 전체 포스팅 내용 갖고오기
	List<Map<String, Object>> getPostingAll();

	// 검색결과
	List<Map<String, Object>> getSearchResult(Map<String, Object> params);

	// 총 검색 결과량
	int getPostingCountByKeyword(String keyword);


	// 최근 공고 갖고오기
	List<Map<String, Object>> getRecentPosting();

	// Category로 모든 공고 갖고오기(All페이지에 들어갈 공고)
	List<Map<String, Object>> getAllPostingByCategory(Map<String, Object> params);


	// 카테고리가 같은 공고 중 서브카테리가 같은 공고 갖고오기
	List<Map<String, Object>> getSelectedPostingBySubCategory(Map<String, Object> params);

	// 카테고리별 all posting 페이징
	int getPostingCountBycategoryEngName(String categoryEngName);

	// 서브 카테고리별 posting 페이징
	int getPostingCountBysubCategoryName(String subCategoryName);


	// 찜 상태확인
	int checkWish(Long postingIdx, Long userIdx);

	// 찜 추가
	void insertWish(Long postingIdx, Long userIdx);

	// 찜 삭제
	void deleteWish(Long postingIdx, Long userIdx);
	
}
