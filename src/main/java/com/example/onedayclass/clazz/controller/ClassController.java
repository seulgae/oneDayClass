package com.example.onedayclass.clazz.controller;

import com.example.onedayclass.clazz.dto.ClassDto;
import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.common.storage.FileStorageService;
import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.qna.service.QnaService;
import com.example.onedayclass.review.service.ReviewService;
import com.example.onedayclass.security.MemberPrincipal;
import jakarta.validation.Valid;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Objects;

@Controller
@RequestMapping("/classes")
public class ClassController {

    private static final String DEFAULT_THUMBNAIL_IMAGE = "default-class-thumb.svg";
    private static final String DEFAULT_DETAIL_IMAGE = "default-class-detail.svg";

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

    /**
     * 클래스 목록과 추천 클래스를 조회한다.
     *
     * @param keyField 검색 기준 필드
     * @param keyword 검색어
     * @param onoff 온/오프라인 구분값
     * @param page 현재 페이지 번호
     * @param principal 로그인 사용자 정보
     * @param model 목록 데이터와 검색 상태를 전달할 뷰 모델
     * @return 클래스 목록 JSP 경로
     */
    @GetMapping
    public String list(@RequestParam(required = false, defaultValue = "cTitle") String keyField,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) String onoff,
                       @RequestParam(defaultValue = "1") int page,
                       @AuthenticationPrincipal MemberPrincipal principal,
                       Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        boolean includeHidden = loginMember != null
                && ("2".equals(loginMember.getULevel())
                || "3".equals(loginMember.getULevel())
                || "4".equals(loginMember.getULevel()));
        model.addAttribute("classPage", classService.getClassesPage(keyField, keyword, onoff, includeHidden, page, 12));
        model.addAttribute("featured", classService.getFeaturedClasses(keyField, keyword, onoff, 4));
        model.addAttribute("selectedKeyField", keyField);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedOnOff", onoff);
        return "class/classList";
    }

    /**
     * 클래스 상세 화면과 관련 후기/QnA를 조회한다.
     *
     * @param cNum 조회할 클래스 번호
     * @param principal 로그인 사용자 정보
     * @param model 상세 데이터와 연관 데이터를 전달할 뷰 모델
     * @return 클래스 상세 JSP 경로
     */
    @GetMapping("/{cNum}")
    public String detail(@PathVariable int cNum,
                         @AuthenticationPrincipal MemberPrincipal principal,
                         Model model) {
        MemberDto loginMember = principal == null ? null : principal.getMember();
        ClassDto classItem = classService.getClass(cNum);
        model.addAttribute("classItem", classItem);
        model.addAttribute("canManageClass", canManageClass(classItem, loginMember));
        model.addAttribute("reviews", reviewService.getClassReviews(cNum, loginMember == null ? null : loginMember.getUId()));
        model.addAttribute("questions", qnaService.getClassQuestions(cNum, "qTitle", null));
        return "class/classDetail";
    }

    /**
     * 클래스 등록 화면의 기본값을 준비한다.
     *
     * @param loginMember 로그인 사용자 정보
     * @param model 신규 클래스 DTO를 전달할 뷰 모델
     * @return 클래스 등록/수정 JSP 경로
     */
    @GetMapping("/new")
    public String createForm(@AuthenticationPrincipal(expression = "member") MemberDto loginMember, Model model) {
        ClassDto classDto = new ClassDto();
        classDto.setCUid(loginMember.getUId());
        classDto.setCTeacher(loginMember.getSName() == null ? loginMember.getUName() : loginMember.getSName());
        classDto.setCOnoff("N");
        applyDefaultImages(classDto);
        model.addAttribute("classDto", classDto);
        return "class/classForm";
    }

    /**
     * 신규 클래스를 등록한다.
     *
     * @param classDto 등록할 클래스 데이터
     * @param bindingResult 입력값 검증 결과
     * @param thumbnailImage 썸네일 업로드 파일
     * @param detailImage 상세 이미지 업로드 파일
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 폼 화면, 성공 시 목록으로 리다이렉트
     * @throws IOException 파일 저장 중 오류가 발생한 경우
     */
    @PostMapping
    public String create(@Valid ClassDto classDto,
                         BindingResult bindingResult,
                         @RequestParam(name = "thumbnailImage", required = false) MultipartFile thumbnailImage,
                         @RequestParam(name = "detailImage", required = false) MultipartFile detailImage,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) throws IOException {
        if (bindingResult.hasErrors()) {
            return "class/classForm";
        }
        classDto.setCUid(loginMember.getUId());
        classDto.setCTeacher(loginMember.getSName() == null ? loginMember.getUName() : loginMember.getSName());
        applyUploadedFiles(classDto, null, thumbnailImage, detailImage);
        classService.createClass(classDto);
        return "redirect:/classes";
    }

    /**
     * 클래스 수정 화면을 조회한다.
     *
     * @param cNum 수정할 클래스 번호
     * @param model 기존 클래스 정보를 전달할 뷰 모델
     * @return 클래스 등록/수정 JSP 경로
     */
    @GetMapping("/{cNum}/edit")
    public String editForm(@PathVariable int cNum,
                           @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                           Model model) {
        ClassDto classDto = classService.getClass(cNum);
        ensureCanManageClass(classDto, loginMember);
        applyDefaultImages(classDto);
        model.addAttribute("classDto", classDto);
        return "class/classForm";
    }

    /**
     * 기존 클래스를 수정한다.
     *
     * @param cNum 수정할 클래스 번호
     * @param classDto 수정할 클래스 데이터
     * @param bindingResult 입력값 검증 결과
     * @param thumbnailImage 썸네일 업로드 파일
     * @param detailImage 상세 이미지 업로드 파일
     * @param loginMember 로그인 사용자 정보
     * @return 검증 실패 시 폼 화면, 성공 시 상세 화면으로 리다이렉트
     * @throws IOException 파일 저장 중 오류가 발생한 경우
     */
    @PostMapping("/{cNum}/edit")
    public String edit(@PathVariable int cNum,
                       @Valid ClassDto classDto,
                       BindingResult bindingResult,
                       @RequestParam(name = "thumbnailImage", required = false) MultipartFile thumbnailImage,
                       @RequestParam(name = "detailImage", required = false) MultipartFile detailImage,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember) throws IOException {
        ClassDto currentClass = classService.getClass(cNum);
        ensureCanManageClass(currentClass, loginMember);
        if (bindingResult.hasErrors()) {
            classDto.setCNum(cNum);
            classDto.setCUid(currentClass.getCUid());
            classDto.setCThumbName(currentClass.getCThumbName());
            classDto.setCThumbSize(currentClass.getCThumbSize());
            classDto.setCFileName(currentClass.getCFileName());
            classDto.setCFileSize(currentClass.getCFileSize());
            return "class/classForm";
        }
        classDto.setCNum(cNum);
        classDto.setCUid(currentClass.getCUid());
        applyUploadedFiles(classDto, currentClass, thumbnailImage, detailImage);
        classService.updateClass(classDto);
        return "redirect:/classes/" + cNum;
    }

    /**
     * 클래스 좋아요를 추가한다.
     *
     * @param cNum 추천할 클래스 번호
     * @param loginMember 로그인 사용자 정보
     * @param redirectAttributes 중복 추천 메시지를 전달할 리다이렉트 속성
     * @return 클래스 상세 화면으로 리다이렉트
     */
    @PostMapping("/{cNum}/like")
    public String like(@PathVariable int cNum,
                       @AuthenticationPrincipal(expression = "member") MemberDto loginMember,
                       RedirectAttributes redirectAttributes) {
        if (!classService.likeClass(loginMember.getUId(), cNum)) {
            redirectAttributes.addFlashAttribute("message", "이미 추천한 클래스입니다.");
        }
        return "redirect:/classes/" + cNum;
    }

    /**
     * 클래스를 삭제한다.
     *
     * @param cNum 삭제할 클래스 번호
     * @return 클래스 목록으로 리다이렉트
     */
    @PostMapping("/{cNum}/delete")
    public String delete(@PathVariable int cNum,
                         @AuthenticationPrincipal(expression = "member") MemberDto loginMember) {
        ensureCanManageClass(classService.getClass(cNum), loginMember);
        classService.deleteClass(cNum);
        return "redirect:/classes";
    }

    private void ensureCanManageClass(ClassDto classDto, MemberDto loginMember) {
        if (!canManageClass(classDto, loginMember)) {
            throw new AccessDeniedException("Class management is allowed only for the author, admin, or operator.");
        }
    }

    private boolean canManageClass(ClassDto classDto, MemberDto loginMember) {
        if (classDto == null || loginMember == null) {
            return false;
        }
        return Objects.equals(classDto.getCUid(), loginMember.getUId()) || isAdminOrOperator(loginMember);
    }

    private boolean isAdminOrOperator(MemberDto member) {
        return "3".equals(member.getULevel()) || "4".equals(member.getULevel());
    }

    /**
     * 업로드된 썸네일/상세 이미지를 저장하고 대상 DTO에 파일 정보를 반영한다.
     *
     * @param target 저장 결과를 반영할 대상 DTO
     * @param source 기존 파일 정보를 복사할 원본 DTO
     * @param thumbnailImage 새 썸네일 파일
     * @param detailImage 새 상세 이미지 파일
     * @throws IOException 파일 저장 또는 삭제 중 오류가 발생한 경우
     */
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
            if (source != null && isStoredUpload(source.getCThumbName())) {
                fileStorageService.delete("classes", source.getCThumbName());
            }
            target.setCThumbName(fileStorageService.store(thumbnailImage, "classes"));
            target.setCThumbSize((int) thumbnailImage.getSize());
        }

        if (detailImage != null && !detailImage.isEmpty()) {
            if (source != null && isStoredUpload(source.getCFileName())) {
                fileStorageService.delete("classes", source.getCFileName());
            }
            target.setCFileName(fileStorageService.store(detailImage, "classes"));
            target.setCFileSize((int) detailImage.getSize());
        }

        applyDefaultImages(target);
    }

    private void applyDefaultImages(ClassDto classDto) {
        if (classDto == null) {
            return;
        }
        if (classDto.getCThumbName() == null || classDto.getCThumbName().isBlank()) {
            classDto.setCThumbName(DEFAULT_THUMBNAIL_IMAGE);
            classDto.setCThumbSize(0);
        }
        if (classDto.getCFileName() == null || classDto.getCFileName().isBlank()) {
            classDto.setCFileName(DEFAULT_DETAIL_IMAGE);
            classDto.setCFileSize(0);
        }
    }

    private boolean isStoredUpload(String fileName) {
        return fileName != null
                && !fileName.isBlank()
                && !DEFAULT_THUMBNAIL_IMAGE.equals(fileName)
                && !DEFAULT_DETAIL_IMAGE.equals(fileName);
    }
}
