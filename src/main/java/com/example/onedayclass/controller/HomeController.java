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

    /**
     * 홈 화면에 필요한 추천 클래스, 최근 후기, 등업 요청 데이터를 조회한다.
     *
     * @param model 홈 화면 구성 데이터를 전달할 뷰 모델
     * @return 홈 JSP 경로
     */
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("featuredClasses", classService.getFeaturedClasses(null, null, "N", 12));
        model.addAttribute("offlineClasses", classService.getFeaturedClasses(null, null, "Y", 12));
        model.addAttribute("latestReviews", reviewService.getRecentReviews(3));
        model.addAttribute("pendingLevelUps", limit(levelUpService.getPendingRequests(), 3));
        return "home";
    }

    /**
     * 지정된 개수만큼 목록을 잘라 홈 화면에 노출한다.
     *
     * @param items 원본 목록
     * @param size 유지할 최대 개수
     * @return 최대 size개까지만 포함한 목록
     * @param <T> 목록 요소 타입
     */
    private <T> List<T> limit(List<T> items, int size) {
        return items.stream().limit(size).toList();
    }
}
