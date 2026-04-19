package com.example.onedayclass.requestboard.controller;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.requestboard.dto.RequestBoardDto;
import com.example.onedayclass.requestboard.service.RequestBoardService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/requests")
public class RequestBoardController {

    private final RequestBoardService requestBoardService;

    public RequestBoardController(RequestBoardService requestBoardService) {
        this.requestBoardService = requestBoardService;
    }

    /**
     * 요청게시판 목록을 조회한다.
     *
     * @param keyField 검색 기준 필드
     * @param keyword 검색어
     * @param page 현재 페이지 번호
     * @param principal 로그인 사용자 정보
     * @param model 목록 데이터와 검색 상태를 전달할 뷰 모델
     * @return 요청게시판 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "reqTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "requestPage",
                requestBoardService.getRequestsPage(keyField, keyword, loginMember == null ? null : loginMember.getULevel(), page, 10)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "request/requestBoardList";
    }

    /**
     * 원글 기준 요청게시판 상세와 답글 목록을 조회한다.
     *
     * @param reqNum 조회할 요청 번호
     * @param model 원글과 답글 목록을 전달할 뷰 모델
     * @return 요청게시판 상세 JSP 경로
     */
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
        return "request/requestBoardDetail";
    }

    /**
     * 요청게시판 작성 화면의 기본값을 준비한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 신규 요청 DTO를 전달할 뷰 모델
     * @return 요청게시판 작성 JSP 경로
     */
    @GetMapping("/new")
    public String form(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        RequestBoardDto requestBoardDto = new RequestBoardDto();
        requestBoardDto.setReqUid(loginMember.getUId());
        model.addAttribute("requestBoardDto", requestBoardDto);
        return "request/requestBoardForm";
    }

    /**
     * 새 요청글을 등록한다.
     *
     * @param requestBoardDto 등록할 요청 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 작성 화면, 성공 시 목록으로 리다이렉트
     */
    @PostMapping
    public String create(@Valid RequestBoardDto requestBoardDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "request/requestBoardForm";
        }
        requestBoardDto.setReqUid(loginMember.getUId());
        requestBoardService.createRequest(requestBoardDto);
        return "redirect:/requests";
    }

    /**
     * 요청글 답변 작성 화면을 조회한다.
     *
     * @param reqNum 부모 요청 번호
     * @param model 부모 요청을 전달할 뷰 모델
     * @return 요청게시판 답변 JSP 경로
     */
    @GetMapping("/{reqNum}/reply")
    public String replyForm(@PathVariable int reqNum, Model model) {
        model.addAttribute("parent", requestBoardService.getRequest(reqNum));
        return "request/requestBoardReply";
    }

    /**
     * 요청글에 대한 답변 또는 대댓글을 등록한다.
     *
     * @param reqNum 부모 요청 번호
     * @param requestBoardDto 등록할 답변 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @param model 검증 실패 시 부모 글을 전달할 뷰 모델
     * @return 검증 실패 시 답변 화면, 성공 시 원글 상세로 리다이렉트
     */
    @PostMapping("/{reqNum}/reply")
    public String reply(@PathVariable int reqNum,
                        @Valid RequestBoardDto requestBoardDto,
                        BindingResult bindingResult,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                        Model model) {
        RequestBoardDto parent = requestBoardService.getRequest(reqNum);
        if (bindingResult.hasErrors()) {
            model.addAttribute("parent", parent);
            return "request/requestBoardReply";
        }
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

    /**
     * 요청글을 삭제한다.
     *
     * @param reqNum 삭제할 요청 번호
     * @return 요청게시판 목록으로 리다이렉트
     */
    @PostMapping("/{reqNum}/delete")
    public String delete(@PathVariable int reqNum,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                         RedirectAttributes redirectAttributes) {
        RequestBoardDto target = requestBoardService.getRequest(reqNum);
        if (target == null || loginMember == null
                || (!loginMember.getUId().equals(target.getReqUid()) && !isBoardManager(loginMember))) {
            redirectAttributes.addFlashAttribute("message", "작성자나 게시판 관리자만 삭제할 수 있습니다.");
            return "redirect:" + resolveDetailPath(reqNum, target);
        }

        requestBoardService.deleteRequest(reqNum);
        return "redirect:" + resolveDetailPath(reqNum, target);
    }

    private boolean isBoardManager(MemberDto loginMember) {
        return loginMember != null
                && ("3".equals(loginMember.getULevel()) || "4".equals(loginMember.getULevel()));
    }

    private String resolveDetailPath(int reqNum, RequestBoardDto target) {
        if (target != null && target.getReqDepth() != null && target.getReqDepth() > 0) {
            RequestBoardDto root = requestBoardService.getRootRequest(target.getReqRef());
            if (root != null) {
                return "/requests/" + root.getReqNum();
            }
        }
        return "/requests/" + reqNum;
    }
}
