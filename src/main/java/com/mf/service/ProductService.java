package com.mf.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.CategoryDto;
import com.mf.dto.PostingDto;
import com.mf.dto.PostingProductDto;
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
 	
 	
 	/*
	 	파일 저장 --> 추후 이미지 로드 수정 필요
	 	java.io.IOException: java.io.FileNotFoundException: /private/var/folders/9l/vt0_rhzx4cb0bmwy4137h9mh0000gn/T/tomcat.9095.17627246450066852468/work/Tomcat/localhost/ROOT/upload_2a1c56f3_0aba_4605_8d05_60332a3860cb_00000016.tmp (No such file or directory)
	 	at org.apache.catalina.core.ApplicationPart.write(ApplicationPart.java:119)
	 	at org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile.transferTo(StandardMultipartHttpServletRequest.java:265)
	 	at com.mf.service.ProductService.saveProductImages(ProductService.java:109)
	 	at com.mf.service.ProductService.addProduct(ProductService.java:88)
 	*/
// 	private static final String UPLOAD_DIRECTORY = "src/main/resources/static/images/";
 	 
    private void saveProductImages(Long productInfoIdx, List<MultipartFile> productImages) {
    	for (MultipartFile file : productImages) {
    		// 파일 이름 변경 및 저장 위치 설정
    		String originalFileName = file.getOriginalFilename();
    		String fileNameScret = System.currentTimeMillis() + "_" + originalFileName; // 파일 이름 변경(시간값 + 기존 이름)
    		String filePath = "C:/dev/" + fileNameScret; // 저장 경로

    	      File dest = new File("C:/dev/images/"+fileNameScret);
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
    
    // =========== 상품 판매 ===============
    @Transactional
    public void addPosting(PostingDto postingDto) {
    	// null 값일 경우 기본 storeIdx 설정
    	if (postingDto.getStoreIdx() == null) {
    		throw new IllegalArgumentException("storeIdx cannot be null");
        }
    	
    	// posting 테이블에 새로운 판매글 삽입
    	productMapper.insertPosting(postingDto);
    	
    	// posting_product 테이블에 해당 제품 정보 삽입
        if (postingDto.getProductInfoIdx() != null) {
            PostingProductDto postingProductDto = new PostingProductDto();
            postingProductDto.setPostingIdx(postingDto.getPostingIdx());
            postingProductDto.setProductInfoIdx(postingDto.getProductInfoIdx());
            productMapper.insertPostingProduct(postingProductDto);
        }
    }
    

    
    public List<String> getProductColors(Long productInfoIdx) {
        return productMapper.getProductColors(productInfoIdx);
    }

    public List<String> getProductSizes(Long productInfoIdx) {
        return productMapper.getProductSizes(productInfoIdx);
    }
    
    
 // 모든 상품 정보 가져오기
    public List<Map<String, Object>> getAllProductDetails(Long storeIdx) {
    	
    	return productMapper.getAllProductDetails(storeIdx);
    }
    
    /*
    public ProductDetailsDto getProductDetailsByProductInfoIdx(Long productInfoIdx) {
		return productMapper.getProductDetailsByProductInfoIdx(productInfoIdx);
	}
    */
    
    public List<ProductColorDto> getAllColors() {
    	return productMapper.getAllColors();
    	
    }
    
	public List<ProductSizeDto> getAllSizes() {
		return productMapper.getAllSizes();
	}
	

	public void addProductInfo(ProductInfoDto productInfoDto) {
		
	}

	public Long getStoreIdxByUserIdx(Long userIdx) {
		
		return productMapper.getStoreIdxByUserIdx(userIdx);
	}

	public List<PostingProductDto> getPostingProduct(Long userIdx) {

		return productMapper.getPostingProduct(userIdx);
	}

	public ProductDetailsDto getProductDetailsByProductInfoIdx(Long productInfoIdx) {
		// TODO Auto-generated method stub
		return null;
	}

}