package com.example.onedayclass.controller;

import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.levelup.service.LevelUpService;
import com.example.onedayclass.review.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    private final ClassService classService;
    private final ReviewService reviewService;
    private final LevelUpService levelUpService;

    public HomeController(ClassService classService, ReviewService reviewService, LevelUpService levelUpService) {
        this.classService = classService;
        this.reviewService = reviewService;
        this.levelUpService = levelUpService;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("featuredClasses", classService.getFeaturedClasses(null, "N", 12));
        model.addAttribute("offlineClasses", classService.getFeaturedClasses(null, "Y", 12));
        model.addAttribute("latestReviews", reviewService.getRecentReviews(3));
        model.addAttribute("pendingLevelUps", limit(levelUpService.getPendingRequests(), 3));
        return "home";
    }

    private <T> List<T> limit(List<T> items, int size) {
        return items.stream().limit(size).toList();
    }
}
