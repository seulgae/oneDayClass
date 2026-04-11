package com.example.onedayclass.qna.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.service.QnaService;
import com.example.onedayclass.security.MemberPrincipal;
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

import java.util.List;

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
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "questionPage",
                qnaService.getQuestionsPage(keyField, keyword, loginMember == null ? null : loginMember.getUId(), page, 10)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "qna/list";
    }

    @GetMapping("/{qNum}")
    public String detail(@PathVariable int qNum, Model model) {
        QnaDto question = qnaService.getQuestion(qNum);
        if (question != null && question.getQDepth() != null && question.getQDepth() > 0) {
            QnaDto root = qnaService.getRootQuestion(question.getQRef());
            if (root != null) {
                question = root;
            }
        }

        List<QnaDto> replies = question == null ? List.of() : qnaService.getReplies(question.getQRef());
        model.addAttribute("question", question);
        model.addAttribute("replies", replies);
        return "qna/detail";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       Model model) {
        QnaDto qnaDto = new QnaDto();
        qnaDto.setQUid(loginMember.getUId());
        qnaDto.setCNum(cNum);
        model.addAttribute("qnaDto", qnaDto);
        return "qna/form";
    }

    @PostMapping
    public String create(@Valid QnaDto qnaDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "qna/form";
        }
        qnaDto.setQUid(loginMember.getUId());
        qnaService.createQuestion(qnaDto);
        return "redirect:/qna";
    }

    @GetMapping("/{qNum}/reply")
    public String replyForm(@PathVariable int qNum, Model model) {
        model.addAttribute("parent", qnaService.getQuestion(qNum));
        return "qna/reply";
    }

    @PostMapping("/{qNum}/reply")
    public String reply(@PathVariable int qNum,
                        @Valid QnaDto qnaDto,
                        BindingResult bindingResult,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                        Model model) {
        QnaDto parent = qnaService.getQuestion(qNum);
        if (bindingResult.hasErrors()) {
            model.addAttribute("parent", parent);
            return "qna/reply";
        }
        qnaDto.setQUid(loginMember.getUId());
        qnaDto.setParentQNum(qNum);
        qnaDto.setQStatus(1);
        qnaService.replyQuestion(qnaDto);

        if (parent != null && parent.getQDepth() != null && parent.getQDepth() > 0) {
            QnaDto root = qnaService.getRootQuestion(parent.getQRef());
            return "redirect:/qna/" + (root == null ? qNum : root.getQNum());
        }
        return "redirect:/qna/" + qNum;
    }

    @PostMapping("/{qNum}/delete")
    public String delete(@PathVariable int qNum) {
        qnaService.deleteQuestion(qNum);
        return "redirect:/qna";
    }
}
