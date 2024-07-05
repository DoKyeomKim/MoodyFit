package com.mf.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.NearbyDto;
import com.mf.dto.Paging;
import com.mf.dto.PersonDto;
import com.mf.dto.SubCategoryDto;
import com.mf.mapper.OrderMapper;
import com.mf.mapper.PersonMapper;
import com.mf.service.MainService;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class MainController {
    @Autowired
    private MainService mainService;

    @Autowired
    private PersonMapper personMapper;
    
    @Autowired
    private OrderMapper orderMapper;
    
    @Autowired
    private MyPageService myPageService;
 
	// 메인 페이지
	@GetMapping("/")
	public ModelAndView main(HttpSession session, PersonDto personDto) {
		ModelAndView mv = new ModelAndView();

		// 시큐리티 로그인하면서 세션에 저장되게 한 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		
		// 비즈니스 로직 처리하기 위해서 넘김
		// 여러개를 처리하기 위해서 map을 썼고,
		// 그 안에서 서로다른 DTO를 가진 것들을 결과를 받고 List형태로 반환 하기위해 또 Map을 씀
		Map<String, List<Map<String, Object>>> result = mainService.getPostingAll();
		
		// 채팅에 필요로한 권한 추가
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.isAuthenticated()) {
		    // 사용자의 권한 확인
		    for (GrantedAuthority authority : authentication.getAuthorities()) {
		        if ("ROLE_PERSON".equals(authority.getAuthority())) {
		        	
		        	Map<String, Object> result2 = myPageService.getPersonMyPage(userIdx);
		    		PersonDto person = (PersonDto) result2.get("person");
		    		Long personIdx = person.getPersonIdx();
		        	
		            String nickName = mainService.getPNickNameByUserIdx(userIdx);
		            List<PersonDto> personList = personMapper.selectPerson(userIdx);
		            List<NearbyDto> postingList2 = orderMapper.selectPosting2(personIdx);
		            Collections.shuffle(postingList2);
		            
		            mv.addObject("postingList",postingList2);
		            mv.addObject("p", personList);
		            mv.addObject("nickName", nickName);
		            break; // 이미 닉네임을 설정했으면 루프 종료
		        } else if ("ROLE_STORE".equals(authority.getAuthority())) {
		            String nickName = mainService.getSNickNameByUserIdx(userIdx);
		            mv.addObject("nickName", nickName);
		            break; // 이미 닉네임을 설정했으면 루프 종료
		        } else if ("ROLE_ADMIN".equals(authority.getAuthority())) {
		        	String nickName = "운영자";
		        	mv.addObject("nickName",nickName);
		        	break;
		        }
		    }
		}
		List<NearbyDto> postingList = orderMapper.selectPosting();
		Collections.shuffle(postingList);
        List<Map<String, Object>> edtiorPick = result.get("edtiorPick");
        List<Map<String, Object>> topPosting = result.get("topPosting");
        List<Map<String, Object>> recent = result.get("recent");
        
		mv.addObject("pl",postingList);
		mv.addObject("edtiorPick", edtiorPick);
		mv.addObject("topPosting", topPosting);
		mv.addObject("recent", recent);
		mv.setViewName("/main");
		return mv;
	}


	// 검색
	@GetMapping("/search")
	public ModelAndView search(@RequestParam("keyword") String keyword,@RequestParam(value = "page", defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		
	    int pageSize = 8; // 한 페이지에 표시할 게시글 수 지금은 확인용으로 2개만 해둠.
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
	    mv.addObject("totalCount", paging.getTotalCount());
		
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
                                 @RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "orderBy", defaultValue = "newest") String orderBy
    							) {
    	
        ModelAndView mv = new ModelAndView();
        
        
        // 해당 카테고리의 모든 서브 카테고리 목록을 가져옴
        List<SubCategoryDto> subCategories = mainService.getSubCategoriesByCategoryEngName(categoryEngName);

        // 카테고리 내의 매출 많은 순
        List<Map<String,Object>> topPosting = mainService.getTopPostingByCategoryEngName(categoryEngName);
        if(topPosting != null) {
            mv.addObject("topPosting", topPosting);
        }
        
	    int pageSize = 8; // 한 페이지에 표시할 게시글 수 확인용으로 1 해놓음 나중에 수정
	    int startIndex = (page - 1) * pageSize;
        
        SubCategoryDto selectedSubCategory = new SubCategoryDto();
        
        // 서브 카테고리 이름이 All인 경우 해당 카테고리의 All 서브 카테고리 정보 가져옴
        if ("all".equalsIgnoreCase(subCategoryName)) {
            selectedSubCategory = mainService.getAllSubCategoryByCategoryEngName(categoryEngName);
            
            // 같은 카테고리 안의 전체 공고 들고 오는 로직처리
            List<Map<String,Object>> allPosting = mainService.getAllPostingByCategory(categoryEngName,pageSize,startIndex,orderBy);
            // 페이징 처리
            Paging paging = mainService.calculatePagingInfoByCategory(categoryEngName, page, pageSize);
            
    	    mv.addObject("prev", paging.isPrev());
    	    mv.addObject("next", paging.isNext());
    	    mv.addObject("startPageNum", paging.getStartPageNum());
    	    mv.addObject("endPageNum", paging.getEndPageNum());
    	    mv.addObject("totalPages", paging.getTotalPages());
            mv.addObject("allPosting", allPosting);
        } else {
            // 서브 카테고리 이름으로 해당 서브 카테고리를 찾음
            selectedSubCategory = mainService.getSubCategoryByNameAndCategoryEngName(subCategoryName, categoryEngName);
            
            // 같은 세부 카테고리 안의 공고 들고 오는 로직 처리
            List<Map<String,Object>> selectedPosting = mainService.getSelectedPostingBySubCategory(subCategoryName,pageSize,startIndex,orderBy);
            
            // 페이징 처리
            Paging paging = mainService.calculatePagingInfoBySubCategory(subCategoryName, page, pageSize);
            
    	    mv.addObject("prev", paging.isPrev());
    	    mv.addObject("next", paging.isNext());
    	    mv.addObject("startPageNum", paging.getStartPageNum());
    	    mv.addObject("endPageNum", paging.getEndPageNum());
    	    mv.addObject("totalPages", paging.getTotalPages());
            mv.addObject("selectedPosting", selectedPosting);
        }
        
        mv.addObject("topPosting", topPosting);
        mv.addObject("orderBy", orderBy);
	    mv.addObject("currentPage", page);
        mv.addObject("subCategories", subCategories);
        mv.addObject("categoryEngName", categoryEngName);
        mv.addObject("selectedSubCategory", selectedSubCategory);
        mv.setViewName("category");
        return mv;

    }

