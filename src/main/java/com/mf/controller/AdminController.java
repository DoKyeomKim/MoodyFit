package com.mf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.AdminAnswerDto;
import com.mf.dto.AdminApplyDto;
import com.mf.dto.AdminOrderDto;
import com.mf.dto.AdminReviewDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.CsFaqDto;
import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;
import com.mf.dto.SubCategoryDto;
import com.mf.service.AdminApplyService;
import com.mf.service.AdminOrderService;
import com.mf.service.AdminQnaServiceImpl;
import com.mf.service.AdminReviewService;
import com.mf.service.CategoryService;
import com.mf.service.FAQService;
import com.mf.service.PersonService;
import com.mf.service.StoreService;
import com.mf.service.SubCategoryService;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	@Autowired
	private SubCategoryService SubcategoryService;
    @Autowired
    private PersonService personService;	
    @Autowired
    private AdminReviewService adminReviewService;
	@Autowired
	private FAQService faqService;
	@Autowired
	private CategoryService categoryService;
    @Autowired
    private StoreService storeService;
	@Autowired
	private AdminQnaServiceImpl adminQnaService;
	@Autowired
	private AdminOrderService adminOrderService;
	@Autowired
	private AdminApplyService adminApplyService;
 
	   
   //관리자 메인페이지
	@GetMapping("/admin")
	public  ModelAndView   home() {
		ModelAndView    mv    = new ModelAndView("adminMain");
		
		mv.setViewName("/adminMain");
		return mv;
	}
	//카테고리 등록 페이지
	@RequestMapping("/adminCategoryWrite")
	public  ModelAndView   adminCategoryWrite() {
		ModelAndView    mv    = new ModelAndView("adminCategoryWrite");
		
		mv.setViewName("/admin/adminCategoryWrite");
		return mv;

}
	//카테고리 등록
	 @PostMapping("/admin/adminCategoryWrite")
	    public String addCategory(@ModelAttribute("categoryDTO") CategoryDto categoryDTO, @ModelAttribute("subCategoryDTO") SubCategoryDto subCategoryDTO) {
	        if (subCategoryDTO.getCategoryIdx() == null) {
	            categoryService.addCategory(categoryDTO);
	        } else {
	            SubcategoryService.addSubCategory(subCategoryDTO);
	        }
	        return "redirect:/adminCategoryUpdate"; 
	    }
	 

	   
	 //가맹점 회원 탈퇴
		@PostMapping("/admin/dropId")
		public String dropID(@RequestParam("userIdx") Long userIdx) {
			storeService.dropUser(userIdx);
			return "redirect:/adminCuser";
		}
	//개인 회원 탈퇴
		@PostMapping("/admin/dropId2")
		public String dropID2(@RequestParam("userIdx") Long userIdx) {
			personService.dropUser(userIdx);
			return "redirect:/adminPuser";
		}
	
		 //공고 승인 반려
		@PostMapping("/admin/updateStatus")
		public String updateStatus(@RequestParam Long postingIdx, @RequestParam String state) {
			adminApplyService.updateStatus(postingIdx, state);
			return "redirect:/adminApply";
		}
		
		
		
	

		
	//판매수익 페이지
	@GetMapping("/adminSales")
	public  ModelAndView   adminSales() {
		ModelAndView    mv    = new ModelAndView("adminSales");
		
		mv.setViewName("/admin/adminSales");
		return mv;
		
	}

		//FAQ작성 페이지
	    @PostMapping("/admin/adminFAQWrite")
	    public String addFAQ(@ModelAttribute("faqDTO") CsFaqDto faqDTO) {
	        faqService.addFAQ(faqDTO); // FAQ 서비스를 통해 FAQ 추가
	        return "redirect:/admin"; // FAQ 목록 페이지로 리다이렉트 
	    }

	    @RequestMapping("/adminFAQWrite")
	    public ModelAndView adminFAQwrite() {
	        ModelAndView mv = new ModelAndView("adminFAQWrite");
	        mv.setViewName("/admin/adminFAQWrite");
	        return mv;
	    }
	
	    @GetMapping("/admin/faqDetail/{id}")
	    public String faqDetail(@PathVariable("id") int id, Model model) {
	        CsFaqDto faqDTO = faqService.getFaqById(id);
	        model.addAttribute("faq", faqDTO);
	        return "admin/faqDetail"; // 뷰 이름 수정
	    }
	    
	    //FAQ 게시판
	    @GetMapping("/faq")
	    public ModelAndView faq() {
	    	ModelAndView mv = new ModelAndView("faq");
	    	List<CsFaqDto> faqList = faqService.getAllFAQs();
	    	mv.addObject("faqList", faqList);
	    	mv.setViewName("/admin/faq");
	    	return mv;
	    }
	    
	    //FAQ 관리
	    @GetMapping("/adminFAQUpdate")
	    public ModelAndView adminFAQUpdate() {
	    	ModelAndView mv = new ModelAndView("adminFAQUpdate");
	    	List<CsFaqDto> faqList = faqService.getAllFAQs();
	    	mv.addObject("faqList", faqList);
	    	mv.setViewName("/admin/adminFAQUpdate");
	    	return mv;
	    }


	 //개인회원 페이지
	    @GetMapping("/adminPuser")
		public  ModelAndView   adminPuser() {
			ModelAndView    mv    = new ModelAndView("adminPuser");
			List<PersonDto> PersonList = personService.getAllPersons();
			mv.addObject("personList", PersonList);
			mv.setViewName("/admin/adminPuser");
			System.out.println(PersonList);
			return mv;
			
		}

