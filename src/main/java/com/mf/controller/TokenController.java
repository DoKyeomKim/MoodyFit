package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mf.dto.OrdersDto;
import com.mf.dto.PersonDto;
import com.mf.jpa.CartService;
import com.mf.mapper.OrderMapper;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;

@RestController
public class TokenController {

	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private RestTemplate restTemplate;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderMapper orderMapper;

	@Value("${iamport.api.url}")
	private String iamportApiUrl;

	@Value("${iamport.api.key}")
	private String iamportApiKey;

	@Value("${iamport.api.secret}")
	private String iamportApiSecret;

	@RequestMapping("/api/postToken")
	public ResponseEntity<String> postToken(  @RequestBody Map<String, Object> request, OrdersDto ordersDto, HttpSession session ) throws Exception {
		
		
		Long userIdx = (Long) session.getAttribute("userIdx");
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
			PersonDto person = (PersonDto) result.get("person");
			Long personIdx = person.getPersonIdx();
		
		//   @RequestParam("impUid") String impUid
		 String impUid = (String) request.get("impUid");
		System.out.println(impUid);
		System.out.println(impUid);
		System.out.println(impUid);
		System.out.println(impUid);
		
		
		// IAMPORT API URL
		String url = iamportApiUrl + "/users/getToken";
		// HTTP Headers 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		// 요청 바디 설정
		String requestJson = String.format("{\"imp_key\": \"%s\", \"imp_secret\": \"%s\"}", iamportApiKey,
				iamportApiSecret);

		HttpEntity<String> entity = new HttpEntity<>(requestJson, headers);

		// IAMPORT API 호출
		ResponseEntity<String> tokenResponse = restTemplate.postForEntity(url, entity, String.class);

		System.out.println(tokenResponse);

		// 호출한 토큰을 사용하여 api 단건 내역 조회
		if (tokenResponse.getStatusCode().is2xxSuccessful()) {
			// 토큰 발급 성공 시 response body에서 access_token 추출
			
			ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(tokenResponse.getBody());
            JsonNode accessTokenNode = rootNode.path("response").path("access_token");
            String tokenUse = accessTokenNode.asText();
            
			System.out.println("-----------------------------------");
			System.out.println(tokenUse);
			  
			// imp_uid 값 
			// String impUid = "imp_789398296534"; // imp_uid 값 받아와야함
			
			 // 결제내역 조회 API URL 
			  String paymentUrl = iamportApiUrl + "/payments/" + impUid;
			  
			// HTTP Headers 설정
			  HttpHeaders paymentHeaders = new HttpHeaders();
			  paymentHeaders.setContentType(MediaType.APPLICATION_JSON);
			  paymentHeaders.set("Authorization", "Bearer " + tokenUse);
			  
			  HttpEntity<Void> paymentEntity = new HttpEntity<>(paymentHeaders);
			  
			// 헤더 확인 출력
	            System.out.println("Payment Headers: " + paymentHeaders.toString());

	            // 결제 내역 조회
	            ResponseEntity<String> paymentResponse = restTemplate.exchange(paymentUrl, HttpMethod.GET, paymentEntity, String.class);

	            if (paymentResponse.getStatusCode().is2xxSuccessful() && paymentResponse.getBody() != null) {
	                JsonNode paymentRootNode = objectMapper.readTree(paymentResponse.getBody());
	                JsonNode amountNode = paymentRootNode.path("response").path("amount");
	                JsonNode merchantUidNode = paymentRootNode.path("response").path("merchant_uid");
	                
	                Long amount = (long) amountNode.asInt();
	                String merchant_uid = merchantUidNode.asText();

	                System.out.println("Amount: " + amount);
	                System.out.println("Merchant_uid: " + merchant_uid);
	                Long totalPrice = orderMapper.selectTotalPrice(userIdx);	
	                System.out.println("totalPrice: " + totalPrice);
	                if (amount.equals(totalPrice)) {
	                	 System.out.println("결제 내역과 주문내역의 금액이 같다");
	                	 orderMapper.updateImpUid(impUid, personIdx);
	                	 List<Integer> cartIdxs = orderMapper.selectCartIdxByImpUid(impUid);
	                	 for (Integer cartIdx : cartIdxs) {
	                         orderMapper.updateCartStateToComplete(cartIdx);
	                     }
	                    return ResponseEntity.ok("Success");
	                } else {
	                	System.out.println("결제 내역과 주문내역의 금액이 다르다1");
	                    return ResponseEntity.status(HttpStatus.FOUND)
	                            .header(HttpHeaders.LOCATION, "http://localhost:9090/")
	                            .build();
	                }
	            } else {
	            	System.out.println("결제 내역과 주문내역의 금액이 다르다2");
	                return ResponseEntity.status(HttpStatus.FOUND)
	                        .header(HttpHeaders.LOCATION, "http://localhost:9090/")
	                        .build();
	            }
	        } else {
	        	System.out.println("결제 내역과 주문내역의 금액이 다르다3");
	            return ResponseEntity.status(HttpStatus.FOUND)
	                    .header(HttpHeaders.LOCATION, "http://localhost:9090/")
	                    .build();
	        }
		
	    }

	
	}