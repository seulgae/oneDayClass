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

    /**
     * 관리자 대시보드 화면을 조회한다.
     *
     * @param model 승인 대기 데이터와 게시판 데이터를 전달할 뷰 모델
     * @return 관리자 대시보드 JSP 경로
     */
    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("pendingClasses", classService.getPendingClasses());
        model.addAttribute("pendingLevelUps", levelUpService.getPendingRequests());
        model.addAttribute("questions", qnaService.getQuestions("qTitle", null, "3"));
        model.addAttribute("reviews", reviewService.getReviews("rTitle", null, "3"));
        return "admin/adminDashboard";
    }

    /**
     * 관리자 승인 대상 클래스를 승인 처리한다.
     *
     * @param cNum 승인할 클래스 번호
     * @return 관리자 대시보드로 리다이렉트
     */
    @PostMapping("/classes/{cNum}/approve")
    public String approveClass(@PathVariable int cNum) {
        classService.approveClass(cNum);
        return "redirect:/admin";
    }
}
