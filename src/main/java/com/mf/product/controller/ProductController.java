package com.mf.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductController {
	@GetMapping("storeMypage/productWrite")
	public ModelAndView productadd() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("product/productwrite");
		return mv;
	}
}
