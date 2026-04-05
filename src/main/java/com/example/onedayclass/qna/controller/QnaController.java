package com.example.onedayclass.qna.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.service.QnaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/qna")
public class QnaController {

    private final QnaService qnaService;

    public QnaController(QnaService qnaService) {
        this.qnaService = qnaService;
    }

    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "qTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       HttpSession session,
                       Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        model.addAttribute("questions", qnaService.getQuestions(keyField, keyword, loginMember == null ? null : loginMember.getUId()));
        return "qna/list";
    }

    @GetMapping("/{qNum}")
    public String detail(@PathVariable int qNum, Model model) {
        model.addAttribute("question", qnaService.getQuestion(qNum));
        return "qna/detail";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum, HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        QnaDto qnaDto = new QnaDto();
        qnaDto.setQUid(loginMember.getUId());
        qnaDto.setCNum(cNum);
        model.addAttribute("qnaDto", qnaDto);
        return "qna/form";
    }

    @PostMapping
    public String create(QnaDto qnaDto, HttpSession session) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        qnaDto.setQUid(loginMember.getUId());
        qnaService.createQuestion(qnaDto);
        return "redirect:/qna";
    }

    @GetMapping("/{qNum}/reply")
    public String replyForm(@PathVariable int qNum, HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        model.addAttribute("parent", qnaService.getQuestion(qNum));
        return "qna/reply";
    }

    @PostMapping("/{qNum}/reply")
    public String reply(@PathVariable int qNum, QnaDto qnaDto, HttpSession session) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        QnaDto parent = qnaService.getQuestion(qNum);
        qnaDto.setQUid(loginMember.getUId());
        qnaDto.setQRef(parent.getQRef());
        qnaDto.setQPos(parent.getQPos());
        qnaDto.setQDepth(parent.getQDepth());
        qnaDto.setQOriUid(parent.getQUid());
        qnaDto.setCNum(parent.getCNum());
        qnaDto.setQStatus(1);
        qnaService.replyQuestion(qnaDto);
        return "redirect:/qna";
    }

    @PostMapping("/{qRef}/delete")
    public String delete(@PathVariable int qRef) {
        qnaService.deleteQuestion(qRef);
        return "redirect:/qna";
    }
}
