package com.example.onedayclass.review.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.review.dto.ReviewDto;
import com.example.onedayclass.review.service.ReviewService;
import com.example.onedayclass.security.MemberPrincipal;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
    public String list(@RequestParam(required = false, defaultValue = "rTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "reviewPage",
                reviewService.getReviewsPage(keyField, keyword, loginMember == null ? null : loginMember.getUId(), page, 12)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "review/list";
    }

    @GetMapping("/{rNum}")
    public String detail(@PathVariable int rNum, Model model) {
        model.addAttribute("review", reviewService.getReview(rNum, true));
        return "review/detail";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       Model model) {
        ReviewDto reviewDto = new ReviewDto();
        reviewDto.setRUid(loginMember.getUId());
        reviewDto.setCNum(cNum);
        model.addAttribute("reviewDto", reviewDto);
        return "review/form";
    }

    @PostMapping
    public String create(@Valid ReviewDto reviewDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "review/form";
        }
        reviewDto.setRUid(loginMember.getUId());
        reviewService.createReview(reviewDto);
        return "redirect:/reviews";
    }

    @PostMapping("/{rNum}/like")
    public String like(@PathVariable int rNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       RedirectAttributes redirectAttributes) {
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
