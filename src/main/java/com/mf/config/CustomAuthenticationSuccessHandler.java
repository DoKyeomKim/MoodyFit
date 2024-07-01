package com.mf.config;
import java.io.IOException;
import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.mf.service.CustomUserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Long userIdx = userDetails.getUserIdx();
        Collection<? extends GrantedAuthority> authorities  = userDetails.getAuthorities();
        
        HttpSession session = request.getSession();
        session.setAttribute("userIdx", userIdx);
        for (GrantedAuthority authority : authorities) {
            session.setAttribute("role", authority.getAuthority());
            
        }
        
        // 아이디 기억하기 기능 추가(쿠키)
        String remember = request.getParameter("remember_id");
        String username = userDetails.getUsername();

        if ("on".equals(remember)) {
            Cookie rememberCookie = new Cookie("rememberedId", username);
            // 쿠키 저장 기간 30일 설정
            rememberCookie.setMaxAge(30 * 24 * 60 * 60);
            rememberCookie.setPath("/");
            response.addCookie(rememberCookie);
        } else {
        	// 아이디 기억 체크박스 해제 시 쿠키 삭제
            Cookie rememberCookie = new Cookie("rememberedId", null);
            rememberCookie.setMaxAge(0);
            rememberCookie.setPath("/");
            response.addCookie(rememberCookie);
        }
	
        
        response.sendRedirect("/");
    }
}
