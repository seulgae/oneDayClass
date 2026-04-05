package com.example.onedayclass.payment.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.payment.dto.PaymentRequestDto;
import com.example.onedayclass.payment.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String cart(HttpSession session, Model model) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        model.addAttribute("cartCount", paymentService.getCartCount(loginMember.getUId()));
        return "payment/cart";
    }

    @PostMapping("/cart/{cNum}")
    public String addCart(@PathVariable int cNum, HttpSession session) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        paymentService.addCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    @PostMapping("/cart/{cNum}/delete")
    public String deleteCart(@PathVariable int cNum, HttpSession session) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        paymentService.removeCart(loginMember.getUId(), cNum);
        return "redirect:/payments/cart";
    }

    @GetMapping("/checkout")
    public String checkoutForm(HttpSession session, Model model) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("cartItems", paymentService.getCartItems(loginMember.getUId()));
        return "payment/checkout";
    }

    @PostMapping("/checkout")
    public String checkout(PaymentRequestDto paymentRequestDto, HttpSession session) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        paymentService.checkout(paymentRequestDto, loginMember.getUId());
        return "redirect:/payments/history";
    }

    @GetMapping("/history")
    public String history(HttpSession session, Model model) {
        MemberDto loginMember = requireLogin(session);
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("studentPayments", paymentService.getStudentPayments(loginMember.getUId()));
        model.addAttribute("teacherPayments", paymentService.getTeacherPayments(loginMember.getUId()));
        return "payment/history";
    }

    private MemberDto requireLogin(HttpSession session) {
        return (MemberDto) session.getAttribute("loginMember");
    }
}
