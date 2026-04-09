package com.example.onedayclass.common.controller;

import com.example.onedayclass.member.dto.MemberDto;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @ModelAttribute("loginMember")
    public MemberDto loginMember(HttpServletRequest request) {
        Object member = request.getAttribute("loginMember");
        return member instanceof MemberDto memberDto ? memberDto : null;
    }
}
