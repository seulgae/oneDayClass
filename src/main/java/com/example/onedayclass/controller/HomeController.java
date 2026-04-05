package com.example.onedayclass.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "oneDayClass");
        model.addAttribute("message", "스프링 부트 + JSP MVC 기본 구조 프로젝트입니다.");
        return "home";
    }
}
