package com.mf.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mf.config.OAuth2LoginFailException;
import com.mf.dto.CustomOAuth2User;
import com.mf.dto.GoogleResponse;
import com.mf.dto.NaverResponse;
import com.mf.dto.OAuth2Response;
import com.mf.dto.PersonDto;
import com.mf.dto.UsersDto;
import com.mf.mapper.UsersMapper;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    private UsersMapper usersMapper;
    @Autowired
    private HttpSession session;
    @Autowired
    private HttpServletResponse response;

	
      @Transactional
	  @Override
	    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

	        OAuth2User oAuth2User = super.loadUser(userRequest);

	        String registrationId = userRequest.getClientRegistration().getRegistrationId();
	        OAuth2Response oAuth2Response = null;
	        if (registrationId.equals("naver")) {

	            oAuth2Response = new NaverResponse(oAuth2User.getAttributes());

	        }
	        else if (registrationId.equals("google")) {

	            oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
	        }
	        else {

	            return null;
	        }
	        
	        
	        
	        // users에 들어갈 id
	        String id = oAuth2Response.getProvider()+" "+oAuth2Response.getProviderId();
	        // users에 들어갈 pw
	         String pw = passwordEncoder.encode(generateRandomPassword());
	        // users에 들어갈 role
	        String role = "ROLE_PERSON";
	        // person에 들어갈 이름
	        String name = oAuth2Response.getName();
	        // person에 들어갈 nickName
	        String nickName = name;
	        // person에 들어갈 email
	        String email = oAuth2Response.getEmail();
	        // person에 들어갈 social
	        String social = "YES";
	        // person에 들어갈 social_root	        
	        String socialRoot = registrationId;
	      
	        UsersDto statePerson = usersMapper.getUserByIdAndState(id);
	        if(statePerson != null) {
	        	
	            throw new OAuth2LoginFailException("회원 정보가 존재함");
	        }
	        
	        // 중복 방지용 확인
	        UsersDto existPerson = usersMapper.getUserById(id);
	        if(existPerson==null) {
	        	UsersDto users = new UsersDto();
	        	users.setId(id);
	        	users.setPw(pw);
	        	PersonDto person = new PersonDto();
	        	person.setName(name);
	        	person.setNickName(nickName);
	        	person.setEmail(email);
	        	person.setSocial(social);
	        	person.setSocialRoot(socialRoot);
	        	usersMapper.OAuthJoin(users);
	        	usersMapper.OAuthPersonJoin(person);
	        	usersMapper.OAuthSpecJoin();
	    
	        	    try {
						response.sendRedirect("/personUpdateForm?newUser=true");
					} catch (IOException e) {
						e.printStackTrace();
					}
	        	    
	        	}
	        
	        
	        UsersDto nowPerson = usersMapper.getUserById(id);
	        
	        String user_role = nowPerson.getRole();	        
	        Long userIdx = nowPerson.getUserIdx();
	        session.setAttribute("userIdx", userIdx);
	        session.setAttribute("role", user_role);
	        
	        return new CustomOAuth2User(oAuth2Response, role);
	    }
	  
	  // 비밀번호 설정
	    private String generateRandomPassword() {
	        return "randomPassword";
	    }
}
