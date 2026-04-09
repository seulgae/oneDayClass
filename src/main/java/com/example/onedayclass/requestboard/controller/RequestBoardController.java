package com.example.onedayclass.requestboard.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.requestboard.dto.RequestBoardDto;
import com.example.onedayclass.requestboard.service.RequestBoardService;
import com.example.onedayclass.security.MemberPrincipal;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/requests")
public class RequestBoardController {

    private final RequestBoardService requestBoardService;

    public RequestBoardController(RequestBoardService requestBoardService) {
        this.requestBoardService = requestBoardService;
    }

    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "reqTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "requestPage",
                requestBoardService.getRequestsPage(keyField, keyword, loginMember == null ? null : loginMember.getUId(), page, 10)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "request/list";
    }

    @GetMapping("/{reqNum}")
    public String detail(@PathVariable int reqNum, Model model) {
        RequestBoardDto requestItem = requestBoardService.getRequest(reqNum);
        if (requestItem != null && requestItem.getReqDepth() != null && requestItem.getReqDepth() > 0) {
            RequestBoardDto root = requestBoardService.getRootRequest(requestItem.getReqRef());
            if (root != null) {
                requestItem = root;
            }
        }
        List<RequestBoardDto> replies = requestItem == null ? List.of() : requestBoardService.getReplies(requestItem.getReqRef());
        model.addAttribute("requestItem", requestItem);
        model.addAttribute("replies", replies);
        return "request/detail";
    }

    @GetMapping("/new")
    public String form(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        RequestBoardDto requestBoardDto = new RequestBoardDto();
        requestBoardDto.setReqUid(loginMember.getUId());
        model.addAttribute("requestBoardDto", requestBoardDto);
        return "request/form";
    }

    @PostMapping
    public String create(RequestBoardDto requestBoardDto,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        requestBoardDto.setReqUid(loginMember.getUId());
        requestBoardService.createRequest(requestBoardDto);
        return "redirect:/requests";
    }

    @GetMapping("/{reqNum}/reply")
    public String replyForm(@PathVariable int reqNum, Model model) {
        model.addAttribute("parent", requestBoardService.getRequest(reqNum));
        return "request/reply";
    }

    @PostMapping("/{reqNum}/reply")
    public String reply(@PathVariable int reqNum,
                        RequestBoardDto requestBoardDto,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        RequestBoardDto parent = requestBoardService.getRequest(reqNum);
        requestBoardDto.setReqUid(loginMember.getUId());
        requestBoardDto.setParentReqNum(reqNum);
        requestBoardDto.setReqStatus(1);
        requestBoardService.replyRequest(requestBoardDto);

        if (parent != null && parent.getReqDepth() != null && parent.getReqDepth() > 0) {
            RequestBoardDto root = requestBoardService.getRootRequest(parent.getReqRef());
            return "redirect:/requests/" + (root == null ? reqNum : root.getReqNum());
        }
        return "redirect:/requests/" + reqNum;
    }

    @PostMapping("/{reqNum}/delete")
    public String delete(@PathVariable int reqNum) {
        requestBoardService.deleteRequest(reqNum);
        return "redirect:/requests";
    }
}