//관리자 리뷰 페이지
	    @GetMapping("/adminReview")
		public  ModelAndView   adminReview() {
			ModelAndView    mv    = new ModelAndView("adminReview");
			List<AdminReviewDto> ReviewList = adminReviewService.getAllAdminReviews();
			mv.addObject("reviewList", ReviewList);
			mv.setViewName("/admin/adminReview");
			System.out.println(ReviewList);
			return mv;
			
		}



	    
//가맹점회원 페이지
	   @GetMapping("/adminCuser")
	   public ModelAndView adminCuser() {
		   ModelAndView mv = new ModelAndView("adminCuser");
		   List<StoreDto> StoreList = storeService.getAllStores();
		   

		   mv.addObject("storeList",StoreList);
		   mv.setViewName("/admin/adminCuser");
		   System.out.println(StoreList);		
		   return mv;
	   }

	   //상위 카테고리 관리 페이지
	   @GetMapping("/adminCategoryUpdate")
	   public ModelAndView adminCategoryUpdate() {
		   ModelAndView mv = new ModelAndView("adminCategoryUpdate");
		   List<CategoryDto> CategoryList = categoryService.getAllCategorys();
		   mv.addObject("categoryList",CategoryList);
		   mv.setViewName("/admin/adminCategoryUpdate");
			
		   return mv;
	   }
	   //하위 카테고리 관리 페이지
	   @GetMapping("/adminCategoryUpdate2")
	   public ModelAndView adminCategoryUpdate2() {
		   ModelAndView mv = new ModelAndView("adminCategoryUpdate2");
		   List<SubCategoryDto> SubCategoryList = SubcategoryService.getAllSubCategorys();
		   mv.addObject("subcategoryList",SubCategoryList);
		   mv.setViewName("/admin/adminCategoryUpdate2");
		 		
		   return mv;
	   }
	   //공고 관리 페이지
	   @GetMapping("/adminApply")
	   public ModelAndView adminApply() {
		   ModelAndView mv = new ModelAndView("adminApply");
		   List<AdminApplyDto> AdminApplyList = adminApplyService.getAllAdminApplys();
		   mv.addObject("adminApplyList",AdminApplyList);
		   mv.setViewName("/admin/adminApply");
		   System.out.println(AdminApplyList);		
		   return mv;
}

	   //Qna 페이지
	   @GetMapping("/adminQnA")
	   public ModelAndView adminQnA() {
		   ModelAndView mv = new ModelAndView("adminQnA");
		   List<Map<String,Object>> AdminQnaList = adminQnaService.getAllAdminQnas();
		   mv.addObject("AdminqnaList",AdminQnaList);
		   mv.setViewName("/admin/adminQnA");
		   System.out.println(AdminQnaList);		
		   return mv;
	   
}
	   
	   //주문 내역 페이지
	   @GetMapping("/adminOrder")
	   public ModelAndView adminOrder() {
		   ModelAndView mv = new ModelAndView("adminOrder");
		   List<AdminOrderDto> AdminOrderList = adminOrderService.getAllAdminOrders();
		   mv.addObject("adminOrderList",AdminOrderList);
		   mv.setViewName("/admin/adminOrder");
		   System.out.println(AdminOrderList);		
		   return mv;
}
}