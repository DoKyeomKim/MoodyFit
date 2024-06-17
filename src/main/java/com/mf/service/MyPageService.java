package com.mf.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.jaxb.SpringDataJaxb.OrderDto;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;
import com.mf.mapper.MyPageMapper;

import jakarta.transaction.Transactional;

@Service
public class MyPageService {
	@Autowired
	private MyPageMapper myPageMapper;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

	// 개인 마이페이지 서비스 로직
	public Map<String, Object> getPersonMyPage(Long userIdx) {
		// 닉네임과 personIdx 갖고오기
		PersonDto person = myPageMapper.getNickNameByUserIdx(userIdx);
		
		// 배송 준비중인 물품 갖고오기
		// 배송 준비중
		OrderDto orderPrePare = myPageMapper.getOrderPrePare(userIdx);
		// 배송중
		OrderDto orderIng = myPageMapper.getOrderIng(userIdx);
		// 배송 완료
		OrderDto orderDone = myPageMapper.getOrderDone(userIdx);
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("person", person);
		result.put("orderPrePare", orderPrePare);
		result.put("orderIng", orderIng);
		result.put("orderDone", orderDone);
		return result;
	}
	
	// 개인 정보 수정을 위한 전체 정보 들고 오기
	public Map<String, Object> getPersonInfo(Long userIdx) {
		// userIdx로 개인정보 전체 들고 오기
		Map<String,Object> result = myPageMapper.getPersonInfo(userIdx);

		return result;
	}
	
	// 회원 정보 수정
	@Transactional
	public void personUpdate(Long userIdx, UsersDto users, PersonDto person, PersonSpecDto personSpec) {
        UsersDto existingUser = myPageMapper.getUserById(userIdx);

        // 사용자가 비밀번호를 변경하려고 하는지 확인
        if (users.getPw() != null && !users.getPw().isEmpty()) {
            // 새로운 비밀번호를 암호화하여 설정
            String encodedPassword = bCryptPasswordEncoder.encode(users.getPw());
            users.setPw(encodedPassword);
        } else {
            // 비밀번호를 변경하지 않으므로 기존 비밀번호 유지
            users.setPw(existingUser.getPw());
        }
        // userIdx 미리 입력
        users.setUserIdx(userIdx);
        
        // users 수정
		myPageMapper.usersUpdate(users);
		// person 수정
		myPageMapper.personUpdate(person);
		// person_spec 수정
		myPageMapper.personSpecUpdate(personSpec);
	}
	
	
//===========================================================================================
	
	// 가맹점 마이페이지 서비스 로직
	public Map<String, Object> getShopMyPage(Long userIdx) {
		// 상호명과 storeIdx 갖고오기
		StoreDto store = myPageMapper.getStoreNameByUserIdx(userIdx);
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("store", store);
		
		return result;
	}
	
	// 가맹점 정보 수정용 정보 들고오기
	public Map<String, Object> getStoreInfo(Long userIdx) {
		Map<String,Object> result = myPageMapper.getStoreInfo(userIdx);
		return result;
	}

	// 가맹점 정보수정
	@Transactional
	public void storeUpdate(Long userIdx, UsersDto users, StoreDto store) {
		UsersDto existingUser = myPageMapper.getUserById(userIdx);
		
        // 사용자가 비밀번호를 변경하려고 하는지 확인
        if (users.getPw() != null && !users.getPw().isEmpty()) {
            // 새로운 비밀번호를 암호화하여 설정
            String encodedPassword = bCryptPasswordEncoder.encode(users.getPw());
            users.setPw(encodedPassword);
        } else {
            // 비밀번호를 변경하지 않으므로 기존 비밀번호 유지
            users.setPw(existingUser.getPw());
        }
        // userIdx 미리 입력
        users.setUserIdx(userIdx);
        // users 수정
		myPageMapper.usersUpdate(users);
		// store 수정
		myPageMapper.storeUpdate(store);
        
	}
	
	//회원탈퇴
	public void userDelete(Long userIdx) {
		myPageMapper.userDelete(userIdx);
		
		// 나중에 if문 추가해서 가맹점회원 공고 내리기까지 추가
		// 개인회원은 장바구니 삭제 정도?
		// 주문(orders) 관련해서는 유지해야할듯
	}


}
