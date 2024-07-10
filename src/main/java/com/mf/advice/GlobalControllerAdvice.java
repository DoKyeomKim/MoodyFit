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
	    public void categories(Model model){
	    	//카테고리 불러오기
			List<CategoryDto> category = productService.getCategory();
			
	        model.addAttribute("category",category);
	    }
	}