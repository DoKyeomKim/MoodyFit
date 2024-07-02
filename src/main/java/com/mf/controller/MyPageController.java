package com.mf.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.Paging;
import com.mf.dto.PersonDto;
import com.mf.dto.PersonLevelDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;
import com.mf.service.CustomUserDetails;
import com.mf.service.MyPageService;
import com.mf.service.UsersService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private UsersService usersService;

//===========================================================================
//================================ 개인 =====================================
//===========================================================================
	
	// 개인 마이페이지 메인
	@GetMapping("/myPage")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		
		// 마이페이지 로직처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		// 서비스에서 넘어온 person안에 들어가 있는 person_idx와 nickname 꺼내기
		PersonDto person = (PersonDto) result.get("person");
		// 레벨 설명을 위한 DB에서 값 불러오기
	    List<PersonLevelDto> personLevels = myPageService.getPersonLevel();
	    
		// 등급 불러오기 위해서 시큐리티 인증 확인
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication != null) {
	        Object principal = authentication.getPrincipal();

	        // 일반 회원 처리
	        if (principal instanceof CustomUserDetails) {
	            CustomUserDetails userDetails = (CustomUserDetails) principal;

	            Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
	            for (GrantedAuthority authority : authorities) {
	                if ("ROLE_PERSON".equals(authority.getAuthority())) {
	                    String levelName = usersService.getLevel(userIdx);
	                    mv.addObject("levelName", levelName);
	                    break;
	                }
	            }
	        } else if (principal instanceof OAuth2User) {
	            OAuth2User oauth2User = (OAuth2User) principal;
	            // 사용자의 역할(role)을 확인하여 "ROLE_PERSON"인 경우에만 처리
	            if (oauth2User.getAuthorities().stream().anyMatch(auth -> "ROLE_PERSON".equals(auth.getAuthority()))) {
	                // 사용자 등급 정보 가져오기
	                String levelName = usersService	.getLevel(userIdx);
	                mv.addObject("levelName", levelName);
	            }
	        }
	    }
	    
		mv.addObject("person",person);
		mv.addObject("personLevel",personLevels);
		mv.addObject("orderPrePare", result.get("orderPrePare"));
		mv.addObject("orderIng", result.get("orderIng"));
		mv.addObject("orderDone", result.get("orderDone"));
		mv.setViewName("myPage/myPage");
		return mv;
	}
	
	// 유저 정보 수정페이지
	@GetMapping("/personUpdateForm")
	public ModelAndView personUpdateForm(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		

		// 마이페이지 로직처리
		Map<String, Object> result = myPageService.getPersonInfo(userIdx);		
		
		mv.addObject("result", result);
		mv.setViewName("myPage/personUpdate");
		return mv;
	}
	
	// 유저 정보 수정
	@PostMapping("/personUpdate")
	public ModelAndView personUpdate( HttpSession session,UsersDto users,PersonDto person,PersonSpecDto personSpec) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");

		myPageService.personUpdate(userIdx,users,person,personSpec);
		
		mv.setViewName("redirect:/myPage");
		return mv;
	}
	
	// 관심상품(찜 목록)
	@GetMapping("/myPage/wishList")
	public ModelAndView wishList(HttpSession session,@RequestParam(value = "page", defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		Long userIdx = (Long) session.getAttribute("userIdx");
		int pageSize = 1; // 페이징 확인용 1개만 들고옴
		int startIndex = (page - 1) * pageSize;
		
		List<Map<String,Object>> wishList= myPageService.getWishList(userIdx,pageSize,startIndex);
		Paging paging = myPageService.calculatePagingInfo(page, pageSize,userIdx);
		
	    mv.addObject("prev", paging.isPrev());
	    mv.addObject("next", paging.isNext());
	    mv.addObject("startPageNum", paging.getStartPageNum());
 	    mv.addObject("endPageNum", paging.getEndPageNum());
	    mv.addObject("totalPages", paging.getTotalPages());
	    mv.addObject("currentPage", page);
		
		mv.addObject("wishList", wishList);
		mv.setViewName("myPage/wishList");
		return mv;
	}
	
	
//===========================================================================
//================================ 가맹점 ===================================
//===========================================================================

	// 가맹점 마이페이지 메인
	@GetMapping("/storeMyPage")
	public ModelAndView storeMyPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();		
		// 세션의 userIdx 갖고오기		
		Long userIdx = (Long) session.getAttribute("userIdx");
		
		// 마이페이지 로직처리
		Map<String, Object> result = myPageService.getShopMyPage(userIdx);
		
		// 서비스에서 넘어온 store안에 들어가 있는 store_idx와 store_name 꺼내기
		StoreDto store = (StoreDto) result.get("store");
		
		mv.addObject("store", store);
		mv.setViewName("myPage/storeMyPage");
		return mv;
	}
	
	// 가맹점 정보 수정페이지
	@GetMapping("/storeUpdateForm")
	public ModelAndView storeUpdateForm(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		// 수정페이지 로직처리
		Map<String, Object> result = myPageService.getStoreInfo(userIdx);		

		mv.addObject("result", result);
		mv.setViewName("myPage/storeUpdate");
		return mv;
	}
	
	// 가맹점 정보 수정
	@PostMapping("/storeUpdate")
	public ModelAndView storeUpdate( HttpSession session,UsersDto users,StoreDto store) {
		ModelAndView mv = new ModelAndView();
		// 세션의 userIdx 갖고오기
		Long userIdx = (Long) session.getAttribute("userIdx");
		// 정보 수정 로직처리
		myPageService.storeUpdate(userIdx,users,store);
		
		mv.setViewName("redirect:/storeMyPage");
		return mv;
	}
	
	
	//==========================공통============================================
		// 회원탈퇴 폼으로 이동
		@GetMapping("/accountDeleteForm")
		public ModelAndView accountDeleteForm() {
			ModelAndView mv = new ModelAndView();		
			
			mv.setViewName("myPage/accountDelete");
			return mv;
		}
		// 회원탈퇴
		@PostMapping("/accountDelete")
		public ModelAndView accountDelete(HttpSession session) {
			ModelAndView mv = new ModelAndView();		
			Long userIdx = (Long) session.getAttribute("userIdx");
			// 회원탈퇴(state상태 변경) 로직처리
			myPageService.userDelete(userIdx);
			
			mv.setViewName("redirect:/logout");
			return mv;
		}
	//===========================================================================
		
		

}
