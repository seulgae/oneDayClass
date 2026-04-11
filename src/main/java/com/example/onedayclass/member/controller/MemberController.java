package com.example.onedayclass.member.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import jakarta.validation.Valid;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
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

    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("memberDto", new MemberDto());
        return "member/join";
    }

    @PostMapping("/join")
    public String join(@Valid @ModelAttribute MemberDto memberDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
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
    public String mypage(@AuthenticationPrincipal(expression = "username") String username, Model model) {
        model.addAttribute("member", memberService.getMember(username));
        return "member/mypage";
    }

    @GetMapping("/edit")
    public String editForm(@AuthenticationPrincipal(expression = "username") String username, Model model) {
        model.addAttribute("memberDto", memberService.getMember(username));
        return "member/edit";
    }

    @PostMapping("/edit")
    public String edit(@ModelAttribute MemberDto memberDto,
                       @AuthenticationPrincipal(expression = "username") String username,
                       RedirectAttributes redirectAttributes) {
        memberDto.setUId(username);
        memberService.update(memberDto);
        redirectAttributes.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
        return "redirect:/members/mypage";
    }

    @PostMapping("/delete")
    public String delete(@AuthenticationPrincipal(expression = "username") String username,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        memberService.delete(username);
        new SecurityContextLogoutHandler().logout(request, response, null);
        return "redirect:/";
    }
}
