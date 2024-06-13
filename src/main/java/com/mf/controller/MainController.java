package com.mf.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CategoryDto;
import com.mf.dto.SubCategoryDto;
import com.mf.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
    @Autowired
    private MainService mainService;

    // 메인 페이지
    @GetMapping("/")
    public ModelAndView main() {
        ModelAndView mv = new ModelAndView();
        List<CategoryDto> categories = mainService.getCategory();
        
        log.info("Category List: {}", categories);
        
        mv.addObject("categories", categories);
        mv.setViewName("main");
        return mv;
    }

    // 특정 카테고리 이동 시 기본적으로 All 서브 카테고리로 redirect
    @GetMapping("/category/{categoryEngName}")
    public String redirectToDefaultSubCategory(@PathVariable("categoryEngName") String categoryEngName) {
        // 해당 카테고리의 All 서브 카테고리 가져오기
        SubCategoryDto allSubCategory = mainService.getAllSubCategoryByCategoryEngName(categoryEngName);
        
        log.info("Redirecting to default 'All' subcategory for category: {}, All SubCategory ID: {}", categoryEngName, allSubCategory.getSubCategoryIdx());
        
        // All 카테고리로 redirect
        return "redirect:/category/" + categoryEngName + "/" + allSubCategory.getSubCategoryIdx();
    }

    // 특정 카테고리와 서브 카테고리 이름으로 페이지 로드
    @GetMapping("/category/{categoryEngName}/{subCategoryName}")
    public ModelAndView category(@PathVariable("categoryEngName") String categoryEngName,
                                 @PathVariable("subCategoryName") String subCategoryName) {
        ModelAndView mv = new ModelAndView();
        
        // 해당 카테고리의 모든 서브 카테고리 목록을 가져옴
        List<SubCategoryDto> subCategories = mainService.getSubCategoriesByCategoryEngName(categoryEngName);
        
        // 서브 카테고리 이름이 All인 경우 해당 카테고리의 All 서브 카테고리 정보 가져옴
        SubCategoryDto selectedSubCategory;
        if ("all".equalsIgnoreCase(subCategoryName)) {
            selectedSubCategory = mainService.getAllSubCategoryByCategoryEngName(categoryEngName);
        } else {
            // 서브 카테고리 이름으로 해당 서브 카테고리를 찾음
            selectedSubCategory = mainService.getSubCategoryByNameAndCategoryEngName(subCategoryName, categoryEngName);
        }
        
        log.info("Sub Categories for {}: {}", categoryEngName, subCategories);
        log.info("Selected Sub Category: {}", selectedSubCategory);
        
        mv.addObject("subCategories", subCategories);
        mv.addObject("categoryEngName", categoryEngName);
        mv.addObject("selectedSubCategory", selectedSubCategory);
        mv.setViewName("category");
        return mv;

    }

    
    // 카테고리 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/categories")
    @ResponseBody
    public List<CategoryDto> getCategories(@RequestParam(value = "keyword", required = false) String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            return mainService.getCategoriesByKeyword(keyword);
        }
        return mainService.getCategory();
    }
    
    // 서브 카테고리 데이터를 JSON 형식으로 제공하는 메소드
    @GetMapping("/api/subcategories")
    @ResponseBody
    public List<SubCategoryDto> getSubCategories(@RequestParam("categoryCode") String categoryCode) {
        log.info("Request for subcategories with categoryCode: {}", categoryCode);
        List<SubCategoryDto> subCategories = mainService.getSubCategoriesByCategoryCode(categoryCode);
        log.info("Subcategories fetched: {}", subCategories);
        return subCategories;
    }

    
    
}