package com.example.onedayclass.review.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.review.dto.ReviewDto;
import com.example.onedayclass.review.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping
    public String list(HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        model.addAttribute("reviews", reviewService.getReviews(loginMember == null ? null : loginMember.getUId()));
        return "review/list";
    }

    @GetMapping("/{rNum}")
    public String detail(@PathVariable int rNum, Model model) {
        model.addAttribute("review", reviewService.getReview(rNum, true));
        return "review/detail";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum, HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        ReviewDto reviewDto = new ReviewDto();
        reviewDto.setRUid(loginMember.getUId());
        reviewDto.setCNum(cNum);
        model.addAttribute("reviewDto", reviewDto);
        return "review/form";
    }

    @PostMapping
    public String create(ReviewDto reviewDto, HttpSession session) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        reviewDto.setRUid(loginMember.getUId());
        reviewService.createReview(reviewDto);
        return "redirect:/reviews";
    }

    @PostMapping("/{rNum}/like")
    public String like(@PathVariable int rNum, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!reviewService.likeReview(loginMember.getUId(), rNum)) {
            redirectAttributes.addFlashAttribute("message", "이미 추천한 후기입니다.");
        }
        return "redirect:/reviews/" + rNum;
    }

    @PostMapping("/{rNum}/delete")
    public String delete(@PathVariable int rNum) {
        reviewService.deleteReview(rNum);
        return "redirect:/reviews";
    }
}
