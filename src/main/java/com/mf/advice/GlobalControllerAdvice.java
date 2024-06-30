package com.mf.advice;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mf.dto.CategoryDto;
import com.mf.service.CustomUserDetails;
import com.mf.service.ProductService;
import com.mf.service.UsersService;

import jakarta.servlet.http.HttpSession;

// modelAttribute를 컨트롤러 전역에 쓰기위해 사용
@ControllerAdvice
public class GlobalControllerAdvice {
    @Autowired
    private UsersService usersService;
	
	@Autowired
	private ProductService productService;
		
	    @ModelAttribute
	    public void categories(Model model,HttpSession session){
	    	//카테고리 불러오기
			List<CategoryDto> category = productService.getCategory();
			
			// 등급 불러오기 위해서 시큐리티 인증 확인
		    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		    if (authentication != null) {
		        Object principal = authentication.getPrincipal();
		        Long userIdx = (Long) session.getAttribute("userIdx");

		        // 일반 회원 처리
		        if (principal instanceof CustomUserDetails) {
		            CustomUserDetails userDetails = (CustomUserDetails) principal;

		            Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
		            for (GrantedAuthority authority : authorities) {
		                if ("ROLE_PERSON".equals(authority.getAuthority())) {
		                    String levelName = usersService.getLevel(userIdx);
		                    model.addAttribute("levelName", levelName);
		                    break;
		                }
		            }
		        } else if (principal instanceof OAuth2User) {
		            OAuth2User oauth2User = (OAuth2User) principal;
		            // 사용자의 역할(role)을 확인하여 "ROLE_PERSON"인 경우에만 처리
		            if (oauth2User.getAuthorities().stream().anyMatch(auth -> "ROLE_PERSON".equals(auth.getAuthority()))) {
		                // 사용자 등급 정보 가져오기
		                String levelName = usersService	.getLevel(userIdx);
		                model.addAttribute("levelName", levelName);
		            }
		        }
		    }
			
			
	        model.addAttribute("category",category);
	    }
	}