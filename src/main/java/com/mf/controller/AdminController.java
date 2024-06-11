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
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.AdminOrderDto;
import com.mf.dto.AdminReviewDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.CsFaqDto;
import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;
import com.mf.dto.SubCategoryDto;
import com.mf.service.AdminOrderService;
import com.mf.service.AdminQnaService;
import com.mf.service.AdminReviewService;
import com.mf.service.CategoryService;
import com.mf.service.FAQService;
import com.mf.service.PersonService;
import com.mf.service.PostingService;
import com.mf.service.StoreService;
import com.mf.service.SubCategoryService;

import ch.qos.logback.core.model.Model;

@Controller
public class AdminController {
	@GetMapping("/admin")
	public  ModelAndView   home() {
		ModelAndView    mv    = new ModelAndView("adminMain");
		
		mv.setViewName("/adminMain");
		return mv;
	}
	@RequestMapping("/adminCategoryWrite")
	public  ModelAndView   adminCategoryWrite() {
		ModelAndView    mv    = new ModelAndView("adminCategoryWrite");
		
		mv.setViewName("/admin/adminCategoryWrite");
		return mv;

}

	
	
	
	
		
	
	
	
		
	

		
	
	@GetMapping("/adminSales")
	public  ModelAndView   adminSales() {
		ModelAndView    mv    = new ModelAndView("adminSales");
		
		mv.setViewName("/admin/adminSales");
		return mv;
		
	}
	 @Autowired
	    private FAQService faqService;

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
	    @GetMapping("/faq")
	    public ModelAndView faq() {
	    	ModelAndView mv = new ModelAndView("faq");
	    	List<CsFaqDto> faqList = faqService.getAllFAQs();
	    	mv.addObject("faqList", faqList);
	    	mv.setViewName("/admin/faq");
	    	return mv;
	    }
	    @GetMapping("/adminFAQUpdate")
	    public ModelAndView adminFAQUpdate() {
	    	ModelAndView mv = new ModelAndView("adminFAQUpdate");
	    	List<CsFaqDto> faqList = faqService.getAllFAQs();
	    	mv.addObject("faqList", faqList);
	    	mv.setViewName("/admin/adminFAQUpdate");
	    	return mv;
	    }
	    @Autowired
	    private PersonService personService;

	 
	    @GetMapping("/adminPuser")
		public  ModelAndView   adminPuser() {
			ModelAndView    mv    = new ModelAndView("adminPuser");
			List<PersonDto> PersonList = personService.getAllPersons();
			mv.addObject("personList", PersonList);
			mv.setViewName("/admin/adminPuser");
			System.out.println(PersonList);
			return mv;
			
		}
	    @Autowired
	    private AdminReviewService adminReviewService;

	    @GetMapping("/adminReview")
		public  ModelAndView   adminReview() {
			ModelAndView    mv    = new ModelAndView("adminReview");
			List<AdminReviewDto> ReviewList = adminReviewService.getAllAdminReviews();
			mv.addObject("reviewList", ReviewList);
			mv.setViewName("/admin/adminReview");
			System.out.println(ReviewList);
			return mv;
			
		}
	    
	    
	   @Autowired
	   private StoreService storeService;
	   
	   @GetMapping("/adminCuser")
	   public ModelAndView adminCuser() {
		   ModelAndView mv = new ModelAndView("adminCuser");
		   List<StoreDto> StoreList = storeService.getAllStores();
		   mv.addObject("storeList",StoreList);
		   mv.setViewName("/admin/adminCuser");
		   System.out.println(StoreList);		
		   return mv;
	   }
	   @Autowired
	   private CategoryService categoryService;
	   
	   @GetMapping("/adminCategoryUpdate")
	   public ModelAndView adminCategoryUpdate() {
		   ModelAndView mv = new ModelAndView("adminCategoryUpdate");
		   List<CategoryDto> CategoryList = categoryService.getAllCategorys();
		   mv.addObject("categoryList",CategoryList);
		   mv.setViewName("/admin/adminCategoryUpdate");
			
		   return mv;
	   }
	   @Autowired
	   private SubCategoryService subcategoryService;
	   
	   @GetMapping("/adminCategoryUpdate2")
	   public ModelAndView adminCategoryUpdate2() {
		   ModelAndView mv = new ModelAndView("adminCategoryUpdate2");
		   List<SubCategoryDto> SubCategoryList = subcategoryService.getAllSubCategorys();
		   mv.addObject("subcategoryList",SubCategoryList);
		   mv.setViewName("/admin/adminCategoryUpdate2");
		 		
		   return mv;
	   }
	   @Autowired
	   private PostingService postingService;
	   
	   @GetMapping("/adminApply")
	   public ModelAndView adminApply() {
		   ModelAndView mv = new ModelAndView("adminApply");
		   List<Map<String,Object>> PostingList = postingService.getAllPostings();
		   mv.addObject("postingList",PostingList);
		   mv.setViewName("/admin/adminApply");
		   System.out.println(PostingList);		
		   return mv;
	   
}
	   @Autowired
	   private AdminQnaService adminQnaService;
	   
	   @GetMapping("/adminQnA")
	   public ModelAndView adminQnA() {
		   ModelAndView mv = new ModelAndView("adminQnA");
		   List<Map<String,Object>> AdminQnaList = adminQnaService.getAllAdminQnas();
		   mv.addObject("AdminqnaList",AdminQnaList);
		   mv.setViewName("/admin/adminQnA");
		   System.out.println(AdminQnaList);		
		   return mv;
	   
}
	   @Autowired
	   private AdminOrderService adminOrderService;
	   
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