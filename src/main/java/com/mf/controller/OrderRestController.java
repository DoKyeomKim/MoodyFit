package com.mf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mf.dto.CartDto;
import com.mf.dto.DeliveryDto;
import com.mf.dto.OrderDetailDto;
import com.mf.dto.PersonDto;
import com.mf.mapper.OrderMapper;
import com.mf.service.DeliveryService;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;

@RestController
public class OrderRestController {
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private DeliveryService deliveryService;

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
	
	 public static class DeliveryRequest {
	        private Integer deliveryIdx;

	        public Integer getDeliveryIdx() {
	            return deliveryIdx;
	        }

	        public void setDeliveryIdx(Integer deliveryIdx) {
	            this.deliveryIdx = deliveryIdx;
	        }
	    }
	 
	 @RequestMapping("/myPage/deleteDelivery")
		public ResponseEntity<Map<String, String>> updateDelivery(HttpSession session,
				DeliveryDto deliveryDto, @RequestBody DeliveryRequest request ) {
			// 
		 Integer deliveryIdx = request.getDeliveryIdx();
			Long userIdx = (Long) session.getAttribute("userIdx");

		    // 세션에 userIdx가 제대로 설정되어 있는지 확인
		    if (userIdx == null) {
		        throw new IllegalArgumentException("User is not logged in.");
		    }

		    // 마이페이지 로직 처리
		    Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		    PersonDto person = (PersonDto) result.get("person");
		   

			   orderMapper.deleteDelivery(deliveryIdx);
			// JSON 형식의 응답 생성
			    Map<String, String> response = new HashMap<>();
			    response.put("message", "success");

			    return ResponseEntity.ok(response);
		}
	 
	// Get delivery details by ID
	 @PostMapping("/myPage/getDelivery")
	 public DeliveryDto getDelivery(@RequestBody DeliveryRequest request) {
		 Integer deliveryIdx = request.getDeliveryIdx();
	        return deliveryService.getDeliveryById(deliveryIdx);
	    }
	 
	 public static class CartRequest {
	        private Integer cartIdx;

	        public Integer getCartIdx() {
	            return cartIdx;
	        }

	        public void setCartIdx(Integer cartIdx) {
	            this.cartIdx = cartIdx;
	        }
	    }
	 @RequestMapping("/myPage/editDelivery")
	 public ResponseEntity<Map<String, String>> editDelivery(HttpSession session, DeliveryDto deliveryDto,
			 	@RequestParam("deliveryIdx") Integer deliveryIdx,
			 	@RequestParam("name") String name,
		        @RequestParam("deliveryName") String deliveryName,
		        @RequestParam("email") String email,
		        @RequestParam("phone") String phone,
		        @RequestParam("postCode") String postCode,
		        @RequestParam("address") String address,
		        @RequestParam("detailAddress") String detailAddress,
		        @RequestParam("content") String content) {
		 // 
		 Long userIdx = (Long) session.getAttribute("userIdx");
		 
		 // 세션에 userIdx가 제대로 설정되어 있는지 확인
		 if (userIdx == null) {
			 throw new IllegalArgumentException("User is not logged in.");
		 }
		 // 마이페이지 로직 처리
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		 PersonDto person = (PersonDto) result.get("person");
		 
		 orderMapper.editDelivery(deliveryDto);
		 // JSON 형식의 응답 생성
		 Map<String, String> response = new HashMap<>();
		 response.put("message", "success");
		 
		 return ResponseEntity.ok(response);
	 }
	 
	 @RequestMapping("/myPage/deleteCart")
		public ResponseEntity<Map<String, String>> deleteCart(HttpSession session,
				CartDto cartDto, @RequestBody CartRequest request ) {
			// 
		 Integer cartIdx = request.getCartIdx();
			Long userIdx = (Long) session.getAttribute("userIdx");

		    // 세션에 userIdx가 제대로 설정되어 있는지 확인
		    if (userIdx == null) {
		        throw new IllegalArgumentException("User is not logged in.");
		    }

		    // 마이페이지 로직 처리
		    Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		    PersonDto person = (PersonDto) result.get("person");
		    	System.out.println(cartIdx);
		    	System.out.println(cartIdx);
		    	System.out.println(cartIdx);

			   orderMapper.deleteCart(cartIdx);
			// JSON 형식의 응답 생성
			    Map<String, String> response = new HashMap<>();
			    response.put("message", "success");

			    return ResponseEntity.ok(response);
		}
	 
	 @RequestMapping("/myPage/deleteCart2")
	 public ResponseEntity<Map<String, String>> deleteCart2(HttpSession session,
			 CartDto cartDto, @RequestBody CartRequest request ) {
		 // 
		 Integer cartIdx = request.getCartIdx();
		 Long userIdx = (Long) session.getAttribute("userIdx");
		 
		 // 세션에 userIdx가 제대로 설정되어 있는지 확인
		 if (userIdx == null) {
			 throw new IllegalArgumentException("User is not logged in.");
		 }
		 
		 // 마이페이지 로직 처리
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		 PersonDto person = (PersonDto) result.get("person");
		 
		 orderMapper.deleteCart2(cartIdx);
		 // JSON 형식의 응답 생성
		 Map<String, String> response = new HashMap<>();
		 response.put("message", "success");
		 
		 return ResponseEntity.ok(response);
	 }
	 
	 
	 @RequestMapping("/myPage/updateDelivery")
	 public ResponseEntity<Map<String, String>> updateDelivery2(HttpSession session,
			 DeliveryDto deliveryDto, @RequestBody DeliveryRequest request ) {
		 // 
		 Integer deliveryIdx = request.getDeliveryIdx();
		 Long userIdx = (Long) session.getAttribute("userIdx");
		 
		 // 세션에 userIdx가 제대로 설정되어 있는지 확인
		 if (userIdx == null) {
			 throw new IllegalArgumentException("User is not logged in.");
		 }
		 
		 // 마이페이지 로직 처리
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		 PersonDto person = (PersonDto) result.get("person");
		 Long personIdx = person.getPersonIdx();
		 
		 orderMapper.updateDelivery(personIdx);
		 orderMapper.updateDelivery2(deliveryIdx);

		 // JSON 형식의 응답 생성
		 Map<String, String> response = new HashMap<>();
		 response.put("message", "success");
		 
		 return ResponseEntity.ok(response);
	 }
}
