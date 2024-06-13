package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.Paging;
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
		
		//임시로 만든 전체 공고 다 들고 오는 거
		List<Map<String,Object>> result = mainService.getPostingAll();
		
		mv.addObject("result", result);
		mv.setViewName("/main");
		return mv;
	}


	// 검색
	@GetMapping("/search")
	public ModelAndView search(@RequestParam("keyword") String keyword,@RequestParam(value = "page", defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		
	    int pageSize = 8; // 한 페이지에 표시할 게시글 수
	    int startIndex = (page - 1) * pageSize;
		
		List<Map<String,Object>> result = mainService.getSearchResult(keyword,startIndex,pageSize);

	    int totalCount = mainService.getPostingCountByKeyword(keyword);
	    
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

	@GetMapping("/{engName}")
	public ModelAndView category() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("/main");
		return mv;
	}


}
