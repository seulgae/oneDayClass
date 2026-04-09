package com.example.onedayclass.common.interceptor;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginMemberInterceptor implements HandlerInterceptor {

    private final MemberService memberService;

    public LoginMemberInterceptor(MemberService memberService) {
        this.memberService = memberService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        HttpSession session = request.getSession(false);

        if (authentication == null || !authentication.isAuthenticated() || authentication instanceof AnonymousAuthenticationToken) {
            if (session != null) {
                session.removeAttribute("loginMember");
            }
            request.setAttribute("loginMember", null);
            return true;
        }

        MemberDto loginMember = memberService.getMember(authentication.getName());
        if (loginMember == null) {
            if (session != null) {
                session.removeAttribute("loginMember");
            }
            request.setAttribute("loginMember", null);
            return true;
        }

        request.setAttribute("loginMember", loginMember);
        request.getSession().setAttribute("loginMember", loginMember);
        return true;
    }
}