//======================================================================
//=======================wish 비동기처리================================
//======================================================================
    // 찜 목록 체크
	@GetMapping("/checkWish")
	public ResponseEntity<Boolean> checkWish(@RequestParam("postingIdx") Long postingIdx, @RequestParam("userIdx") Long userIdx){
		boolean isWish = mainService.checkWish(postingIdx,userIdx);
		return ResponseEntity.ok(isWish);
	}
	
	// 게시글 찜 하기
	@PostMapping("/addWish")
	@ResponseBody
	public Map<String, Object> addWish(@RequestBody Map<String, Long> request){
		Map<String,Object> response = new HashMap<>();
		

		// 맞는 DTO가 없기때문에 Map 사용했고
		// Map에서 postingIdx userIdx 꺼내기.
		Long postingIdx = request.get("postingIdx");
		Long userIdx = request.get("userIdx");
		
		
	try {
		mainService.addWish(postingIdx,userIdx);
        response.put("success", true);
		
	}catch (Exception e) {
        response.put("success", false);
        response.put("message", e.getMessage());
	}
		
		
		return response;
	}
	
	
	// 게시글 찜 삭제
	@DeleteMapping("/deleteWish")
	@ResponseBody
	public Map<String, Object> deleteWish(@RequestBody Map<String, Long> request){
		Map<String, Object> response = new HashMap<>();
		 
		// 맞는 DTO가 없기때문에 Map 사용했고
		// Map에서 postingIdx userIdx 꺼내기.
		Long postingIdx = request.get("postingIdx");
		Long userIdx = request.get("userIdx");
			

	        try {
	        	mainService.deleteWish(postingIdx,userIdx);
	            response.put("success", true);
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", e.getMessage());
	        }
	        return response;
	}
//======================================================================
//======================================================================
// 에디터 픽 비동기
	
    // 찜 목록 체크
	@GetMapping("/checkEditorPick")
	public ResponseEntity<Boolean> checkEditorPick(@RequestParam("postingIdx") Long postingIdx, @RequestParam("userIdx") Long userIdx){
		boolean isWish = mainService.checkEditorPick(postingIdx,userIdx);
		return ResponseEntity.ok(isWish);
	}
	
	// 게시글 찜 하기
	@PostMapping("/addEditorPick")
	@ResponseBody
	public Map<String, Object> addEditorPick(@RequestBody Map<String, Long> request){
		Map<String,Object> response = new HashMap<>();
		

		// 맞는 DTO가 없기때문에 Map 사용했고
		// Map에서 postingIdx userIdx 꺼내기.
		Long postingIdx = request.get("postingIdx");
		Long userIdx = request.get("userIdx");
		
		
	try {
		mainService.addEditorPick(postingIdx,userIdx);
        response.put("success", true);
		
	}catch (Exception e) {
        response.put("success", false);
        response.put("message", e.getMessage());
	}
		
		
		return response;
	}
	
	
	// 게시글 찜 삭제
	@DeleteMapping("/deleteEditorPick")
	@ResponseBody
	public Map<String, Object> deleteEditorPick(@RequestBody Map<String, Long> request){
		Map<String, Object> response = new HashMap<>();
		 
		// 맞는 DTO가 없기때문에 Map 사용했고
		// Map에서 postingIdx userIdx 꺼내기.
		Long postingIdx = request.get("postingIdx");
		Long userIdx = request.get("userIdx");
			

	        try {
	        	mainService.deleteEditorPick(postingIdx,userIdx);
	            response.put("success", true);
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", e.getMessage());
	        }
	        return response;
	}
//======================================================================
//======================================================================


	
    
}



