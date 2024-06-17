package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//github.com/DoKyeomKim/MoodyFit.git
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CategoryDto;
import com.mf.dto.Paging;
import com.mf.dto.SubCategoryDto;
//github.com/DoKyeomKim/MoodyFit.git
import com.mf.service.MainService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class MainController {
    @Autowired
    private MainService mainService;

 
	// 메인 페이지
	@GetMapping("/")
	public ModelAndView main(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		// 시큐리티 로그인하면서 세션에 저장되게 한 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		
		// 비즈니스 로직 처리하기 위해서 넘김
		// 여러개를 처리하기 위해서 map을 썼고,
		// 그 안에서 서로다른 DTO를 가진 것들을 결과를 받고 List형태로 반환 하기위해 또 Map을 씀
		Map<String, List<Map<String, Object>>> result = mainService.getPostingAll();
		
        List<Map<String, Object>> all = result.get("all");
        List<Map<String, Object>> recent = result.get("recent");
		
		mv.addObject("all", all);
		mv.addObject("recent", recent);
		mv.setViewName("/main");
		return mv;
	}


	// 검색
	@GetMapping("/search")
	public ModelAndView search(@RequestParam("keyword") String keyword,@RequestParam(value = "page", defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		
	    int pageSize = 8; // 한 페이지에 표시할 게시글 수
	    int startIndex = (page - 1) * pageSize;
		
	    // 검색 결과 비즈니스 로직 처리
		List<Map<String,Object>> result = mainService.getSearchResult(keyword,startIndex,pageSize);
		
	    // 페이징 된 로직 처리
	    Paging paging = mainService.calculatePagingInfo(keyword, page, pageSize);

	    mv.addObject("prev", paging.isPrev());
	    mv.addObject("next", paging.isNext());
	    mv.addObject("startPageNum", paging.getStartPageNum());
	    mv.addObject("endPageNum", paging.getEndPageNum());
	    mv.addObject("totalPages", paging.getTotalPages());

		
		mv.addObject("keyword", keyword);
		mv.addObject("result", result);
	    mv.addObject("currentPage", page);
		mv.setViewName("/searchResult");
		return mv;
	}


	// 특정 카테고리 이동 시 기본적으로 All 서브 카테고리로 redirect
    @GetMapping("/category/{categoryEngName}")
    public String redirectToDefaultSubCategory(@PathVariable("categoryEngName") String categoryEngName) {
        // 해당 카테고리의 All 서브 카테고리 가져오기
        SubCategoryDto allSubCategory = mainService.getAllSubCategoryByCategoryEngName(categoryEngName);
        
        
        // All 카테고리로 redirect
        return "redirect:/category/" + categoryEngName + "/All";
    }

    
    // 특정 카테고리와 서브 카테고리 이름으로 페이지 로드
    @GetMapping("/category/{categoryEngName}/{subCategoryName}")
    public ModelAndView category(@PathVariable("categoryEngName") String categoryEngName,
                                 @PathVariable("subCategoryName") String subCategoryName,
                                 @RequestParam(value = "page", defaultValue = "1") int page) {
        ModelAndView mv = new ModelAndView();
        
        // 해당 카테고리의 모든 서브 카테고리 목록을 가져옴
        List<SubCategoryDto> subCategories = mainService.getSubCategoriesByCategoryEngName(categoryEngName);
        
	    int pageSize = 8; // 한 페이지에 표시할 게시글 수
	    int startIndex = (page - 1) * pageSize;
        
        // 서브 카테고리 이름이 All인 경우 해당 카테고리의 All 서브 카테고리 정보 가져옴
        SubCategoryDto selectedSubCategory = new SubCategoryDto();
        if ("all".equalsIgnoreCase(subCategoryName)) {
            selectedSubCategory = mainService.getAllSubCategoryByCategoryEngName(categoryEngName);
            
            List<Map<String,Object>> allPosting = mainService.getAllPostingByCategory(categoryEngName,pageSize,startIndex);
            Paging paging = mainService.calculatePagingInfoByCategory(categoryEngName, page, pageSize);
            
            
            mv.addObject("allPosting", allPosting);
        } else {
            // 서브 카테고리 이름으로 해당 서브 카테고리를 찾음
            selectedSubCategory = mainService.getSubCategoryByNameAndCategoryEngName(subCategoryName, categoryEngName);
            List<Map<String,Object>> selectedPosting = mainService.getSelectedPostingBySubCategory(subCategoryName);
            
            mv.addObject("selectedPosting", selectedPosting);
        }
        
        mv.addObject("subCategories", subCategories);
        mv.addObject("categoryEngName", categoryEngName);
        mv.addObject("selectedSubCategory", selectedSubCategory);
        mv.setViewName("category");
        return mv;

    }

    

    
    
}



