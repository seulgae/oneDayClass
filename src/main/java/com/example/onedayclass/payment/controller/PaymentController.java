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

    @GetMapping("/cart")
    public String cart(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        model.addAttribute("cartCount", paymentService.getCartCount(loginMember.getUId()));
        return "payment/cart";
    }

    @PostMapping("/cart/{cNum}")
    public String addCart(@PathVariable int cNum,
                          @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        paymentService.addCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    @PostMapping("/cart/{cNum}/delete")
    public String deleteCart(@PathVariable int cNum,
                             @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        paymentService.removeCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    @GetMapping("/checkout")
    public String checkoutForm(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        return "payment/checkout";
    }

    @PostMapping("/checkout")
    public String checkout(@Valid PaymentRequestDto paymentRequestDto,
                           BindingResult bindingResult,
                           @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                           Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
            return "payment/checkout";
        }
        paymentService.checkout(paymentRequestDto, loginMember.getUId());
        return "redirect:/payments/history";
    }

    @GetMapping("/history")
    public String history(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        model.addAttribute("studentPayments", paymentService.getStudentPayments(loginMember.getUId()));
        model.addAttribute("teacherPayments", paymentService.getTeacherPayments(loginMember.getUId()));
        return "payment/history";
    }
}
