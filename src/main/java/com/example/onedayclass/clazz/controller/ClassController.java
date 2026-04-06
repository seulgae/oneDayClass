package com.example.onedayclass.clazz.controller;

import com.example.onedayclass.clazz.dto.ClassDto;
import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.common.storage.FileStorageService;
import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.qna.service.QnaService;
import com.example.onedayclass.review.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;

@Controller
@RequestMapping("/classes")
public class ClassController {

    private final ClassService classService;
    private final ReviewService reviewService;
    private final QnaService qnaService;
    private final FileStorageService fileStorageService;

    public ClassController(ClassService classService,
                           ReviewService reviewService,
                           QnaService qnaService,
                           FileStorageService fileStorageService) {
        this.classService = classService;
        this.reviewService = reviewService;
        this.qnaService = qnaService;
        this.fileStorageService = fileStorageService;
    }

    @GetMapping
    public String list(@RequestParam(required = false) String category,
                       @RequestParam(required = false) String onoff,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        boolean includeHidden = loginMember != null && ("2".equals(loginMember.getULevel()) || "3".equals(loginMember.getULevel()));
        model.addAttribute("classPage", classService.getClassesPage(category, onoff, includeHidden, page, 12));
        model.addAttribute("featured", classService.getFeaturedClasses(category, onoff, 4));
        model.addAttribute("selectedOnOff", onoff);
        model.addAttribute("selectedCategory", category);
        return "class/list";
    }

    @GetMapping("/{cNum}")
    public String detail(@PathVariable int cNum, HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        model.addAttribute("classItem", classService.getClass(cNum));
        model.addAttribute("reviews", reviewService.getClassReviews(cNum, loginMember == null ? null : loginMember.getUId()));
        model.addAttribute("questions", qnaService.getClassQuestions(cNum, "qTitle", null));
        return "class/detail";
    }

    @GetMapping("/new")
    public String createForm(HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!canManageClasses(loginMember)) {
            return "redirect:/classes";
        }
        ClassDto classDto = new ClassDto();
        classDto.setCUid(loginMember.getUId());
        classDto.setCTeacher(loginMember.getSName() == null ? loginMember.getUName() : loginMember.getSName());
        classDto.setCOnoff("N");
        model.addAttribute("classDto", classDto);
        return "class/form";
    }

    @PostMapping
    public String create(ClassDto classDto,
                         @RequestParam(name = "thumbnailImage", required = false) MultipartFile thumbnailImage,
                         @RequestParam(name = "detailImage", required = false) MultipartFile detailImage,
                         HttpSession session) throws IOException {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!canManageClasses(loginMember)) {
            return "redirect:/classes";
        }
        classDto.setCUid(loginMember.getUId());
        classDto.setCTeacher(loginMember.getSName() == null ? loginMember.getUName() : loginMember.getSName());
        applyUploadedFiles(classDto, null, thumbnailImage, detailImage);
        classService.createClass(classDto);
        return "redirect:/classes";
    }

    @GetMapping("/{cNum}/edit")
    public String editForm(@PathVariable int cNum, HttpSession session, Model model) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!canManageClasses(loginMember)) {
            return "redirect:/classes/" + cNum;
        }
        model.addAttribute("classDto", classService.getClass(cNum));
        return "class/form";
    }

    @PostMapping("/{cNum}/edit")
    public String edit(@PathVariable int cNum,
                       ClassDto classDto,
                       @RequestParam(name = "thumbnailImage", required = false) MultipartFile thumbnailImage,
                       @RequestParam(name = "detailImage", required = false) MultipartFile detailImage,
                       HttpSession session) throws IOException {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!canManageClasses(loginMember)) {
            return "redirect:/classes/" + cNum;
        }
        ClassDto currentClass = classService.getClass(cNum);
        classDto.setCNum(cNum);
        applyUploadedFiles(classDto, currentClass, thumbnailImage, detailImage);
        classService.updateClass(classDto);
        return "redirect:/classes/" + cNum;
    }

    @PostMapping("/{cNum}/like")
    public String like(@PathVariable int cNum, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!classService.likeClass(loginMember.getUId(), cNum)) {
            redirectAttributes.addFlashAttribute("message", "이미 추천한 클래스입니다.");
        }
        return "redirect:/classes/" + cNum;
    }

    @PostMapping("/{cNum}/delete")
    public String delete(@PathVariable int cNum, HttpSession session) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/members/login";
        }
        if (!canManageClasses(loginMember)) {
            return "redirect:/classes/" + cNum;
        }
        classService.deleteClass(cNum);
        return "redirect:/classes";
    }

    private void applyUploadedFiles(ClassDto target,
                                    ClassDto source,
                                    MultipartFile thumbnailImage,
                                    MultipartFile detailImage) throws IOException {
        if (source != null) {
            target.setCThumbName(source.getCThumbName());
            target.setCThumbSize(source.getCThumbSize());
            target.setCFileName(source.getCFileName());
            target.setCFileSize(source.getCFileSize());
        }

        if (thumbnailImage != null && !thumbnailImage.isEmpty()) {
            if (source != null) {
                fileStorageService.delete("classes", source.getCThumbName());
            }
            target.setCThumbName(fileStorageService.store(thumbnailImage, "classes"));
            target.setCThumbSize((int) thumbnailImage.getSize());
        }

        if (detailImage != null && !detailImage.isEmpty()) {
            if (source != null) {
                fileStorageService.delete("classes", source.getCFileName());
            }
            target.setCFileName(fileStorageService.store(detailImage, "classes"));
            target.setCFileSize((int) detailImage.getSize());
        }
    }

    private boolean canManageClasses(MemberDto loginMember) {
        return loginMember != null && ("2".equals(loginMember.getULevel()) || "3".equals(loginMember.getULevel()));
    }
}
