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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/qna")
public class QnaController {

    private final QnaService qnaService;

    public QnaController(QnaService qnaService) {
        this.qnaService = qnaService;
    }

    /**
     * QnA 목록을 조회한다.
     *
     * @param keyField 검색 기준 필드
     * @param keyword 검색어
     * @param page 현재 페이지 번호
     * @param principal 로그인 사용자 정보
     * @param model 목록 데이터와 검색 상태를 전달할 뷰 모델
     * @return QnA 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "qTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        model.addAttribute(
                "questionPage",
                qnaService.getQuestionsPage(keyField, keyword, loginMember == null ? null : loginMember.getULevel(), page, 10)
        );
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        return "qna/qnaList";
    }

    /**
     * 원글 기준 QnA 상세와 답글 목록을 조회한다.
     *
     * @param qNum 조회할 글 번호
     * @param model 원글과 답글 목록을 전달할 뷰 모델
     * @return QnA 상세 JSP 경로
     */
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
        return "qna/qnaDetail";
    }

    /**
     * QnA 작성 화면의 기본값을 준비한다.
     *
     * @param cNum 연관 클래스 번호
     * @param loginMember 로그인 사용자 정보
     * @param model 신규 문의 DTO를 전달할 뷰 모델
     * @return QnA 작성 JSP 경로
     */
    @GetMapping("/new")
    public String form(@RequestParam(required = false) Integer cNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       Model model) {
        QnaDto qnaDto = new QnaDto();
        qnaDto.setQUid(loginMember.getUId());
        qnaDto.setCNum(cNum);
        model.addAttribute("qnaDto", qnaDto);
        return "qna/qnaForm";
    }

    /**
     * 새 문의를 등록한다.
     *
     * @param qnaDto 등록할 문의 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 작성 화면, 성공 시 목록으로 리다이렉트
     */
    @PostMapping
    public String create(@Valid QnaDto qnaDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "qna/qnaForm";
        }
        qnaDto.setQUid(loginMember.getUId());
        qnaService.createQuestion(qnaDto);
        return "redirect:/qna";
    }

    /**
     * 문의 답변 작성 화면을 조회한다.
     *
     * @param qNum 부모 문의 번호
     * @param model 부모 문의를 전달할 뷰 모델
     * @return QnA 답변 JSP 경로
     */
    @GetMapping("/{qNum}/reply")
    public String replyForm(@PathVariable int qNum, Model model) {
        model.addAttribute("parent", qnaService.getQuestion(qNum));
        return "qna/qnaReply";
    }

    /**
     * 문의에 대한 답변 또는 대댓글을 등록한다.
     *
     * @param qNum 부모 문의 번호
     * @param qnaDto 등록할 답변 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @param model 검증 실패 시 부모 글을 전달할 뷰 모델
     * @return 검증 실패 시 답변 화면, 성공 시 원글 상세로 리다이렉트
     */
    @PostMapping("/{qNum}/reply")
    public String reply(@PathVariable int qNum,
                        @Valid QnaDto qnaDto,
                        BindingResult bindingResult,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                        Model model) {
        QnaDto parent = qnaService.getQuestion(qNum);
        if (bindingResult.hasErrors()) {
            model.addAttribute("parent", parent);
            return "qna/qnaReply";
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

    /**
     * 문의 글을 삭제한다.
     *
     * @param qNum 삭제할 문의 번호
     * @return QnA 목록으로 리다이렉트
     */
    @PostMapping("/{qNum}/delete")
    public String delete(@PathVariable int qNum,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                         RedirectAttributes redirectAttributes) {
        QnaDto target = qnaService.getQuestion(qNum);
        if (target == null || loginMember == null
                || (!loginMember.getUId().equals(target.getQUid()) && !isBoardManager(loginMember))) {
            redirectAttributes.addFlashAttribute("message", "작성자나 게시판 관리자만 삭제할 수 있습니다.");
            return "redirect:" + resolveDetailPath(qNum, target);
        }

        qnaService.deleteQuestion(qNum);
        return "redirect:" + resolveDetailPath(qNum, target);
    }

    private boolean isBoardManager(MemberDto loginMember) {
        return loginMember != null
                && ("3".equals(loginMember.getULevel()) || "4".equals(loginMember.getULevel()));
    }

    private String resolveDetailPath(int qNum, QnaDto target) {
        if (target != null && target.getQDepth() != null && target.getQDepth() > 0) {
            QnaDto root = qnaService.getRootQuestion(target.getQRef());
            if (root != null) {
                return "/qna/" + root.getQNum();
            }
        }
        return "/qna/" + qNum;
    }
}
