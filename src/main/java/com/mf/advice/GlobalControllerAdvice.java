package com.mf.advice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mf.dto.CategoryDto;
import com.mf.service.MainService;

// modelAttribute를 컨트롤러 전역에 쓰기위해 사용
@ControllerAdvice
public class GlobalControllerAdvice {

	@Autowired
	private MainService mainService;
	
    @ModelAttribute
    public void categories(Model model){
    	//카테고리 불러오기
		List<CategoryDto> category = mainService.getCategory();

        model.addAttribute("category",category);
    }
}
