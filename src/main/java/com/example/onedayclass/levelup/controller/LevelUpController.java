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

    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        boolean admin = loginMember != null && "3".equals(loginMember.getULevel());
        model.addAttribute("requestPage",
                levelUpService.getRequestsPage(loginMember == null ? null : loginMember.getUId(), admin, page, 10));
        return "levelup/list";
    }

    @GetMapping("/{lvlNum}")
    public String detail(@PathVariable int lvlNum, Model model) {
        model.addAttribute("requestItem", levelUpService.getRequest(lvlNum));
        return "levelup/detail";
    }

    @GetMapping("/new")
    public String form(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        LevelUpDto levelUpDto = new LevelUpDto();
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpDto.setLvlName(loginMember.getUName());
        model.addAttribute("levelUpDto", levelUpDto);
        return "levelup/form";
    }

    @PostMapping
    public String create(@Valid LevelUpDto levelUpDto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        if (bindingResult.hasErrors()) {
            return "levelup/form";
        }
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpService.createRequest(levelUpDto);
        return "redirect:/levelups";
    }

    @GetMapping("/{lvlNum}/reply")
    public String replyForm(@PathVariable int lvlNum, Model model) {
        model.addAttribute("parent", levelUpService.getRequest(lvlNum));
        return "levelup/reply";
    }

    @PostMapping("/{lvlNum}/reply")
    public String reply(@PathVariable int lvlNum,
                        @Valid LevelUpDto levelUpDto,
                        BindingResult bindingResult,
                        @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                        Model model) {
        LevelUpDto parent = levelUpService.getRequest(lvlNum);
        if (bindingResult.hasErrors()) {
            model.addAttribute("parent", parent);
            return "levelup/reply";
        }
        levelUpDto.setLvlUid(loginMember.getUId());
        levelUpDto.setLvlRef(parent.getLvlRef());
        levelUpDto.setLvlPos(parent.getLvlPos());
        levelUpDto.setLvlDepth(parent.getLvlDepth());
        levelUpDto.setLvlOriUid(parent.getLvlUid());
        levelUpService.replyRequest(levelUpDto);
        return "redirect:/levelups";
    }

    @PostMapping("/{lvlNum}/approve")
    public String approve(@PathVariable int lvlNum) {
        levelUpService.approveRequest(lvlNum);
        return "redirect:/admin";
    }

    @PostMapping("/{lvlNum}/delete")
    public String delete(@PathVariable int lvlNum) {
        levelUpService.deleteRequest(lvlNum);
        return "redirect:/levelups";
    }
}
