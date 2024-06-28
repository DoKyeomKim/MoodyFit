package com.mf.controller;

import java.util.Collections;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.CartDto;
import com.mf.dto.DeliveryDto;
import com.mf.dto.OrdersDto;
import com.mf.dto.PersonDto;
import com.mf.jpa.CartService;
import com.mf.mapper.OrderMapper;
import com.mf.paging.Pagination;
import com.mf.paging.PagingMapper;
import com.mf.paging.PagingResponse;
import com.mf.paging.SearchVo;
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

	// 배송지 관리 페이지
	/*
	 * @RequestMapping("/myPage/addDelivery") public String addDelivery(HttpSession
	 * session, DeliveryDto deliveryDto, Model model,
	 * 
	 * @RequestParam("name") String name,
	 * 
	 * @RequestParam("deliveryName") String deliveryName,
	 * 
	 * @RequestParam("email") String email,
	 * 
	 * @RequestParam("phone") String phone,
	 * 
	 * @RequestParam("postCode") String postCode,
	 * 
	 * @RequestParam("address") String address,
	 * 
	 * @RequestParam("personIdx") int personIdx,
	 * 
	 * @RequestParam("detailAddress") String detailAddress,
	 * 
	 * @RequestParam("content") String content) { ModelAndView mv = new
	 * ModelAndView(); Long userIdx = (Long) session.getAttribute("userIdx");
	 * 
	 * // 세션에 userIdx가 제대로 설정되어 있는지 확인 if (userIdx == null) { throw new
	 * IllegalArgumentException("User is not logged in."); }
	 * 
	 * // 마이페이지 로직 처리 Map<String, Object> result =
	 * myPageService.getPersonMyPage(userIdx); PersonDto person = (PersonDto)
	 * result.get("person");
	 * 
	 * orderMapper.insertDelivery(deliveryDto);
	 * 
	 * List<DeliveryDto> deliveryList = orderMapper.selectDelivery(userIdx);
	 * 
	 * 
	 * model.addAttribute("message", "Delivery added successfully");
	 * 
	 * return "redirect:/myPage/delivery"; }
	 */

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

		/*
		// 페이징
		int count = pagingMapper.count(personIdx);
		PagingResponse<OrdersDto> response = null;
		if (count < 1) {
			response = new PagingResponse<>(Collections.emptyList(), null);
		}

		// 페이징을 위한 초기설정값
		SearchVo searchVo = new SearchVo();
		searchVo.setPage(nowpage);
		searchVo.setPageSize(10); // 기본10개 -> 20개

		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
		Pagination pagination = new Pagination(count, searchVo);
		searchVo.setPagination(pagination);
		int offset = pagination.getLimitStart();
		int pageSize = searchVo.getRecordSize();

		// 계산된 페이지 정보의 일부 (limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 변환
		List<OrdersDto> list = pagingMapper.getOrderPagingList(personIdx, offset, pageSize);
		response = new PagingResponse<>(list, pagination);
*/
//						Map<Long, List<OrdersDto>> groupedOrderItems = orderList.stream()
//				                .collect(Collectors.groupingByConcurrent(orderList::getOrderIdx));
//						
		// mv.addObject("response", response);
		mv.addObject("orderList", orderList);
		mv.setViewName("myPage/order");
		return mv;
	}
}
