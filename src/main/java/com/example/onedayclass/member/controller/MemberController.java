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

    /**
     * 로그인 화면을 조회한다.
     *
     * @return 로그인 JSP 경로
     */
    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    /**
     * 회원가입 화면을 조회한다.
     *
     * @param model 신규 회원 DTO를 전달할 뷰 모델
     * @return 회원가입 JSP 경로
     */
    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("memberDto", new MemberDto());
        return "member/join";
    }

    /**
     * 회원가입을 처리한다.
     *
     * @param memberDto 가입할 회원 데이터
     * @param bindingResult 입력값 검증 결과
     * @param redirectAttributes 중복 아이디/성공 메시지를 전달할 리다이렉트 속성
     * @return 검증 실패 시 가입 화면, 성공 시 로그인 화면으로 리다이렉트
     */
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

    /**
     * 로그인 사용자의 마이페이지를 조회한다.
     *
     * @param username 로그인 사용자 아이디
     * @param model 회원 정보를 전달할 뷰 모델
     * @return 마이페이지 JSP 경로
     */
    @GetMapping("/mypage")
    public String mypage(@AuthenticationPrincipal(expression = "username") String username, Model model) {
        model.addAttribute("member", memberService.getMember(username));
        return "member/mypage";
    }

    /**
     * 회원정보 수정 화면을 조회한다.
     *
     * @param username 로그인 사용자 아이디
     * @param model 기존 회원 정보를 전달할 뷰 모델
     * @return 회원정보 수정 JSP 경로
     */
    @GetMapping("/edit")
    public String editForm(@AuthenticationPrincipal(expression = "username") String username, Model model) {
        model.addAttribute("memberDto", memberService.getMember(username));
        return "member/edit";
    }

    /**
     * 로그인 사용자의 회원정보를 수정한다.
     *
     * @param memberDto 수정할 회원 데이터
     * @param username 로그인 사용자 아이디
     * @param redirectAttributes 수정 완료 메시지를 전달할 리다이렉트 속성
     * @return 마이페이지로 리다이렉트
     */
    @PostMapping("/edit")
    public String edit(@ModelAttribute MemberDto memberDto,
                       @AuthenticationPrincipal(expression = "username") String username,
                       RedirectAttributes redirectAttributes) {
        memberDto.setUId(username);
        memberService.update(memberDto);
        redirectAttributes.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
        return "redirect:/members/mypage";
    }

    /**
     * 로그인 사용자의 회원 계정을 삭제하고 로그아웃 처리한다.
     *
     * @param username 로그인 사용자 아이디
     * @param request 현재 HTTP 요청
     * @param response 현재 HTTP 응답
     * @return 홈 화면으로 리다이렉트
     */
    @PostMapping("/delete")
    public String delete(@AuthenticationPrincipal(expression = "username") String username,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        memberService.delete(username);
        new SecurityContextLogoutHandler().logout(request, response, null);
        return "redirect:/";
    }
}
