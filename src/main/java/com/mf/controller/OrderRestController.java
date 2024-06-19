package com.mf.controller;

import java.net.URI;
import java.net.http.HttpHeaders;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.mf.dto.DeliveryDto;
import com.mf.dto.OrderDetailDto;
import com.mf.dto.PersonDto;
import com.mf.mapper.OrderMapper;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;

@RestController
public class OrderRestController {
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OrderMapper orderMapper;
	
	@PostMapping("/myPage/paying")
	public ResponseEntity<String> stateCheck(HttpSession session, @RequestBody OrderDetailDto orderDetailDto) {
		
		Long userIdx = (Long) session.getAttribute("userIdx");

	    // 세션에 userIdx가 제대로 설정되어 있는지 확인
	    if (userIdx == null) {
	        throw new IllegalArgumentException("User is not logged in.");
	    }

	    // 마이페이지 로직 처리
	    Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
	    PersonDto person = (PersonDto) result.get("person");

	    

		   orderMapper.insertOrderDetail(orderDetailDto);
		  

		    return ResponseEntity.ok("완료 처리된 지원 이력서");
	}
		
	 @PostMapping("/myPage/addDelivery")
	    public ResponseEntity<String> addDelivery(HttpSession session,DeliveryDto deliveryDto,
	        @RequestParam("name") String name,
	        @RequestParam("deliveryName") String deliveryName,
	        @RequestParam("email") String email,
	        @RequestParam("phone") String phone,
	        @RequestParam("postCode") String postCode,
	        @RequestParam("address") String address,
	        @RequestParam("detailAddress") String detailAddress,
	        @RequestParam("content") String content) {
	        
	        // Your logic to save the delivery details
	        // e.g., deliveryService.save(new Delivery(...));
		 	Long userIdx = (Long) session.getAttribute("userIdx");
			
			// 세션에 userIdx가 제대로 설정되어 있는지 확인
			if (userIdx == null) {
				throw new IllegalArgumentException("User is not logged in.");
			}
			
			// 마이페이지 로직 처리
			Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
			PersonDto person = (PersonDto) result.get("person");
			
			orderMapper.insertDelivery(deliveryDto);
			
			List<DeliveryDto> deliveryList = orderMapper.selectDelivery(userIdx);
			
			 // 성공적으로 저장된 후 응답
	        return ResponseEntity.ok("Delivery added successfully");
	    }		
	
}
