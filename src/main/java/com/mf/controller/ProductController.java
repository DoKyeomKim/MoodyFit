package com.mf.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CategoryDto;
import com.mf.dto.ProductColorDto;
import com.mf.dto.ProductDetailsDto;
import com.mf.dto.ProductDto;
import com.mf.dto.ProductInfoList;
import com.mf.dto.ProductSizeDto;
import com.mf.dto.SubCategoryDto;
import com.mf.service.MainService;
import com.mf.service.ProductService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/storeMypage")
@Slf4j
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/productWrite")
    public ModelAndView productWrite() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("product/productwrite");
        return mv;
    }

    @PostMapping("/products/add")
    public String addProduct(@RequestParam("pname") String name,
                             @RequestParam("unitprice") int price,
                             @RequestParam("category") String category,
                             @RequestParam("subCategoryIdx") Long subCategoryIdx,
                             @RequestParam("menufecturer") String manufactureName,
                             @ModelAttribute ProductInfoList productInfos,
                             @RequestParam("productImages") List<MultipartFile> productImages,
                             // @RequestParam("productInfos") List<ProductOptionDto> productInfos, 
                             HttpSession session) {
    
    	
    	Long userIdx = (Long) session.getAttribute("userIdx");
    	Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

    	ProductDto productDto = new ProductDto();
        productDto.setName(name);
        productDto.setPrice(price);
        productDto.setManufactureName(manufactureName);
        productDto.setSubCategoryIdx(subCategoryIdx);
        productDto.setStoreIdx(storeIdx);
        
        // 서비스 호출
        productService.addProduct(productDto, productInfos.getProductInfos(), productImages);
        
        return "redirect:/storeMypage/productList";
    }

    @GetMapping("/productList")
    public ModelAndView productList(HttpSession session) {
        ModelAndView mv = new ModelAndView();
    	Long userIdx = (Long) session.getAttribute("userIdx");
    	Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        // mv.addObject("productInfo", productService.getAllProductInfo());
    	
    	List<Map<String,Object>> products = productService.getAllProductDetails(storeIdx);

    	
        mv.addObject("products", products);
        mv.setViewName("product/productlist");
        return mv;
    }

    
    // 색상 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/colors")
    @ResponseBody
    public List<ProductColorDto> getColors() {
        log.info("Request for product colors");
        List<ProductColorDto> colors = productService.getAllColors();
        log.info("Colors fetched: {}", colors);
        return colors;
    }

    // 사이즈 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/sizes")
    @ResponseBody
    public List<ProductSizeDto> getSizes() {
        log.info("Request for product sizes");
        List<ProductSizeDto> sizes = productService.getAllSizes();
        log.info("Sizes fetched: {}", sizes);
        return sizes;
    }
    
 // 카테고리 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/categories")
    @ResponseBody
    public List<CategoryDto> getCategories(@RequestParam(value = "keyword", required = false) String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            return productService.getCategoriesByKeyword(keyword);
        }
        return productService.getCategory();
    }
    
    // 서브 카테고리 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/subcategories")
    @ResponseBody
    public List<SubCategoryDto> getSubCategories(@RequestParam("categoryCode") String categoryCode) {
        log.info("Request for subcategories with categoryCode: {}", categoryCode);
        List<SubCategoryDto> subCategories = productService.getSubCategoriesByCategoryCode(categoryCode);
        log.info("Subcategories fetched: {}", subCategories);
        return subCategories;
    }
    
    
}