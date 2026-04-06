package com.example.onedayclass.common.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.security.MemberPrincipal;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @ModelAttribute("loginMember")
    public MemberDto loginMember(HttpSession session) {
        Object member = session.getAttribute("loginMember");
        if (member instanceof MemberDto memberDto) {
            return memberDto;
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof MemberPrincipal principal) {
            MemberDto principalMember = principal.getMember();
            session.setAttribute("loginMember", principalMember);
            return principalMember;
        }
        return null;
    }
}
