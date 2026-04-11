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

    /**
     * 공지사항 목록을 조회한다.
     *
     * @param page 현재 페이지 번호
     * @param model 목록 데이터를 전달할 뷰 모델
     * @return 공지사항 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        model.addAttribute("noticePage", noticeService.getNoticesPage(page, 10));
        return "notice/list";
    }

    /**
     * 공지사항 상세 화면을 조회한다.
     *
     * @param qNum 조회할 공지사항 번호
     * @param model 상세 데이터를 전달할 뷰 모델
     * @return 공지사항 상세 JSP 경로
     */
    @GetMapping("/{qNum}")
    public String detail(@PathVariable int qNum, Model model) {
        model.addAttribute("notice", noticeService.getNotice(qNum));
        return "notice/detail";
    }
}
