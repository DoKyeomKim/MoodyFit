package com.mf.service;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.mf.dto.UsersDto;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UsersService usersService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsersDto user = usersService.findById(username);
        if (user == null) {
            throw new UsernameNotFoundException("회원 정보가 없습니다");
        }
        GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole());
        return new User(user.getId(), user.getPw(), Collections.singletonList(authority));
    }
}
