package com.mf.controller;

import java.time.DayOfWeek;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import com.mf.mapper.OrderMapper;
import com.mf.service.CartService;
import com.mf.service.MyPageService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OrderMapper orderMapper;
	
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
	    
	 // 오늘 날짜를 가져옴
	    LocalDate today = LocalDate.now();
	    // 내일 날짜를 계산
	    LocalDate tomorrow = today.plusDays(1);
	    // 날짜 포맷 설정
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    // 내일의 요일을 가져옴
	    DayOfWeek dayOfWeek = tomorrow.getDayOfWeek();
	    
	    // 내일 날짜와 요일을 문자열로 변환
	    String formattedDate = tomorrow.format(dateFormatter);
	    
	    // 요일을 한글로 변환하는 로직
	    String dayOfWeekString = "";
	    switch(dayOfWeek) {
	        case MONDAY:
	            dayOfWeekString = "월요일";
	            break;
	        case TUESDAY:
	            dayOfWeekString = "화요일";
	            break;
	        case WEDNESDAY:
	            dayOfWeekString = "수요일";
	            break;
	        case THURSDAY:
	            dayOfWeekString = "목요일";
	            break;
	        case FRIDAY:
	            dayOfWeekString = "금요일";
	            break;
	        case SATURDAY:
	            dayOfWeekString = "토요일";
	            break;
	        case SUNDAY:
	            dayOfWeekString = "일요일";
	            break;
	    }
	    System.out.println(formattedDate);
	    
	    List<CartDto> cartList = orderMapper.selectCart(userIdx);
	    System.out.println(cartList);
	    
	    mv.addObject(formattedDate);
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
					 DeliveryDto deliveryDto = orderMapper.selectDelivery2(userIdx);
					 System.out.println("payment---------------------------");
					 System.out.println(cartList);
					 System.out.println(deliveryList);
					
					
					mv.addObject("person", person);
					mv.addObject("cartList", cartList);
					mv.addObject("deliveryDto", deliveryDto);
					mv.addObject("deliveryList", deliveryList);
					mv.setViewName("myPage/payment");
					return mv;
				}
				
				 @PostMapping("/mypage/paying")
				    @ResponseBody
				    public void updateCartAndCreateOrder(@RequestParam("selectedItems") List<Long> selectedItems,
				                           @RequestParam Map<String, String> allParams, HttpServletResponse response, HttpSession session){
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
}
