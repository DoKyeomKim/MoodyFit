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
    public String showPostingWritePage(Model model) {
        List<Map<String, Object>> products = postingService.getAllProductDetailsWithInventory();
        model.addAttribute("products", products);
        return "/posting/postingWrite";
    }

    @GetMapping("/posting/getProductDetails")
    @ResponseBody
    public List<Map<String, Object>> getProductDetails(@RequestParam("productIdx") Long productIdx) {
        System.out.println("Fetching details for productIdx: " + productIdx);
        List<Map<String, Object>> productDetails = productService.getProductDetailsByProductIdx(productIdx);
        System.out.println("Product details: " + productDetails);
        return productDetails;
    }


    @PostMapping("/postingWrite")
    public String createPosting(@RequestParam("productIdx") Long productIdx,
                                @RequestParam("productInfoIdx") String productInfoIdxs,
                                @RequestParam("title") String title,
                                @RequestParam("content") String content,
                                HttpSession session) {
        Long userIdx = (Long) session.getAttribute("userIdx");
        Long storeIdx = productService.getStoreIdxByUserIdx(userIdx);

        PostingDto postingDto = new PostingDto();
        postingDto.setTitle(title);
        postingDto.setContent(content);
        postingDto.setStoreIdx(storeIdx);
        postingDto.setState(1);

        postingService.createPosting(postingDto, productInfoIdxs);
        return "redirect:/storeMyPage/postingList";
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

            jsonObject.addProperty("url", "/Users/sinminjae/dev/postingImage/" + savedFileName);
            jsonObject.addProperty("responseCode", "success");
        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }

        return jsonObject.toString();
    }
}
