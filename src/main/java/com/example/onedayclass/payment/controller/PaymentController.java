package com.example.onedayclass.payment.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.payment.dto.PaymentRequestDto;
import com.example.onedayclass.payment.service.PaymentService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    /**
     * 로그인 사용자의 장바구니를 조회한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 장바구니 목록과 개수를 전달할 뷰 모델
     * @return 장바구니 JSP 경로
     */
    @GetMapping("/cart")
    public String cart(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        model.addAttribute("cartCount", paymentService.getCartCount(loginMember.getUId()));
        return "payment/paymentCart";
    }

    /**
     * 클래스를 장바구니에 추가한다.
     *
     * @param cNum 장바구니에 담을 클래스 번호
     * @param loginMember 로그인 사용자 정보
     * @return 장바구니 화면으로 리다이렉트
     */
    @PostMapping("/cart/{cNum}")
    public String addCart(@PathVariable int cNum,
                          @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        paymentService.addCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    /**
     * 장바구니에서 클래스를 제거한다.
     *
     * @param cNum 삭제할 클래스 번호
     * @param loginMember 로그인 사용자 정보
     * @return 장바구니 화면으로 리다이렉트
     */
    @PostMapping("/cart/{cNum}/delete")
    public String deleteCart(@PathVariable int cNum,
                             @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        paymentService.removeCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    /**
     * 결제 화면을 조회한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 장바구니 기준 주문 요약을 전달할 뷰 모델
     * @return 결제 JSP 경로
     */
    @GetMapping("/checkout")
    public String checkoutForm(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        return "payment/paymentCheckout";
    }

    /**
     * 결제 요청을 처리하고 결제 이력을 생성한다.
     *
     * @param paymentRequestDto 배송/결제 요청 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @param model 검증 실패 시 장바구니 정보를 다시 전달할 뷰 모델
     * @return 검증 실패 시 결제 화면, 성공 시 결제내역으로 리다이렉트
     */
    @PostMapping("/checkout")
    public String checkout(@Valid PaymentRequestDto paymentRequestDto,
                           BindingResult bindingResult,
                           @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                           Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
            return "payment/paymentCheckout";
        }
        paymentService.checkout(paymentRequestDto, loginMember.getUId());
        return "redirect:/payments/history";
    }

    /**
     * 로그인 사용자의 결제/판매 내역 목록을 조회한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 결제 목록과 판매 목록을 전달할 뷰 모델
     * @return 결제내역 목록 JSP 경로
     */
    @GetMapping("/history")
    public String history(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("studentPayments", paymentService.getStudentPayments(loginMember.getUId()));
        model.addAttribute("teacherPayments", paymentService.getTeacherPayments(loginMember.getUId()));
        return "payment/paymentHistory";
    }

    /**
     * 주문 단위 결제 상세 정보를 조회한다.
     *
     * @param pNum 조회할 주문 번호
     * @param loginMember 로그인 사용자 정보
     * @param model 결제 기본정보와 주문 상품 목록을 전달할 뷰 모델
     * @return 상세 JSP 경로 또는 조회 불가 시 목록으로 리다이렉트
     */
    @GetMapping("/history/{pNum}")
    public String historyDetail(@PathVariable int pNum,
                                @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                                Model model) {
        PaymentRequestDto paymentInfo = paymentService.getPaymentInfo(pNum, loginMember.getUId());
        if (paymentInfo == null) {
            return "redirect:/payments/history";
        }

        model.addAttribute("paymentInfo", paymentInfo);
        model.addAttribute("paymentItems", paymentService.getPaymentItems(pNum, loginMember.getUId()));
        return "payment/paymentDetail";
    }
}
