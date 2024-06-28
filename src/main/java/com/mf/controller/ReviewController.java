package com.mf.controller;

import com.mf.dto.AdminReviewDto;
import com.mf.service.AdminReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ReviewController {

    @Autowired
    private AdminReviewService adminReviewService;

    @GetMapping("/reviews")
    public List<AdminReviewDto> getAllReviews() {
        return adminReviewService.getAllReviews();
    }
}