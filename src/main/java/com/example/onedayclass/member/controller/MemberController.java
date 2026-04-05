package com.example.onedayclass.member.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/members")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(String uId, String uPw, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDto memberDto = memberService.login(uId, uPw);
        if (memberDto == null) {
            redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/members/login";
        }
        session.setAttribute("loginMember", memberDto);
        return "redirect:/";
    }

    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("memberDto", new MemberDto());
        return "member/join";
    }

    @PostMapping("/join")
    public String join(@ModelAttribute MemberDto memberDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "member/join";
        }
        if (memberService.checkId(memberDto.getUId())) {
            redirectAttributes.addFlashAttribute("message", "이미 사용 중인 아이디입니다.");
            return "redirect:/members/join";
        }
        memberService.register(memberDto);
        redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다.");
        return "redirect:/members/login";
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("member", memberService.getMember(loginMember.getUId()));
        return "member/mypage";
    }

    @GetMapping("/edit")
    public String editForm(HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("memberDto", memberService.getMember(loginMember.getUId()));
        return "member/edit";
    }

    @PostMapping("/edit")
    public String edit(@ModelAttribute MemberDto memberDto, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        memberDto.setUId(loginMember.getUId());
        memberService.update(memberDto);
        session.setAttribute("loginMember", memberService.getMember(loginMember.getUId()));
        redirectAttributes.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
        return "redirect:/members/mypage";
    }

    @PostMapping("/delete")
    public String delete(HttpSession session) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember != null) {
            memberService.delete(loginMember.getUId());
        }
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
