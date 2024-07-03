package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CartDto;
import com.mf.dto.DeliveryDto;
import com.mf.dto.NearbyDto;
import com.mf.dto.OrdersDto;
import com.mf.dto.PersonDto;
import com.mf.jpa.CartService;
import com.mf.mapper.OrderMapper;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OrderMapper orderMapper;

	// @Autowired
	// private PagingMapper pagingMapper;

	@Autowired
	private CartService cartService;

	// 장바구니 페이지
	@RequestMapping("/myPage/cart")
	public ModelAndView getCart(HttpSession session, CartDto cartDto) {
		ModelAndView mv = new ModelAndView();
		Long userIdx = (Long) session.getAttribute("userIdx");

		// 세션에 userIdx가 제대로 설정되어 있는지 확인
		if (userIdx == null) {
			throw new IllegalArgumentException("User is not logged in.");
		}

		// 마이페이지 로직 처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		PersonDto person = (PersonDto) result.get("person");

		List<CartDto> cartList = orderMapper.selectCart(userIdx);

		mv.addObject("cartList", cartList);
		mv.addObject("person", person);
		mv.setViewName("myPage/cart");
		return mv;
	}

	// 배송지 관리 페이지
	@RequestMapping("/myPage/delivery")
	public ModelAndView getDelivery(HttpSession session, DeliveryDto deliveryDto) {
		ModelAndView mv = new ModelAndView();
		Long userIdx = (Long) session.getAttribute("userIdx");

		// 세션에 userIdx가 제대로 설정되어 있는지 확인
		if (userIdx == null) {
			throw new IllegalArgumentException("User is not logged in.");
		}

		// 마이페이지 로직 처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		PersonDto person = (PersonDto) result.get("person");

		List<DeliveryDto> deliveryList = orderMapper.selectDelivery(userIdx);
		int personIdx1 = orderMapper.selectPersonIdx(userIdx);

		mv.addObject("person", person);
		mv.addObject("personIdx", personIdx1);
		mv.addObject("deliveryList", deliveryList);
		mv.setViewName("myPage/delivery");
		return mv;
	}

	// 결제하는 페이지
	@RequestMapping("/myPage/payment")
	public ModelAndView getPayment(HttpSession session, OrdersDto ordesrDto, CartDto cartDto) {
		ModelAndView mv = new ModelAndView();
		Long userIdx = (Long) session.getAttribute("userIdx");

		// 세션에 userIdx가 제대로 설정되어 있는지 확인
		if (userIdx == null) {
			throw new IllegalArgumentException("User is not logged in.");
		}

		// 마이페이지 로직 처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		PersonDto person = (PersonDto) result.get("person");
		List<CartDto> cartList = orderMapper.selectCart2(userIdx);
		List<DeliveryDto> deliveryList = orderMapper.selectDelivery(userIdx);
		// OrdersDto orderList = orderMapper.selectOrderList(userIdx);
		DeliveryDto deliveryDto = orderMapper.selectDelivery2(userIdx);
		System.out.println(cartList);
		System.out.println(deliveryList);

		mv.addObject("person", person);
		mv.addObject("cartList", cartList);
		mv.addObject("deliveryDto", deliveryDto);
		// mv.addObject("orderList", orderList);
		mv.addObject("deliveryList", deliveryList);
		mv.setViewName("myPage/payment");
		return mv;
	}

	@PostMapping("/mypage/paying")
	@ResponseBody
	public void updateCartAndCreateOrder(@RequestParam("selectedItems") List<Long> selectedItems,
			@RequestParam Map<String, String> allParams, HttpServletResponse response, HttpSession session) {
		Long userIdx = (Long) session.getAttribute("userIdx");
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		PersonDto person = (PersonDto) result.get("person");
		Long personIdx = person.getPersonIdx();

		try {
			cartService.updateCartAndCreateOrder(selectedItems, allParams, personIdx);
			response.sendRedirect("/myPage/payment");
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.sendRedirect("/myPage/cart");
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	// 주문내역 페이지
	@RequestMapping("/myPage/order")
	public ModelAndView getOrder(HttpSession session, OrdersDto ordersDto) {
		ModelAndView mv = new ModelAndView();
		Long userIdx = (Long) session.getAttribute("userIdx");

		// 세션에 userIdx가 제대로 설정되어 있는지 확인
		if (userIdx == null) {
			throw new IllegalArgumentException("User is not logged in.");
		}

		// 마이페이지 로직 처리
		Map<String, Object> result = myPageService.getPersonMyPage(userIdx);
		PersonDto person = (PersonDto) result.get("person");
		Long personIdx = person.getPersonIdx();

		List<OrdersDto> orderList = orderMapper.selectOrder2(personIdx);

		
		mv.addObject("orderList", orderList);
		mv.setViewName("myPage/order");
		return mv;
	}
	
	//지역별 리스트 페이지
	@GetMapping("/nearbyList")
	public  ModelAndView  nearbyList() {
		ModelAndView mv = new ModelAndView();
		
		// 포스팅(날짜, 추천)
		List<NearbyDto> postingList = orderMapper.selectPosting();
		
		mv.addObject("postingList", postingList);
		mv.setViewName("/nearbyList");
		return mv;
	}
	
}
