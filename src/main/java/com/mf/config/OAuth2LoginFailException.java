package com.mf.config;

import org.springframework.security.core.AuthenticationException;

public class OAuth2LoginFailException extends AuthenticationException {

    public OAuth2LoginFailException(String message) {
        super(message);
    }
}