package com.example.onedayclass.admin.controller;

import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.levelup.service.LevelUpService;
import com.example.onedayclass.qna.service.QnaService;
import com.example.onedayclass.review.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final ClassService classService;
    private final LevelUpService levelUpService;
    private final QnaService qnaService;
    private final ReviewService reviewService;

    public AdminController(ClassService classService, LevelUpService levelUpService, QnaService qnaService, ReviewService reviewService) {
        this.classService = classService;
        this.levelUpService = levelUpService;
        this.qnaService = qnaService;
        this.reviewService = reviewService;
    }

    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("pendingClasses", classService.getPendingClasses());
        model.addAttribute("pendingLevelUps", levelUpService.getPendingRequests());
        model.addAttribute("questions", qnaService.getQuestions("qTitle", null, "admin"));
        model.addAttribute("reviews", reviewService.getReviews("admin"));
        return "admin/dashboard";
    }

    @PostMapping("/classes/{cNum}/approve")
    public String approveClass(@PathVariable int cNum) {
        classService.approveClass(cNum);
        return "redirect:/admin";
    }
}
