package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.domain.jaxb.SpringDataJaxb.OrderDto;

import com.mf.dto.PersonDto;
import com.mf.dto.PersonLevelDto;
import com.mf.dto.PersonSpecDto;
import com.mf.dto.StoreDto;
import com.mf.dto.UsersDto;

@Mapper
public interface MyPageMapper {

	// 세션 저장된 userIdx로 닉네임 갖고오기
	PersonDto getNickNameByUserIdx(Long userIdx);

	// ========== 주문 현황 갖고오기 ==========
	// 배송 준비중
	int getOrderPrePare(Long userIdx);
	// 배송중
	int getOrderIng(Long userIdx);
	// 배송 완료
	int getOrderDone(Long userIdx);
	// ========================================
	
	// 개인회원 정보 전체 갖고 오기(정보수정용)
	Map<String, Object> getPersonInfo(Long userIdx);
	
	// 정보 수정용 비밀번호 일치 확인
	UsersDto getUserById(Long userIdx);
	
	// 개인회원+편집샵회원 users 수정
	void usersUpdate(UsersDto users);
	
	// 개인회원 person 수정
	void personUpdate(PersonDto person);
	// 개인회원 person_spec 수정
	void personSpecUpdate(PersonSpecDto personSpec);
	
	// 위시리스트 갖고 오기
	List<Map<String, Object>> getWishList(Map<String, Object> params);
	
	// 레벨 등급 확인표
	List<PersonLevelDto> getPersonLevel();

	// 총 구매 가격
	Map<String, Object> getAllUserPurchase(Long userIdx);

	// 장바구니 수
	int getCartCount(Long userIdx);
	
	//=====================================================
	//=======================편집샵========================
	//=====================================================
	
	// 세션 저장된 userIdx로 상호명 갖고오기
	StoreDto getStoreNameByUserIdx(Long userIdx);
	
	// 정보 수정용 
	Map<String, Object> getStoreInfo(Long userIdx);
	
	// 편집샵 회원 store 수정
	void storeUpdate(StoreDto store);
	
	// 매출 상위 제품
	List<Map<String, Object>> getTopPosting(Long userIdx);

	// 내 공고 갯수
	int getPostingCount(Long userIdx);

	// 내 상품 갯수
	int getProductCount(Long userIdx);

	// 내 상품 주문 갯수
	int getOrderCount(Long userIdx);
	
	// 내 총 매출
	int getTotalRevenue(Long userIdx);

	// 내 공고 주문 현황
	List<Map<String, Object>> getOrdersByUserIdx(Long userIdx);

	
	//======================== 공통 ========================
	// 회원 탈퇴
	void userDelete(Long userIdx);

	int getWishListCount(Long userIdx);

	// 쿠키 공고 들고오기
	Map<String, Object> getPostingByPostingIdx(Long postingIdx);












}
