package com.mf.service;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class CustomUserDetails implements UserDetails {
    private final String id;
    private final String pw;
    private final Long userIdx;
    private final Collection<? extends GrantedAuthority> authorities;

    public CustomUserDetails(String id, String pw, Long userIdx, Collection<? extends GrantedAuthority> authorities) {
        this.id = id;
        this.pw = pw;
        this.userIdx = userIdx;
        this.authorities = authorities;
    }

    public Long getUserIdx() {
        return userIdx;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return pw;
    }

    @Override
    public String getUsername() {
        return id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
