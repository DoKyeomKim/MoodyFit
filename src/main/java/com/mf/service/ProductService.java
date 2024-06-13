package com.mf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.ProductColorDto;
import com.mf.dto.ProductDetailsDto;
import com.mf.dto.ProductDto;
import com.mf.dto.ProductInfoDto;
import com.mf.dto.ProductSizeDto;
import com.mf.mapper.ProductMapper;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;
    
    @Transactional
    public void addProductDetails(ProductDetailsDto productDetailsDto) {
        
        // Product 테이블에 삽입
    	productMapper.insertProduct(productDetailsDto);
    	Long productIdx = productDetailsDto.getProductIdx();
    	
        ProductDto productDto = new ProductDto();
        productDto.setName(productDetailsDto.getName());
        productDto.setPrice(productDetailsDto.getPrice());
        productDto.setManufactureName(productDetailsDto.getManufactureName());
        productDto.setSubCategoryIdx(productDetailsDto.getSubCategoryIdx());
        productDto.setStoreIdx(productDetailsDto.getStoreIdx());
        
        productMapper.insertProduct(productDetailsDto);
        
		
        // ProductInfo 테이블에 삽입
        ProductInfoDto productInfoDto = new ProductInfoDto();
        productInfoDto.setProductColorIdx(productDetailsDto.getProductColorIdx());
        productInfoDto.setProductSizeIdx(productDetailsDto.getProductSizeIdx());
        productInfoDto.setProductIdx(productIdx);
        productMapper.insertProductInfo(productDetailsDto);

        
        // 새로 삽입된 product_info의 ID 가져오기
        Long productInfoIdx = productInfoDto.getProductInfoIdx();

        // ProductQuantity 테이블에 삽입
        productMapper.insertProductQuantity(productInfoIdx, productDetailsDto.getQuantity());
        
     
    }
    
    
 // 모든 상품 정보 가져오기
    public List<ProductDetailsDto> getAllProductDetails(Long storeIdx) {
    	List<ProductDetailsDto> products = productMapper.getAllProductDetails(storeIdx);
    	return products;
    }
    
    
    
    public List<ProductColorDto> getAllColors() {
    	return productMapper.getAllColors();
    	
    }
    
	public List<ProductSizeDto> getAllSizes() {
		return productMapper.getAllSizes();
	}



	public void addProduct(ProductDto productDto) {
		
	}

	public void addProductInfo(ProductInfoDto productInfoDto) {
		
	}


	public Long getStoreIdxByUserIdx(Long userIdx) {
		
		return productMapper.getStoreIdxByUserIdx(userIdx);
	}

}