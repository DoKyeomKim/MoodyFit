package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectKey;

import com.mf.dto.ProductInfoDto;
import com.mf.dto.ProductOptionDto;
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
	
	List<ProductDto> getAllProducts();
	
	// ============= 카테고리 ================
	List<CategoryDto> getCategory();
	
	List<CategoryDto> getCategoriesByKeyWord(@Param("keyword") String keyword);
	
	List<CategoryDto> getCategoriesByKeyword(String keyword);
	
	List<SubCategoryDto> getSubCategoriesByCategoryCode(@Param("categoryCode") String categoryCode);
	
	List<CategoryDto> searchCategoriesAndSubCategories(@Param("keyword") String keyword);
	
	// 다중 색상,사이즈,재고 
	void insertProduct(ProductDto productDto);
	
	// Product 삽입 (ProductDetailsDto 사용)
    void insertProduct(ProductDetailsDto productDetailsDto);
    
    // ProductInfo 삽입 (ProductDetailsDto 사용)
    void insertProductInfo(ProductDetailsDto productDetailsDto);

    // ProductQuantity 삽입
    public void insertProductQuantity(
    	    @Param("productInfoIdx") Long productInfoIdx,
    	    @Param("quantity") int quantity
    	);
    
    
    // 특정 상품의 사이즈 목록 로드
    List<String> getProductSizes(Long productInfoIdx);
    
    // 특정 상품의 색상 목록 로드
    List<String> getProductColors(Long productInfoIdx);

    // 모든 상품 정보 로드
    List<ProductInfoDto> getAllProductInfo();
    
	List<ProductColorDto> getAllColors();
	
	List<ProductSizeDto> getAllSizes();

	List<Map<String, Object>> getAllProductDetails(Long storeIdx); // 여기에 파일목록까지 포함 로드


	// 파일 정보
	void insertProductFile(ProductFileDto productFileDto);
	
	
	ProductDetailsDto getProductDetailsByProductInfoIdx(@Param("productInfoIdx") Long productInfoIdx);
	
	Long getProductIdx();
	
	Long getProductInfoIdx();

	Long getStoreIdxByUserIdx(@Param("userIdx") Long userIdx);
	
	
	List<Map<String, Object>> getProductDetailsByProductIdxForPosting(Long productIdx);

	
	// ==============================================================
    // ====================== 상품 수정 =============================
	void updateProduct(ProductDto productDto);
	void updateProductInfo(ProductOptionDto productOptionDto);
	void updateProductQuantity(ProductOptionDto productOptionDto);
	
	void deleteProductFile(Long productFileIdx);
	void deleteProductInfosByProductIdx(Long productIdx);
	void deleteProductFilesByProductIdx(Long productIdx);
	
	void insertProductInfo(ProductInfoDto productInfoDto);
	void insertProductQuantity(ProductQuantityDto productQuantityDto);

	List<ProductInfoDto> getProductInfosByProductIdx(Long productIdx);
	List<ProductFileDto> getProductFilesByProductIdx(Long productIdx);

	List<Map<String, Object>> getProductDetailsByProductIdx(Long productIdx);

	void deleteProductInfo(Long productInfoIdx);
	void deleteProductQuantity(Long productInfoIdx);
	
	
	ProductDto selectProductByIdx(@Param("productIdx") Long productIdx);
    List<ProductInfoDto> selectProductInfosByProductIdx(@Param("productIdx") Long productIdx);
    List<ProductFileDto> selectProductFilesByProductIdx(@Param("productIdx") Long productIdx);
	   

	
}