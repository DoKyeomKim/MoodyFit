package com.mf.controller;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CartDto;
import com.mf.dto.OrderRequest;
import com.mf.dto.OrdersDto;
import com.mf.dto.PersonDto;
import com.mf.jpa.CartService;
import com.mf.mapper.OrderMapper;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;


@RestController
@Transactional
public class PayController {
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private CartService cartService;
	
	 // 재고 확인 및 재고 차감
	@PostMapping("/myPage/cartQuantity")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateCartQuantity(@RequestBody Map<String, Object> basketData1) {
        Map<String, Object> response = new HashMap<>();
        try {
            // cartQuantity 업데이트 로직 수행
            boolean updateSuccess = cartService.updateCartQuantity(basketData1);
            
            if (updateSuccess) {
                response.put("status", "success");
            } else {
                response.put("status", "failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            throw e; // 트랜잭션 롤백을 위해 예외를 다시 던짐
        }
        return ResponseEntity.ok(response);
    }
	
	// 주문내역 생성
	@PostMapping("/myPage/orderMake")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getOrderMake(@RequestBody Map<String, Object> basketData1, HttpSession session) {
	    
	
		Map<String, Object> response = new HashMap<>();
		
		Long userIdx = (Long) session.getAttribute("userIdx");
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
			PersonDto person = (PersonDto) result.get("person");
			Long personIdx = person.getPersonIdx();
			
		try {
			// 주문내역 DB 생성
			boolean updateSuccess = cartService.insertOrder(basketData1);
			if (updateSuccess) {
				
				response.put("status", "success");
			} else {
				response.put("status", "failure");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			throw e; // 트랜잭션 롤백을 위해 예외를 다시 던짐
		}
		return ResponseEntity.ok(response);
	}
	
	
	/*
	@RequestMapping("/myPage/orderMake")
	public ModelAndView getOrderMake(@RequestParam("selectedItems") List<Long> selectedItems,
			HttpSession session, CartDto cartDto,OrderRequest orderRequest) throws Exception {
		System.out.println(orderRequest);
		System.out.println("---------------------------------");
		System.out.println(orderRequest);
		
		orderMapper.insertOrder(orderRequest);
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/myPage/payPay");
		return mv;
	}
	*/
	
	@RequestMapping("/myPage/payPay")
	public ModelAndView getPayPay(HttpSession session, CartDto cartDto, OrdersDto ordersDto) {
		
		Long userIdx = (Long) session.getAttribute("userIdx");
		 Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
			PersonDto person = (PersonDto) result.get("person");
			Long personIdx = person.getPersonIdx();
		
		OrdersDto orderList = orderMapper.selectOrder(userIdx);
		
		System.out.println("------------------------------------");
		System.out.println("orderList = " + orderList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("orderList", orderList);
		mv.setViewName("/myPage/payPay");
		return mv;
	}
	   
}
