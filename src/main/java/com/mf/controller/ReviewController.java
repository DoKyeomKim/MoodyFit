package com.mf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.mf.dto.AdminReviewDto;
import com.mf.dto.ReviewLikesDto;
import com.mf.service.AdminReviewService;

@RestController
@RequestMapping("/api")
public class ReviewController {

    @Autowired
    private AdminReviewService adminReviewService;

    @GetMapping("/reviews")
    public List<AdminReviewDto> getAllReviews() {
    	
        return adminReviewService.getAllReviews();
    }
    
	    // 좋아요 목록 체크
		@GetMapping("/checkLikes")
		public ResponseEntity<Boolean> checkLikes(@RequestParam("postingReviewIdx") Long postingReviewIdx, @RequestParam("userIdx") Long userIdx){
			boolean isLikes = adminReviewService.checkLikes(postingReviewIdx,userIdx);
			return ResponseEntity.ok(isLikes);
		}
		
		// 리뷰 좋아요 하기
		@PostMapping("/addLikes")
		public Map<String, Object> addLikes(@RequestBody Map<String, Long> request){
			Map<String,Object> response = new HashMap<>();
			Long userIdx = request.get("userIdx");
			Long postingReviewIdx = request.get("postingReviewIdx");
			
			
		try {
			adminReviewService.addLikes(userIdx,postingReviewIdx);
        	// 좋아요 count 업데이트하는 로직
            int reviewLikeCount = adminReviewService.getReviewLikeCount(postingReviewIdx);
            
	        response.put("success", true);
            response.put("reviewLikeCount", reviewLikeCount);
			
			}catch (Exception e) {
		        response.put("success", false);
		        response.put("message", e.getMessage());
			}
				
				return response;
		}
		
		
		// 리뷰 좋아요 삭제
		@DeleteMapping("/deleteLikes")
		public Map<String, Object> deleteLikes(@RequestBody Map<String, Long> request){
			Map<String, Object> response = new HashMap<>();
			Long userIdx = request.get("userIdx");
			Long postingReviewIdx = request.get("postingReviewIdx");
			
		    try {
	        	adminReviewService.deleteLikes(userIdx,postingReviewIdx);
	        	// 좋아요 count 업데이트하는 로직
	            int reviewLikeCount = adminReviewService.getReviewLikeCount(postingReviewIdx);

	            response.put("success", true);
	            response.put("reviewLikeCount", reviewLikeCount);

		        } catch (Exception e) {
		            response.put("success", false);
		            response.put("message", e.getMessage());
		        }
		        return response;
			}
}