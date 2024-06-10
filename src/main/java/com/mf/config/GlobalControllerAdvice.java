package com.mf.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mf.dto.CategoryDto;
import com.mf.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private MainService mainService;

    // 모든 요청에 대해 공통으로 categories 데이터 설정
    @ModelAttribute("categories")
    public List<CategoryDto> getCategories() {
        List<CategoryDto> categories = mainService.getCategory();
        log.info("Fetching categories for all requests: {}", categories);
        return categories;
    }
}
