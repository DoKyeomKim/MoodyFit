package com.mf.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mf.dto.PostingDto;
import com.mf.service.PostingService;
import com.mf.service.ProductService;
import com.nimbusds.jose.shaded.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/storeMyPage")
public class PostingContoller {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PostingService postingService;
	
	private String realPath = "/Users/sinminjae/dev/postingImage/";
	
	@GetMapping("/postingWrite")
    public String showPostingWritePage(Model model) {
        List<Map<String, Object>> products = postingService.getAllProductDetailsWithInventory();
        model.addAttribute("products", products);
        return "/posting/postingWrite";
    }
	
	
	@GetMapping("/posting/getProductDetails")
	@ResponseBody
	public List<Map<String, Object>> getProductDetails(@RequestParam("productIdx") Long productIdx) {
	    List<Map<String, Object>> productDetails = productService.getProductDetailsByProductIdx(productIdx);
	    
	    return productDetails;
	}



	@PostMapping("/postingWrite")
    public String createPosting(@RequestParam("productIdx") Long productIdx,
                                @RequestParam("productInfoIdx") Long productInfoIdx,
                                @RequestParam("title") String title,
                                @RequestParam("content") String content,
                                @RequestParam("postingFiles") List<MultipartFile> postingFiles,
                                HttpSession session) {
        Long userIdx = (Long) session.getAttribute("userIdx");
        Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        PostingDto postingDto = new PostingDto();
        postingDto.setTitle(title);
        postingDto.setContent(content);
        postingDto.setProductInfoIdx(productInfoIdx);
        postingDto.setStoreIdx(storeIdx); 
        postingDto.setState(1);
        postingDto.setPostingFiles(postingFiles);

        postingService.createPosting(postingDto); 
        return "redirect:/storeMyPage/postingList"; 
    }
	
	
	@GetMapping("/postingDetail")
	public ModelAndView productDetail() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("posting/postingDetail");
		return mv;
	}
	
	
	// ==================================================================
	// ================ Editor 관련 컨트롤러 ===========================
	// summernote 이미지 업로드 postingImage 폴더에 저장
	@RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
	        HttpServletRequest request) {
	    // JSON 객체 생성
	    JsonObject jsonObject = new JsonObject();
	    
	    // 이미지 파일이 저장될 경로 설정
	    String contextRoot = realPath + "/Users/sinminjae/dev/postingImage/";
	    String fileRoot = contextRoot;
	    
	    // 업로드된 파일의 원본 파일명과 확장자 추출
	    String originalFileName = multipartFile.getOriginalFilename();
	    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    
	    // 새로운 파일명 생성 (고유한 식별자 + 확장자)
	    String savedFileName = UUID.randomUUID() + extension;
	    
	    // 저장될 파일의 경로와 파일명을 나타내는 File 객체 생성
	    File targetFile = new File(fileRoot + savedFileName);
	    
	    try {
	        // 업로드된 파일의 InputStream 얻기
	        java.io.InputStream fileStream = multipartFile.getInputStream();
	        
	        // 업로드된 파일을 지정된 경로에 저장
	        FileUtils.copyInputStreamToFile(fileStream, targetFile);
	        
	        // JSON 객체에 이미지 URL과 응답 코드 추가
	        jsonObject.addProperty("url", "/Users/sinminjae/dev/postingImage/" + savedFileName);
	        jsonObject.addProperty("responseCode", "success");
	    } catch (IOException e) {
	        // 파일 저장 중 오류 발생시 해당 파일 삭제 및 에러 응답 코드 추가
	        FileUtils.deleteQuietly(targetFile);
	        jsonObject.addProperty("responseCode", "error");
	        e.printStackTrace();
	    }
	    
	    // JSON 객체를 문자열로 변환하여 반환
	    String a = jsonObject.toString();
	    return a;
	}
	
	
}
