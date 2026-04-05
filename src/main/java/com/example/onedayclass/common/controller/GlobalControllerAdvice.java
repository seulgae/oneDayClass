package com.example.onedayclass.common.controller;

import com.example.onedayclass.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
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
        return null;
    }
}
