package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mf.service.PostingService;
import com.mf.service.ProductService;

@Controller
@RequestMapping("/storeMyPage")
public class PostingContoller {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PostingService postingService;
	
	@GetMapping("/postingWrite")
	public String showPostingWritePage(Model model) {
		// 등록된 모든 상품 목록을 가져와서 모델에 추가
		List<Map<String, Object>> products = postingService.getAllProductDetailsWithInventory();
		
		model.addAttribute("products", products);
		return "/posting/postingWrite";
	}
	
	@GetMapping("/posting/getProductDetails")
    @ResponseBody
    public Map<String, Object> getProductDetails(@RequestParam("productIdx") Long productIdx) {
        // 선택된 productIdx에 대한 상세 정보 로드
        Map<String, Object> productDetails = postingService.getProductDetailsByProductIdx(productIdx);
        return productDetails;
    }

	
	
	@PostMapping("/postingWrite")
    public String createPosting(@RequestParam("productIdx") Long productIdx,
                                @RequestParam("title") String title,
                                @RequestParam("content") String content,
                                @RequestParam("postingFile") List<MultipartFile> postingFiles) {
        // 새로운 판매글을 생성하는 서비스 메서드를 호출
        postingService.createPosting(productIdx, title, content, postingFiles);
        return "redirect:/storeMyPage/postingList"; 
    }
	
	
	@GetMapping("/postingDetail")
	public ModelAndView productDetail() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("posting/postingdetail");
		return mv;
	}
}
