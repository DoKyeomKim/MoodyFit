package com.mf.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

import com.mf.service.CustomOAuth2UserService;
import com.mf.service.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private CustomUserDetailsService userDetailsService;

	@Autowired
    private CustomAuthFailureHandler customFailureHandler; // CustomAuthFailureHandler 주입
	
	@Autowired
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	
    private final CustomOAuth2UserService customOAuth2UserService;

    public SecurityConfig(CustomOAuth2UserService customOAuth2UserService) {

        this.customOAuth2UserService = customOAuth2UserService;
    }



	
	@Bean
	public WebSecurityCustomizer configure() {
		return (web) -> web.ignoring().requestMatchers("/css/**").requestMatchers("/js/**")
				.requestMatchers("/images/**") // /static/** : .html, .js, .css
				.requestMatchers("/WEB-INF/**") // /static/** : .html, .js, .css
				.requestMatchers("/static/**");
	}

// 로그인 관련 인가

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests((auth) -> auth
				.requestMatchers("/","/api/**","/findIdForm","/findId","/faq**","/qna","/category/**","/category/**", "/emailCheck",
						"/oauth2/**","/postingDetail","/search**","/totalJoin","/login","/idCheck","/storeNameCheck",
						"/nickNameCheck","/loginProcess", "/storeJoin","/storeJoinProcess","/join", 
						"/joinProcess","/error","/loginFail").permitAll()
				.requestMatchers("/admin/admin**","/admin**","/admin/**","/EP**").hasRole("ADMIN")
				.requestMatchers("/myPage/**","/personUpdateForm","/personUpdate").hasAnyRole("ADMIN","PERSON")
				.requestMatchers("/storeMyPage","/storeUpdateForm").hasAnyRole("ADMIN","STORE")
				.requestMatchers("/accountDeleteForm").hasAnyRole("PERSON","STORE")
				.anyRequest().authenticated()
				);



		http.formLogin((auth) -> auth.loginPage("/login")
				.loginProcessingUrl("/loginProcess").permitAll()
				.usernameParameter("id")
				.passwordParameter("pw")
				.successHandler(customAuthenticationSuccessHandler)
				.failureHandler(customFailureHandler)
				);
		
        http
        .oauth2Login((oauth2) -> oauth2
        		.loginPage("/oauth2/authorization/naver") // 네이버 로그인 페이지
                .userInfoEndpoint((userInfoEndpointConfig) -> userInfoEndpointConfig.userService(customOAuth2UserService))
				.failureHandler(customFailureHandler)
        		);
        
        http.oauth2Login((oauth2) -> oauth2
                .loginPage("/oauth2/authorization/google") // 구글 로그인 페이지
                .userInfoEndpoint((userInfoEndpointConfig) -> userInfoEndpointConfig.userService(customOAuth2UserService))
                .failureHandler(customFailureHandler));
		
		http.logout((logout)->logout
				.logoutUrl("/logout")
				.logoutSuccessUrl("/") // 로그아웃 성공 후 리다이렉트할 URL
	            .invalidateHttpSession(true)
	            .permitAll()
				);
		
		
		http.csrf((auth) -> auth.disable());

		return http.build();
	}

// "/" 루트 페이지 갈 수 있게 하는 빈 추가

	@Bean
	public HttpFirewall defaultHttpFirewall() {
		return new DefaultHttpFirewall();
	}
}
