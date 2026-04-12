package com.example.onedayclass.member.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/members")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/login")
    public String loginForm() {
        return "member/memberLogin";
    }

    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("memberDto", new MemberDto());
        return "member/memberJoin";
    }

    @PostMapping("/join")
    public String join(@Valid @ModelAttribute MemberDto memberDto,
                       BindingResult bindingResult,
                       RedirectAttributes redirectAttributes,
                       Model model) {
        normalizeJoinFields(memberDto);
        validateTeacherFields(memberDto, bindingResult);

        if (bindingResult.hasErrors()) {
            List<String> validationErrors = bindingResult.getFieldErrors().stream()
                    .map(this::toValidationMessage)
                    .distinct()
                    .toList();
            model.addAttribute("validationErrors", validationErrors);
            return "member/memberJoin";
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
        return "member/memberMypage";
    }

    @GetMapping("/edit")
    public String editForm(@AuthenticationPrincipal(expression = "username") String username, Model model) {
        model.addAttribute("memberDto", memberService.getMember(username));
        return "member/memberEdit";
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

    private String toValidationMessage(FieldError fieldError) {
        return switch (fieldError.getField()) {
            case "uId" -> "아이디는 영문/숫자 4~20자로 입력해야 합니다.";
            case "uPw" -> "비밀번호는 영문, 숫자, 특수문자를 포함한 8~20자여야 합니다.";
            case "uName" -> "이름은 한글 또는 영문 2~20자로 입력해야 합니다.";
            case "uPhone" -> "휴대폰 번호 형식이 올바르지 않습니다.";
            case "uEmail" -> "이메일 형식이 올바르지 않습니다.";
            case "uLevel" -> "회원 유형을 선택해야 합니다.";
            case "sName" -> "강사 활동명은 한글/영문/숫자를 포함해 2~50자로 입력해야 합니다.";
            default -> "입력값을 다시 확인해 주세요.";
        };
    }

    private void normalizeJoinFields(MemberDto memberDto) {
        if (!Objects.equals(memberDto.getULevel(), "2")) {
            memberDto.setSName(null);
            memberDto.setSSns(null);
        }
    }

    private void validateTeacherFields(MemberDto memberDto, BindingResult bindingResult) {
        if (Objects.equals(memberDto.getULevel(), "2")
                && (memberDto.getSName() == null || memberDto.getSName().isBlank())) {
            bindingResult.rejectValue("sName", "required", "강사 활동명을 입력해야 합니다.");
        }
    }
}
