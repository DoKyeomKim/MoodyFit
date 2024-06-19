package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectKey;

import com.mf.dto.ProductInfoDto;
import com.mf.dto.ProductQuantityDto;
import com.mf.dto.ProductSizeDto;
import com.mf.dto.SubCategoryDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.PostingDto;
import com.mf.dto.PostingProductDto;
import com.mf.dto.ProductColorDto;
import com.mf.dto.ProductDetailsDto;
import com.mf.dto.ProductDto;
import com.mf.dto.ProductFileDto;

@Mapper
public interface ProductMapper {
	
	
	// ============= 카테고리 ================
	
	List<CategoryDto> getCategory();
	
	List<CategoryDto> getCategoriesByKeyWord(@Param("keyword") String keyword);
	
	List<CategoryDto> getCategoriesByKeyword(String keyword);
	
	List<SubCategoryDto> getSubCategoriesByCategoryCode(@Param("categoryCode") String categoryCode);
	
	List<CategoryDto> searchCategoriesAndSubCategories(@Param("keyword") String keyword);
	
	// 다중 색상,사이즈,재고 
	void insertProduct(ProductDto productDto);
    void insertProductInfo(ProductInfoDto productInfoDto);
    void insertProductQuantity(ProductQuantityDto productQuantityDto);
	
	
	// Product 삽입 (ProductDetailsDto 사용)
    void insertProduct(ProductDetailsDto productDetailsDto);
    
    // ProductInfo 삽입 (ProductDetailsDto 사용)
    void insertProductInfo(ProductDetailsDto productDetailsDto);

    // ProductQuantity 삽입
    public void insertProductQuantity(
    	    @Param("productInfoIdx") Long productInfoIdx,
    	    @Param("quantity") int quantity
    	);
    
    // ============= posting ==================== 
    // posting 테이블에 새로운 판매글 삽입
    void insertPosting(PostingDto postingDto);
    // posting_product 테이블에 해당 제품 정보 삽입
    void insertPostingProduct(PostingProductDto postingProductDto);
    
    // 특정 상품의 사이즈 목록 로드
    List<String> getProductSizes(Long productInfoIdx);
    
    // 특정 상품의 색상 목록 로드
    List<String> getProductColors(Long productInfoIdx);

    // 모든 상품 정보 로드
    List<ProductInfoDto> getAllProductInfo();
    List<ProductDetailsDto> getAllProductDetails();
    
    
	List<ProductColorDto> getAllColors();
	
	List<ProductSizeDto> getAllSizes();

	List<ProductDetailsDto> getAllProductDetails(Long storeIdx); // 여기에 파일목록까지 포함 로드
	
	List<PostingProductDto> getPostingProduct(Long userIdx);
	
	
	// 파일 목록 로드
    // List<ProductFileDto> getProductFilesByProductIdx(Long productIdx);

	// 파일 정보
	void insertProductFile(ProductFileDto productFileDto);
	
	ProductDetailsDto getProductDetailsByProductInfoIdx(@Param("productInfoIdx") Long productInfoIdx);
	
	Long getProductIdx();
	
	Long getProductInfoIdx();

	Long getStoreIdxByUserIdx(@Param("userIdx") Long userIdx);

	
}