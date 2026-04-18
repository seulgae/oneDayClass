package com.example.onedayclass.notice.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.notice.service.NoticeService;
import com.example.onedayclass.qna.dto.QnaDto;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        return "notice/noticeList";
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
        return "notice/noticeDetail";
    }

    @GetMapping("/new")
    public String form(Model model) {
        model.addAttribute("noticeDto", new QnaDto());
        return "notice/noticeForm";
    }

    @PostMapping
    public String create(@Valid QnaDto noticeDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "notice/noticeForm";
        }
        noticeDto.setQUid(loginMember.getUId());
        noticeDto.setCreatedBy(loginMember.getUId());
        noticeDto.setUpdatedBy(loginMember.getUId());
        noticeService.createNotice(noticeDto);
        return "redirect:/notices";
    }

    @GetMapping("/{qNum}/edit")
    public String editForm(@PathVariable int qNum, Model model, RedirectAttributes redirectAttributes) {
        QnaDto notice = noticeService.getNotice(qNum);
        if (notice == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 공지사항입니다.");
            return "redirect:/notices";
        }
        model.addAttribute("noticeDto", notice);
        return "notice/noticeForm";
    }

    @PostMapping("/{qNum}/edit")
    public String update(@PathVariable int qNum,
                         @Valid QnaDto noticeDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                         RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            noticeDto.setQNum(qNum);
            return "notice/noticeForm";
        }
        noticeDto.setQNum(qNum);
        noticeDto.setUpdatedBy(loginMember.getUId());
        if (!noticeService.updateNotice(noticeDto)) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 공지사항입니다.");
            return "redirect:/notices";
        }
        return "redirect:/notices/" + qNum;
    }

    @PostMapping("/{qNum}/delete")
    public String delete(@PathVariable int qNum, RedirectAttributes redirectAttributes) {
        if (!noticeService.deleteNotice(qNum)) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 공지사항입니다.");
        }
        return "redirect:/notices";
    }
}
