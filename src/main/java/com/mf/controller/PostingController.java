package com.mf.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
public class PostingController {

    @Autowired
    private ProductService productService;

    @Autowired
    private PostingService postingService;

    private String realPath = "/Users/sinminjae/dev/postingImage/";

    @GetMapping("/postingWrite")
    public String showPostingWritePage(Model model, HttpSession session) {
        Long userIdx = (Long) session.getAttribute("userIdx");
        List<Map<String, Object>> products = postingService.getAllProductDetailsWithInventory(userIdx);

        // productIdx를 추출하기 위한 리스트 초기화
        List<Long> productIdxList = new ArrayList<>();

        // for문을 사용하여 각 product에서 productIdx를 추출
        for (Map<String, Object> product : products) {
            // productIdx를 BigDecimal로 가져와서 Long으로 변환 후 리스트에 추가
            BigDecimal productIdxBigDecimal = (BigDecimal) product.get("PRODUCT_IDX");
            productIdxList.add(productIdxBigDecimal.longValue());
        }
        
        // 전체 product details를 저장할 리스트 초기화
        List<Map<String, Object>> allProductDetails = new ArrayList<>();

        for (Long productIdx : productIdxList) {
            List<Map<String, Object>> productDetails = productService.getProductDetailsByProductIdx(productIdx);
            allProductDetails.addAll(productDetails);
        }

        // 전체 product details 리스트를 모델에 추가
        model.addAttribute("productDetails", allProductDetails);

        return "/posting/postingWrite";
    }
    
//    @GetMapping("/posting/getProductDetails")
//    @ResponseBody
//    public List<Map<String, Object>> getProductDetails(@RequestParam("productIdx") Long productIdx) {
//        System.out.println("Fetching details for productIdx: " + productIdx);
//        List<Map<String, Object>> productDetails = productService.getProductDetailsByProductIdx(productIdx);
//        System.out.println("Product details: " + productDetails);
//        return productDetails;
//    }

    @PostMapping("/postingWrite")
    public String createPosting(@RequestParam("title") String title,
                                @RequestParam("editordata") String content,
                                @RequestParam Map<String, String> requestParams,
                                HttpSession session) {
        Long userIdx = (Long) session.getAttribute("userIdx");
        Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        // 숨겨진 필드에서 Long 타입의 데이터를 가져옵니다.
        List<Long> productInfoIdxs = new ArrayList<>();
        List<Long> productIdxs = new ArrayList<>();

        // requestParams에서 데이터 빼내기
        for (Map.Entry<String, String> entry : requestParams.entrySet()) {
            if (entry.getKey().startsWith("productInfoIdx")) {
                productInfoIdxs.add(Long.valueOf(entry.getValue()));
            } else if (entry.getKey().startsWith("productIdx")) {
                productIdxs.add(Long.valueOf(entry.getValue()));
            }
        }

        // 판매글 DTO 구성
        PostingDto postingDto = new PostingDto();
        postingDto.setTitle(title);
        postingDto.setContent(content);
        postingDto.setStoreIdx(storeIdx);
        postingDto.setState(1);

        // 판매글 생성 서비스 호출
        postingService.createPosting(postingDto, productInfoIdxs);

        return "redirect:/storeMyPage/postingList";
    }
    
    @GetMapping("postingList")
    public ModelAndView postingList(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        Long userIdx = (Long) session.getAttribute("userIdx");
        Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        List<Map<String, Object>> postings = postingService.getAllPostingDetails(storeIdx);
        List<Map<String, Object>> onHoldPostings = postingService.getOnHoldPostingDetails(storeIdx);

        for (Map<String, Object> posting : postings) {
            String filePaths = (String) posting.get("FILE_PATHS");
            if (filePaths != null) {
                posting.put("FILE_PATHS", Arrays.asList(filePaths.split(", ")));
            } else {
                posting.put("FILE_PATHS", Collections.emptyList());
            }
        }

        for (Map<String, Object> posting : onHoldPostings) {
            String filePaths = (String) posting.get("FILE_PATHS");
            if (filePaths != null) {
                posting.put("FILE_PATHS", Arrays.asList(filePaths.split(", ")));
            } else {
                posting.put("FILE_PATHS", Collections.emptyList());
            }
        }

        mv.addObject("postings", postings);
        mv.addObject("onHoldPostings", onHoldPostings);
        mv.setViewName("posting/postingList");
        return mv;
    }

    @GetMapping("/postingListData")
    @ResponseBody
    public Map<String, Object> postingListData(HttpSession session) {
        Long userIdx = (Long) session.getAttribute("userIdx");
        Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        List<Map<String, Object>> postings = postingService.getAllPostingDetails(storeIdx);
        List<Map<String, Object>> onHoldPostings = postingService.getOnHoldPostingDetails(storeIdx);

        for (Map<String, Object> posting : postings) {
            String filePaths = (String) posting.get("FILE_PATHS");
            if (filePaths != null) {
                posting.put("FILE_PATHS", Arrays.asList(filePaths.split(", ")));
            } else {
                posting.put("FILE_PATHS", Collections.emptyList());
            }
        }

        for (Map<String, Object> posting : onHoldPostings) {
            String filePaths = (String) posting.get("FILE_PATHS");
            if (filePaths != null) {
                posting.put("FILE_PATHS", Arrays.asList(filePaths.split(", ")));
            } else {
                posting.put("FILE_PATHS", Collections.emptyList());
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("postings", postings);
        response.put("onHoldPostings", onHoldPostings);
        return response;
    }

	    @PostMapping("/updatePostingState")
	    @ResponseBody
	    public ResponseEntity<Void> updatePostingState(@RequestParam("postingIdx") Long postingIdx, @RequestParam("state") int state) {
	        postingService.updatePostingState(postingIdx, state);
	        return ResponseEntity.ok().build();
	    }


    @RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
    @ResponseBody
    public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
                                            HttpServletRequest request) {
        JsonObject jsonObject = new JsonObject();

        String contextRoot = realPath;
        String fileRoot = contextRoot;

        String originalFileName = multipartFile.getOriginalFilename();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

        String savedFileName = UUID.randomUUID() + extension;

        File targetFile = new File(fileRoot + savedFileName);

        try {
            java.io.InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);

            jsonObject.addProperty("url", "/postingImage/" + savedFileName);
            jsonObject.addProperty("responseCode", "success");
        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }

        return jsonObject.toString();
    }

}
