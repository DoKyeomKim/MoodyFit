package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectKey;

import com.mf.dto.ProductInfoDto;
import com.mf.dto.ProductSizeDto;
import com.mf.dto.ProductColorDto;
import com.mf.dto.ProductDetailsDto;

@Mapper
public interface ProductMapper {
	// Product 삽입 (ProductDetailsDto 사용)
    void insertProduct(ProductDetailsDto productDetailsDto);
    
    // ProductInfo 삽입 (ProductDetailsDto 사용)
    void insertProductInfo(ProductDetailsDto productDetailsDto);

    // ProductQuantity 삽입
    
    public void insertProductQuantity(
    	    @Param("productInfoIdx") Long productInfoIdx,
    	    @Param("quantity") int quantity
    	);


    // 모든 상품 정보 가져오기
    List<ProductInfoDto> getAllProductInfo();
  
	List<ProductColorDto> getAllColors();
	
	List<ProductSizeDto> getAllSizes();

	List<ProductDetailsDto> getAllProductDetails(Long storeIdx);


	Long getProductIdx();
	
	Long getProductInfoIdx();

	Long getStoreIdxByUserIdx(Long userIdx);

	
}