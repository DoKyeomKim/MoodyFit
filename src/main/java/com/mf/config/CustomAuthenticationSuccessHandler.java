package com.mf.config;
import java.io.IOException;
import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.mf.service.CustomUserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String id = userDetails.getUsername();
        Long userIdx = userDetails.getUserIdx();
        Collection<? extends GrantedAuthority> authorities  = userDetails.getAuthorities();
        
        HttpSession session = request.getSession();
        session.setAttribute("userIdx", userIdx);
        for (GrantedAuthority authority : authorities) {
            session.setAttribute("role", authority.getAuthority());
        }
        session.setAttribute("id", id);
        
        response.sendRedirect("/");
    }
}
