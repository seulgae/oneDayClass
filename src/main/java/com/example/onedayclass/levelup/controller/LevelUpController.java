package com.example.onedayclass.levelup.controller;

import com.example.onedayclass.levelup.dto.LevelUpDto;
import com.example.onedayclass.levelup.service.LevelUpService;
import com.example.onedayclass.member.dto.MemberDto;
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

@Controller
@RequestMapping("/levelups")
public class LevelUpController {

    private final LevelUpService levelUpService;

    public LevelUpController(LevelUpService levelUpService) {
        this.levelUpService = levelUpService;
    }

    /**
     * 등업 요청 목록을 조회한다.
     *
     * @param page 현재 페이지 번호
     * @param principal 로그인 사용자 정보
     * @param model 목록 데이터를 전달할 뷰 모델
     * @return 등업 요청 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        boolean admin = loginMember != null && "3".equals(loginMember.getULevel());
        model.addAttribute("requestPage",
                levelUpService.getRequestsPage(loginMember == null ? null : loginMember.getUId(), admin, page, 10));
        return "levelup/levelUpList";
    }

    /**
     * 등업 요청 상세 화면을 조회한다.
     *
     * @param lvlNum 조회할 등업 요청 번호
     * @param model 상세 데이터를 전달할 뷰 모델
     * @return 등업 요청 상세 JSP 경로
     */
    @GetMapping("/{lvlNum}")
    public String detail(@PathVariable int lvlNum, Model model) {
        model.addAttribute("requestItem", levelUpService.getRequest(lvlNum));
        return "levelup/levelUpDetail";
    }

    /**
     * 등업 요청 작성 화면의 기본값을 준비한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 신규 요청 DTO를 전달할 뷰 모델
     * @return 등업 요청 작성 JSP 경로
     */
    @GetMapping("/new")
    public String form(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        LevelUpDto levelUpDto = new LevelUpDto();
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpDto.setLvlName(loginMember.getUName());
        model.addAttribute("levelUpDto", levelUpDto);
        return "levelup/levelUpForm";
    }

    /**
     * 새 등업 요청을 등록한다.
     *
     * @param levelUpDto 등록할 등업 요청 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 폼 화면, 성공 시 목록으로 리다이렉트
     */
    @PostMapping
    public String create(@Valid LevelUpDto levelUpDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "levelup/levelUpForm";
        }
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpService.createRequest(levelUpDto);
        return "redirect:/levelups";
    }

    /**
     * 등업 요청 답변 작성 화면을 조회한다.
     *
     * @param lvlNum 부모 등업 요청 번호
     * @param model 부모 글 데이터를 전달할 뷰 모델
     * @return 등업 요청 답변 JSP 경로
     */
    @GetMapping("/{lvlNum}/reply")
    public String replyForm(@PathVariable int lvlNum, Model model) {
        model.addAttribute("parent", levelUpService.getRequest(lvlNum));
        return "levelup/levelUpReply";
    }

    /**
     * 등업 요청에 대한 답변을 등록한다.
     *
     * @param lvlNum 부모 등업 요청 번호
     * @param levelUpDto 등록할 답변 데이터
     * @param bindingResult 입력값 검증 결과
     * @param loginMember 로그인 사용자 정보
     * @param model 검증 실패 시 부모 글을 다시 전달할 뷰 모델
     * @return 검증 실패 시 답변 화면, 성공 시 목록으로 리다이렉트
     */
    @PostMapping("/{lvlNum}/reply")
    public String reply(@PathVariable int lvlNum,
                        @Valid LevelUpDto levelUpDto,
                        BindingResult bindingResult,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                        Model model) {
        LevelUpDto parent = levelUpService.getRequest(lvlNum);
        if (bindingResult.hasErrors()) {
            model.addAttribute("parent", parent);
            return "levelup/levelUpReply";
        }
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpDto.setLvlRef(parent.getLvlRef());
        levelUpDto.setLvlPos(parent.getLvlPos());
        levelUpDto.setLvlDepth(parent.getLvlDepth());
        levelUpDto.setLvlOriUid(parent.getLvlUid());
        levelUpService.replyRequest(levelUpDto);
        return "redirect:/levelups";
    }

    /**
     * 등업 요청을 승인 처리한다.
     *
     * @param lvlNum 승인할 등업 요청 번호
     * @return 관리자 화면으로 리다이렉트
     */
    @PostMapping("/{lvlNum}/approve")
    public String approve(@PathVariable int lvlNum) {
        levelUpService.approveRequest(lvlNum);
        return "redirect:/admin";
    }

    /**
     * 등업 요청을 삭제한다.
     *
     * @param lvlNum 삭제할 등업 요청 번호
     * @return 등업 요청 목록으로 리다이렉트
     */
    @PostMapping("/{lvlNum}/delete")
    public String delete(@PathVariable int lvlNum) {
        levelUpService.deleteRequest(lvlNum);
        return "redirect:/levelups";
    }
}
