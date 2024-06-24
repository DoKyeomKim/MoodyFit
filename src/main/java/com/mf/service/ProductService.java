package com.mf.service;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.CategoryDto;
import com.mf.dto.ProductColorDto;
import com.mf.dto.ProductDetailsDto;
import com.mf.dto.ProductDto;
import com.mf.dto.ProductFileDto;
import com.mf.dto.ProductInfoDto;
import com.mf.dto.ProductOptionDto;
import com.mf.dto.ProductQuantityDto;
import com.mf.dto.ProductSizeDto;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.ProductMapper;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;
    
    
    // ============ 상품 등록에서의 카테고리 ======================
    
    // 키워드를 사용해 필터링된 카테고리 목록 가져오는 메소드
 	public List<CategoryDto> getCategoriesByKeyword(String keyword) {
 		return productMapper.getCategoriesByKeyWord(keyword);
 	}
 	
 	public List<CategoryDto> getCategory() {
		return productMapper.getCategory();
	}
 	
 	// 카테고리 코드로 서브 카테고리 목록 가져오는 메소드
 	public List<SubCategoryDto> getSubCategoriesByCategoryCode(String categoryCode) {
 		List<SubCategoryDto> subCategories = productMapper.getSubCategoriesByCategoryCode(categoryCode);
 		log.info("Fetched subcategories for categoryCode {}: {}", categoryCode, subCategories);
 		return subCategories;
 	}


 	public List<CategoryDto> searchCategoriesAndSubCategories(String keyword) {
 		return productMapper.searchCategoriesAndSubCategories(keyword);
 	}
 	
    
 	// 다중 레코드(색상, 사이즈 재고), 이미지 추가 부분
 	 @Transactional
     public void addProduct(ProductDto productDto, List<ProductOptionDto> productInfos, List<MultipartFile> productImages) {
         // Product 테이블에 삽입
         productMapper.insertProduct(productDto);
         Long productIdx = productDto.getProductIdx();
         

         for (ProductOptionDto productOptionDto : productInfos) {
             ProductInfoDto productInfoDto = new ProductInfoDto();
             productInfoDto.setProductColorIdx(productOptionDto.getColorIdx());
             productInfoDto.setProductSizeIdx(productOptionDto.getSizeIdx());
             productInfoDto.setProductIdx(productIdx);

             productMapper.insertProductInfo(productInfoDto);

             Long productInfoIdx = productInfoDto.getProductInfoIdx();
             ProductQuantityDto productQuantityDto = new ProductQuantityDto();
             productQuantityDto.setProductInfoIdx(productInfoIdx);
             productQuantityDto.setQuantity(productOptionDto.getQuantity());
             productMapper.insertProductQuantity(productQuantityDto);
             
             saveProductImages(productInfoIdx, productImages);
         }
     }
 	 
    private void saveProductImages(Long productInfoIdx, List<MultipartFile> productImages) {
    	for (MultipartFile file : productImages) {
    		// 파일 이름 변경 및 저장 위치 설정
    		String originalFileName = file.getOriginalFilename();
    		String fileNameScret = System.currentTimeMillis() + "_" + originalFileName; // 파일 이름 변경(시간값 + 기존 이름)
    		String filePath = "/Users/sinminjae/dev/" + fileNameScret; // 저장 경로

    	      File dest = new File("/Users/sinminjae/dev/images/"+fileNameScret);
    	      // 만약 해당 위치에 폴더가 없으면 생성
    	      if (!dest.exists()) {
    	         dest.mkdirs();
    	        }
    		try {
    			// 파일을 저장할 디렉토리에 저장
    			file.transferTo(dest);
    			
    			// 파일 정보 db에 기록
    			ProductFileDto productFileDto = new ProductFileDto();
    			productFileDto.setOriginalName(originalFileName);
    			productFileDto.setFilePath("/images/"+fileNameScret);
    			productFileDto.setFileSize(String.valueOf(file.getSize()));
    			productFileDto.setProductInfoIdx(productInfoIdx);
    			productMapper.insertProductFile(productFileDto);
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
     	}
	}
    
    // 모든 상품 정보 가져오기
    public List<Map<String, Object>> getAllProductDetails(Long storeIdx) {	
    	return productMapper.getAllProductDetails(storeIdx);
    }
    
    // ==============================================================
    // ====================== 상품 등록 =============================
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

		
        // ProductInfo 테이블에 삽입
        ProductInfoDto productInfoDto = new ProductInfoDto();
        productInfoDto.setProductColorIdx(productDetailsDto.getProductColorIdx());
        productInfoDto.setProductSizeIdx(productDetailsDto.getProductSizeIdx());
        productInfoDto.setProductIdx(productIdx);
        productMapper.insertProductInfo(productDetailsDto);

        
        // 새로 삽입된 product_info의 ID 가져오기
        ProductQuantityDto productQuantityDto = new ProductQuantityDto();
        productQuantityDto.setProductInfoIdx(productDetailsDto.getProductInfoIdx());
        Long productInfoIdx = productQuantityDto.getProductInfoIdx();


        // ProductQuantity 테이블에 삽입
        productMapper.insertProductQuantity(productInfoIdx, productDetailsDto.getQuantity());
        
     
    }
	
    // ==============================================================
    // ====================== 상품 수정 =============================
	@Transactional
	public void updateProduct(ProductDto productDto, List<ProductOptionDto> productInfos, List<MultipartFile> productImages, List<Long> deleteFileIds) {
	    // Product 테이블 업데이트
	    productMapper.updateProduct(productDto);

	    // 기존 ProductInfo와 ProductQuantity 삭제 및 새로 삽입
	    List<ProductInfoDto> existingInfos = productMapper.getProductInfosByProductIdx(productDto.getProductIdx());
	    for (ProductOptionDto productOptionDto : productInfos) {
	        if (productOptionDto.getProductInfoIdx() == null) {
	            // 새로운 정보 삽입
	            ProductInfoDto productInfoDto = new ProductInfoDto();
	            productInfoDto.setProductColorIdx(productOptionDto.getColorIdx());
	            productInfoDto.setProductSizeIdx(productOptionDto.getSizeIdx());
	            productInfoDto.setProductIdx(productDto.getProductIdx());
	            productMapper.insertProductInfo(productInfoDto);

	            Long productInfoIdx = productInfoDto.getProductInfoIdx();
	            ProductQuantityDto productQuantityDto = new ProductQuantityDto();
	            productQuantityDto.setProductInfoIdx(productInfoIdx);
	            productQuantityDto.setQuantity(productOptionDto.getQuantity());
	            productMapper.insertProductQuantity(productQuantityDto);
	        } else {
	            // 기존 정보 업데이트
	            productMapper.updateProductInfo(productOptionDto);
	            productMapper.updateProductQuantity(productOptionDto);
	        }
	    }

	    // 기존 이미지 삭제 및 재삽입
	    if (!deleteFileIds.isEmpty()) {
	        for (Long fileId : deleteFileIds) {
	            productMapper.deleteProductFile(fileId);
	        }
	    }
	    saveProductImages(productDto.getProductIdx(), productImages);
	}
	
	public List<ProductInfoDto> getProductInfosByProductIdx(Long productIdx) {
	    return productMapper.getProductInfosByProductIdx(productIdx);
	}

	public List<ProductFileDto> getProductFilesByProductIdx(Long productIdx) {
	    return productMapper.getProductFilesByProductIdx(productIdx);
	}


	@Transactional
	public Map<String, Object> getProductDetailsByProductIdx(Long productIdx) {
	    if (productIdx == null) {
	        throw new IllegalArgumentException("productIdx는 null이 될 수 없습니다.");
	    }
	    List<Map<String, Object>> productDetailsList = productMapper.getProductDetailsByProductIdx(productIdx);
	    if (productDetailsList == null || productDetailsList.isEmpty()) {
	        System.out.println("상품 정보가 없습니다.");
	        return Collections.emptyMap();
	    } else {
	        System.out.println("상품 정보 로드 성공: " + productDetailsList);
	        // 단일 상품 정보이므로 첫 번째 항목을 반환
	        return productDetailsList.get(0);
	    }
	}

	
	
	public void updateProductPrice(Long productIdx, int price) {
	    ProductDto productDto = new ProductDto();
	    productDto.setProductIdx(productIdx);
	    productDto.setPrice(price);
	    productMapper.updateProduct(productDto);
	}
	
	public void updateProductQuantity(Long productInfoIdx, int quantity) {
	    ProductOptionDto optionDto = new ProductOptionDto();
	    optionDto.setProductInfoIdx(productInfoIdx);
	    optionDto.setQuantity(quantity);
	    productMapper.updateProductQuantity(optionDto);
	}
	
	
	
	// 모든 상품 로드 
    public List<ProductDto> getAllProducts() {
		return productMapper.getAllProducts();
	}
    
    // 모든 색상 정보 로드
    public List<ProductColorDto> getAllColors() {
    	return productMapper.getAllColors();	
    }
    
    // 모든 사이즈 정보 로드
    public List<ProductSizeDto> getAllSizes() {
    	return productMapper.getAllSizes();
    }
    
    // 특정 상품의 색상 리스트 로드
    public List<String> getProductColors(Long productInfoIdx) {
        return productMapper.getProductColors(productInfoIdx);
    }
    
    // 특정 상품의 사이즈 리스트 로드
    public List<String> getProductSizes(Long productInfoIdx) {
        return productMapper.getProductSizes(productInfoIdx);
    }

	
	// 새로운 상품 정보 추가
	public void addProductInfo(ProductInfoDto productInfoDto) {
	}
	
	// 사용자 ID를 통해 store ID 로드
	public Long getStoreIdxByUserIdx(Long userIdx) {
		return productMapper.getStoreIdxByUserIdx(userIdx);
	}
	
	// 특정 상품 정보 로드
	public ProductDetailsDto getProductDetailsByProductInfoIdx(Long productInfoIdx) {
		return null;
	}

}