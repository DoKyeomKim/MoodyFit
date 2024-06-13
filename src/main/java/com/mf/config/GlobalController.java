package com.mf.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mf.dto.CategoryDto;
import com.mf.service.MainService;

@ControllerAdvice
@Controller
public class GlobalController {

    @Autowired
    private MainService mainService;

    // 모든 요청에 대해 공통으로 categories 데이터 설정
    @ModelAttribute("categories")
    public List<CategoryDto> getCategories() {
        return mainService.getCategory();
    }
}
