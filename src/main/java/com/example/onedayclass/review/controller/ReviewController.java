package com.example.onedayclass.review.controller;

import com.example.onedayclass.clazz.service.ClassService;
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
    private final ClassService classService;

    public ReviewController(ReviewService reviewService, ClassService classService) {
        this.reviewService = reviewService;
        this.classService = classService;
    }

    /**
     * 후기 목록을 조회한다.
     *
     * @param keyField 검색 기준 필드
     * @param keyword 검색어
     * @param page 현재 페이지 번호
     * @param principal 로그인 사용자 정보
     * @param model 목록 데이터와 검색 상태를 전달할 뷰 모델
     * @return 후기 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "rTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "reviewPage",
                reviewService.getReviewsPage(keyField, keyword, loginMember == null ? null : loginMember.getULevel(), page, 12)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "review/reviewList";
    }

    /**
     * 후기 상세 화면을 조회한다.
     *
     * @param rNum 조회할 후기 번호
     * @param model 상세 데이터를 전달할 뷰 모델
     * @return 후기 상세 JSP 경로
     */
    @GetMapping("/{rNum}")
    public String detail(@PathVariable int rNum, Model model) {
        model.addAttribute("review", reviewService.getReview(rNum, true));
        return "review/reviewDetail";
    }

    /**
     * 후기 작성 화면의 기본값을 준비한다.
     *
     * @param cNum 연관 클래스 번호
     * @param loginMember 로그인 사용자 정보
     * @param model 신규 후기 DTO를 전달할 뷰 모델
     * @return 후기 작성 JSP 경로
     */
    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       Model model) {
        ReviewDto reviewDto = new ReviewDto();
        reviewDto.setRUid(loginMember.getUId());
        reviewDto.setCNum(cNum);
        model.addAttribute("reviewDto", reviewDto);
        populateClassOptions(model);
        return "review/reviewForm";
    }

    /**
     * 새 후기를 등록한다.
     *
     * @param reviewDto 등록할 후기 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 작성 화면, 성공 시 목록으로 리다이렉트
     */
    @PostMapping
    public String create(@Valid ReviewDto reviewDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                         Model model) {
        if (bindingResult.hasErrors() || reviewDto.getCNum() == null) {
            if (reviewDto.getCNum() == null) {
                model.addAttribute("message", "후기를 작성할 클래스를 선택해 주세요.");
            }
            populateClassOptions(model);
            return "review/reviewForm";
        }
        reviewDto.setRUid(loginMember.getUId());
        reviewService.createReview(reviewDto);
        return "redirect:/reviews";
    }

    /**
     * 후기에 좋아요를 추가한다.
     *
     * @param rNum 추천할 후기 번호
     * @param loginMember 로그인 사용자 정보
     * @param redirectAttributes 중복 추천 메시지를 전달할 리다이렉트 속성
     * @return 후기 상세 화면으로 리다이렉트
     */
    @PostMapping("/{rNum}/like")
    public String like(@PathVariable int rNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       RedirectAttributes redirectAttributes) {
        if (!reviewService.likeReview(loginMember.getUId(), rNum)) {
            redirectAttributes.addFlashAttribute("message", "이미 추천한 후기입니다.");
        }
        return "redirect:/reviews/" + rNum;
    }

    /**
     * 후기를 삭제한다.
     *
     * @param rNum 삭제할 후기 번호
     * @return 후기 목록으로 리다이렉트
     */
    @PostMapping("/{rNum}/delete")
    public String delete(@PathVariable int rNum,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                         RedirectAttributes redirectAttributes) {
        ReviewDto review = reviewService.getReview(rNum, false);
        if (review == null || loginMember == null
                || (!loginMember.getUId().equals(review.getRUid()) && !isBoardManager(loginMember))) {
            redirectAttributes.addFlashAttribute("message", "작성자나 게시판 관리자만 삭제할 수 있습니다.");
            return "redirect:/reviews/" + rNum;
        }

        reviewService.deleteReview(rNum);
        return "redirect:/reviews";
    }

    private boolean isBoardManager(MemberDto loginMember) {
        return loginMember != null
                && ("3".equals(loginMember.getULevel()) || "4".equals(loginMember.getULevel()));
    }

    private void populateClassOptions(Model model) {
        model.addAttribute("classOptions", classService.getClasses("cTitle", null, null, false));
    }
}
