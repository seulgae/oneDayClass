package com.example.onedayclass.notice.controller;

import com.example.onedayclass.notice.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/notices")
public class NoticeController {

    private final NoticeService noticeService;

    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("noticePage", noticeService.getNoticesPage(page, 10));
        return "notice/list";
    }

    @GetMapping("/{qNum}")
    public String detail(@PathVariable int qNum, Model model) {
        model.addAttribute("notice", noticeService.getNotice(qNum));
        return "notice/detail";
    }
}
