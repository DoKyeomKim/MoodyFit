package com.mf.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.AdminAnswerDto;
import com.mf.dto.AdminApplyDto;
import com.mf.dto.AdminOrderDto;
import com.mf.dto.AdminQuestionDto;
import com.mf.dto.AdminReviewDto;
import com.mf.dto.CategoryDto;
import com.mf.dto.CsFaqDto;
import com.mf.dto.CsQnaDto;
import com.mf.dto.EditorPickDto;
import com.mf.dto.Paging;
import com.mf.dto.PersonDto;
import com.mf.dto.StoreDto;
import com.mf.dto.SubCategoryDto;
import com.mf.service.AdminApplyService;
import com.mf.service.AdminOrderService;
import com.mf.service.AdminQnaService;
import com.mf.service.AdminReviewService;
import com.mf.service.CategoryService;
import com.mf.service.EditorPickService;
import com.mf.service.FAQService;
import com.mf.service.PersonService;
import com.mf.service.StoreService;
import com.mf.service.SubCategoryService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
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
	private AdminQnaService adminQnaService;
	@Autowired
	private AdminOrderService adminOrderService;
	@Autowired
	private AdminApplyService adminApplyService;
	@Autowired
	private EditorPickService editorPickService;
 
	   
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
	//상위 카테고리 수정
	 @PostMapping("/updateCategory")
	    public String updateCategory(CategoryDto category) {
	        categoryService.updateCategory(category);
	        return "redirect:/adminCategoryUpdate";
	    }
    
	//상위 카테고리 삭제
	 @GetMapping("/deleteCategory")
	    public String deleteCategory(@RequestParam("categoryIdx") Long categoryIdx) {
	        categoryService.deleteCategory(categoryIdx);
	        return "redirect:/adminCategoryUpdate";
	    }
	//하위 카테고리 수정
		 @PostMapping("/updateCategory2")
		    public String SubupdateCategory(SubCategoryDto Subcategory) {
			 SubcategoryService.updateSubCategory(Subcategory);
		        return "redirect:/adminCategoryUpdate2";
		    }
	    
		//하위 카테고리 삭제
		 @GetMapping("/deleteCategory2")
		    public String SubdeleteCategory(@RequestParam("SubcategoryIdx") Long SubcategoryIdx) {
			 SubcategoryService.deleteSubCategory(SubcategoryIdx);
		        return "redirect:/adminCategoryUpdate2";
		    }
	
	//카테고리 등록 페이지
		@GetMapping("/adminCategoryWrite2")
		public  ModelAndView   adminCategoryWrite2() {
			ModelAndView    mv    = new ModelAndView("adminCategoryWrite2");
			
			mv.setViewName("/admin/adminCategoryWrite2");
			return mv;
		}
	//카테고리 등록
	 @PostMapping("/admin/adminCategoryWrite")
	    public String addCategory(@ModelAttribute("categoryDTO") CategoryDto categoryDTO) {
	            categoryService.addCategory(categoryDTO);
	       
	        return "redirect:/adminCategoryUpdate"; 
	    }
	 
	//카테고리 등록
		 @PostMapping("/admin/adminCategoryWrite2")
		    public String addCategory(@ModelAttribute("subcategoryDTO") SubCategoryDto subcategoryDTO) {
		            SubcategoryService.addSubCategory(subcategoryDTO);
		       
		        return "redirect:/adminCategoryUpdate"; 
		    }

		 @PostMapping("/admin/qna1")
		 public String qna1(@RequestParam("questionIdx") Long questionIdx) {
		     adminQnaService.qna1(questionIdx);
		     return "redirect:/adminQnA";
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
	
		 @PostMapping("/admin/updateStatus")
		    public String updateStatus(@RequestParam("id") Long postingIdx, @RequestParam("state") String state) {
		        adminApplyService.updateStatus(postingIdx, state);
		        return "redirect:/adminApply";
		    }
		  @RequestMapping("/admin/paging")
		    public String getPersons(@RequestParam(defaultValue = "1") int page, Model model) {
		        int recordsPerPage = 10;
		        int offset = (page - 1) * recordsPerPage;

		        List<PersonDto> personList = personService.getPersons(offset, recordsPerPage);
		        int noOfRecords = personService.getNoOfRecords();
		        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

		        model.addAttribute("personList", personList);
		        model.addAttribute("noOfPages", noOfPages);
		        model.addAttribute("currentPage", page);

		        return "adminPuser";
		    }
		  //개인회원 검색
		  @GetMapping("/admin/userManagement")
		    public String userManagement(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<PersonDto> personList = personService.searchUsersById(searchId);
		        model.addAttribute("personList", personList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminPuser";
		    }
		  
		  //가맹점회원 검색
		  @GetMapping("/admin/userManagement2")
		    public String cManagement(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<StoreDto> storeList = storeService.searchStoresById(searchId);
		        model.addAttribute("storeList", storeList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminCuser";
		    }
		  
		  
		  //공고 검색
		  @GetMapping("/admin/userManagement3")
		    public String applySearch(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<AdminApplyDto> adminApplyList = adminApplyService.searchApplysById(searchId);
		        model.addAttribute("adminApplyList", adminApplyList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminApply";
		    }
		  //Q&A검색
		  @GetMapping("/admin/userManagement4")
		    public String qnaSearch(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<AdminQuestionDto> AdminqnaList = adminQnaService.searchQnasById(searchId);
		        model.addAttribute("AdminqnaList", AdminqnaList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminQnA";
		    }
		//Q&A검색
		  @GetMapping("/admin/userManagement5")
		    public String reviewSearch(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<AdminReviewDto> reviewList = adminReviewService.searchReviewsById(searchId);
		        model.addAttribute("reviewList", reviewList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminReview";
		    }
		  
		//주문내역검색
		  @GetMapping("/admin/userManagement6")
		    public String orderSearch(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<AdminOrderDto> adminOrderList = adminOrderService.searchOrdersById(searchId);
		        model.addAttribute("adminOrderList", adminOrderList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/adminOrder";
		    }
		  
		  @GetMapping("/admin/userManagement7")
		    public String faqSearch(@RequestParam(value = "searchId", required = false) String searchId,
		                                 @RequestParam(value = "page", defaultValue = "1") int page,
		                                 Model model) {
		        List<AdminQuestionDto> faqList = faqService.searchFaqsById(searchId);
		        model.addAttribute("faqList", faqList);
		        // 페이지네이션 관련 추가 코드
		        return "/admin/faq";
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
//	    //리뷰 작성 페이지
//	    @PostMapping("/admin/reviewWrite")
//	    public String addReview(@ModelAttribute("reviewDto") AdminReviewDto reviewDto,MultipartFile file) {
////	        adminReviewService.file();
//	    	adminReviewService.addReview(reviewDto); // FAQ 서비스를 통해 FAQ 추가
//	        
//	        return "redirect:/"; // FAQ 목록 페이지로 리다이렉트 
//	    }

	    @RequestMapping("/reviewWrite")
	    public ModelAndView reviewWrite() {
	        ModelAndView mv = new ModelAndView("reviewWrite");
	        mv.setViewName("/admin/reviewWrite");
	        return mv;
	    }
	    
	    @RequestMapping("/review")
	    public ModelAndView review() {
	        ModelAndView mv = new ModelAndView("review");
	        mv.setViewName("/admin/review");
	        return mv;
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
	    
	    @PostMapping("/updateFaq")
	    public String updateFAQ(CsFaqDto faq) {
	        faqService.updateFAQ(faq);
	        return "redirect:/adminFAQUpdate";
	    }

	    @GetMapping("/deleteFaq")
	    public String deleteFAQ(@RequestParam("faqIdx") Long faqIdx) {
	        faqService.deleteFAQ(faqIdx);
	        return "redirect:/adminFAQUpdate";
	    }
	    
	    @GetMapping("/faqDetail")
	    public String getFaqDetail(@RequestParam("faqIdx") Long faqIdx, Model model) {
	        // faqIdx 값 로그 출력
	        System.out.println("Received faqIdx: " + faqIdx);
	        
	        // FAQ 객체를 가져와서 모델에 추가
	        CsFaqDto faq = faqService.getFaqByFaqIdx(faqIdx);
	        if (faq == null) {
	            // faqIdx로 FAQ를 찾지 못한 경우 처리
	            System.out.println("FAQ not found for faqIdx: " + faqIdx);
	            return "errorPage"; // errorPage.jsp로 이동 (필요에 따라 수정)
	        }
	        model.addAttribute("faq", faq);
	        
	        return "admin/faqDetail"; // faqDetail.jsp 페이지로 이동
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
	   
	
	   
	    //qna 게시판
	    @GetMapping("/qna")
	    public ModelAndView qna() {
	    	ModelAndView mv = new ModelAndView("qna");
	    	List<Map<String,Object>>  AdminQnaList = adminQnaService.getAllAdminQnas();
	    	mv.addObject("AdminqnaList",AdminQnaList);
	    	mv.setViewName("/admin/qna");
	    	return mv;
	    }
	   
	   
	   @GetMapping("/qnaWrite")
			public  ModelAndView   qnaWrite() {
				ModelAndView    mv    = new ModelAndView("qnaWrite");
				
				mv.setViewName("/admin/qnaWrite");
				return mv;
			}
	   
	 //qna작성 페이지
	    @PostMapping("/admin/qnaWrite")
	    public String addQuestion(@ModelAttribute("qnaDTO") AdminQuestionDto qnaDTO,HttpSession session,CsQnaDto csQna) {
	        Long userIdx= (Long) session.getAttribute("userIdx");
	        
	    	adminQnaService.addQuestion(qnaDTO,userIdx,csQna); //
	        return "redirect:/qna"; // qna 목록 페이지로 리다이렉트 
	    }
	   
	    //QNA상세 페이지
	    @GetMapping("/qnaDetail")
	    public String getQnaDetail(@RequestParam("questionIdx") Long questionIdx, Model model) {
	        System.out.println("Received questionIdx: " + questionIdx);
	        
	        // FAQ 객체를 가져와서 모델에 추가
	        AdminQuestionDto qnaDTO = adminQnaService.getQnaByquestionIdx(questionIdx);
	        if (qnaDTO == null) {
	            // questionIdx로 FAQ를 찾지 못한 경우 처리
	            System.out.println("QnA not found for questionIdx: " + questionIdx);
	            return "errorPage"; // errorPage.jsp로 이동 (필요에 따라 수정)
	        }
	        model.addAttribute("qna", qnaDTO);
	        
	        // 해당 QnA의 답변 리스트를 가져와서 모델에 추가
	        List<AdminAnswerDto> answers = adminQnaService.getAnswersByQuestionIdx(questionIdx);
	        model.addAttribute("answers", answers);
	        
	        return "admin/qnaDetail"; // qnaDetail.jsp 페이지로 이동
	    }
	    
	    @PostMapping("/submitAnswer")
	    public String submitAnswer(@RequestParam("questionIdx") Long questionIdx, @RequestParam("title") String title, @RequestParam("content") String content) {
	        AdminAnswerDto answerDto = new AdminAnswerDto();
	        answerDto.setQuestionIdx(questionIdx);
	        answerDto.setTitle(title);
	        answerDto.setContent(content);
	        
	        adminQnaService.addAnswer(answerDto);
	        
	        return "redirect:/qnaDetail?questionIdx=" + questionIdx;
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

//=========================================================================
//==============================에디터 픽==================================
//=========================================================================
//=========================================================================
	   
	   // 에디터 픽 이동
	   @GetMapping("/adminEditorPick")
	   public ModelAndView editorPick(@RequestParam(value = "page", defaultValue = "1") int page) {
		   ModelAndView mv = new ModelAndView();
		   
		   int pageSize = 5;
		   int startIndex = (page - 1) * pageSize;
		   
		   // 에디터픽 리스트 갖고오기
		   List<Map<String,Object>> editorPick = editorPickService.getEditorPick(pageSize,startIndex);
		   // 페이징 처리
		   Paging paging = editorPickService.calculatePagingInfo(page, pageSize);
		   
		   mv.addObject("prev", paging.isPrev());
		   mv.addObject("next", paging.isNext());
		   mv.addObject("startPageNum", paging.getStartPageNum());
		   mv.addObject("endPageNum", paging.getEndPageNum());
		   mv.addObject("totalPages", paging.getTotalPages());
		   mv.addObject("currentPage", page);

		   mv.addObject("editorPick", editorPick);
		   mv.setViewName("admin/editorPick");
		   return mv;
	   }
	   
	   // 에디터 픽 작성 페이지 이동
	   @GetMapping("/EPWriteForm")
	   public ModelAndView EPWriteForm() {
		   ModelAndView mv = new ModelAndView();
		   // 임시용 전부 들고 오는 로직
		   List<Map<String,Object>> posting = editorPickService.getPickPosting();
		   
		   
		   
		   mv.addObject("posting", posting);
		   mv.setViewName("admin/editorPickWrite");
		   return mv;
	   }
	   
	   // 에디터 픽 작성
	   @PostMapping("/EPWrite")
	   public ModelAndView EPWrite(@RequestParam("file") MultipartFile file, EditorPickDto editorPick) {
		   ModelAndView mv = new ModelAndView();
		   // 에디터픽 작성 로직
		   editorPickService.writeEditorPick(editorPick,file);
		   
		   mv.setViewName("redirect:/adminEditorPick");
		   return mv;
	   }
	   
	   // 에디터 픽 수정 페이지
	   @GetMapping("/EPEditForm")
	   public ModelAndView EPEditForm(@RequestParam("pickIdx") Long pickIdx,EditorPickDto editorPick) throws ParseException {
		   ModelAndView mv = new ModelAndView();
		   
		   // 수정 페이지에 필요한 정보 들고오는 로직처리
		   Map<String,Object> editPick = editorPickService.getEditPickByPickIdx(pickIdx,editorPick);
		    
		   mv.addObject("startDate",editPick.get("formattedStartDate"));
		   mv.addObject("endDate",editPick.get("formattedEndDate"));
		   mv.addObject("editorPick",editPick.get("editorPick"));
		   mv.addObject("postingInfo",editPick.get("postingInfo"));
		   mv.addObject("editPick", editPick);
		   mv.setViewName("admin/editorPickEdit");
		   return mv;
	   }
	  
	   // 에디터픽 수정
	   @PostMapping("/EPEdit")
	   public ModelAndView EPEdit(@RequestParam("file") MultipartFile file,EditorPickDto editorPick) {
		   ModelAndView mv = new ModelAndView();
		   
		   editorPickService.editorPickUpdate(file,editorPick);
		   
		   mv.setViewName("redirect:/adminEditorPick");
		   return mv;
	   }
	   
	   // 에디터픽 삭제
	   @PostMapping("/EPDelete")
	   public String EPDelete(@RequestParam("pickIdx") Long pickIdx) {
		   
		   editorPickService.editorPickDelete(pickIdx);
		   
		   return "redirect:/adminEditorPick";
	   }
//=========================================================================
//=========================================================================
//=========================================================================

	   
	   
}