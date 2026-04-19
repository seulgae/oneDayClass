package com.example.onedayclass.admin.controller;

import com.example.onedayclass.admin.dto.AdminBoardItemDto;
import com.example.onedayclass.admin.dto.AdminBoardStatsDto;
import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.levelup.service.LevelUpService;
import com.example.onedayclass.notice.service.NoticeService;
import com.example.onedayclass.qna.service.QnaService;
import com.example.onedayclass.requestboard.service.RequestBoardService;
import com.example.onedayclass.review.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final ClassService classService;
    private final LevelUpService levelUpService;
    private final NoticeService noticeService;
    private final QnaService qnaService;
    private final RequestBoardService requestBoardService;
    private final ReviewService reviewService;

    public AdminController(ClassService classService,
                           LevelUpService levelUpService,
                           NoticeService noticeService,
                           QnaService qnaService,
                           RequestBoardService requestBoardService,
                           ReviewService reviewService) {
        this.classService = classService;
        this.levelUpService = levelUpService;
        this.noticeService = noticeService;
        this.qnaService = qnaService;
        this.requestBoardService = requestBoardService;
        this.reviewService = reviewService;
    }

    /**
     * 관리자 대시보드 화면을 조회한다.
     *
     * @param model 승인 대기 데이터와 게시판 데이터를 전달할 뷰 모델
     * @return 관리자 대시보드 JSP 경로
     */
    @GetMapping
    public String dashboard(@ModelAttribute("filter") AdminBoardFilter filter, Model model) {
        List<AdminBoardItemDto> allBoardItems = buildBoardItems();
        List<AdminBoardItemDto> filteredBoardItems = filterBoardItems(allBoardItems, filter);

        model.addAttribute("pendingClasses", classService.getPendingClasses());
        model.addAttribute("pendingLevelUps", levelUpService.getPendingRequests());
        model.addAttribute("questions", qnaService.getQuestions("qTitle", null, "3"));
        model.addAttribute("reviews", reviewService.getReviews("rTitle", null, "3"));
        model.addAttribute("boardItems", filteredBoardItems);
        model.addAttribute("boardStats", buildStats(allBoardItems));
        model.addAttribute("activeBoardType", normalizeBoardType(filter.getBoardType()));
        model.addAttribute("keyword", normalizeKeyword(filter.getKeyword()));
        return "admin/adminDashboard";
    }

    /**
     * 관리자 승인 대상 클래스를 승인 처리한다.
     *
     * @param cNum 승인할 클래스 번호
     * @return 관리자 대시보드로 리다이렉트
     */
    @PostMapping("/classes/{cNum}/approve")
    public String approveClass(@PathVariable int cNum) {
        classService.approveClass(cNum);
        return "redirect:/admin";
    }

    @PostMapping("/boards/{boardType}/{postId}/delete")
    public String deleteBoardPost(@PathVariable String boardType,
                                  @PathVariable int postId,
                                  @ModelAttribute("filter") AdminBoardFilter filter,
                                  RedirectAttributes redirectAttributes) {
        boolean deleted = switch (normalizeBoardType(boardType)) {
            case "class" -> classService.deleteClass(postId);
            case "notice" -> noticeService.deleteNotice(postId);
            case "qna" -> qnaService.deleteQuestion(postId);
            case "request" -> requestBoardService.deleteRequest(postId);
            case "review" -> reviewService.deleteReview(postId);
            case "levelup" -> levelUpService.deleteRequest(postId);
            default -> false;
        };

        redirectAttributes.addAttribute("boardType", normalizeBoardType(filter.getBoardType()));
        redirectAttributes.addAttribute("keyword", normalizeKeyword(filter.getKeyword()));
        redirectAttributes.addFlashAttribute("message", deleted ? "게시글을 삭제했습니다." : "삭제할 게시글을 찾지 못했습니다.");
        return "redirect:/admin";
    }

    private List<AdminBoardItemDto> buildBoardItems() {
        List<AdminBoardItemDto> items = new ArrayList<>();

        classService.getClasses("cTitle", null, null, true).forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("class")
                .boardLabel("클래스")
                .postId(item.getCNum())
                .title(item.getCTitle())
                .authorId(item.getCUid())
                .createdAt(item.getCRegDate())
                .statusLabel(resolveClassStatus(item.getCStatus()))
                .detailUrl("/classes/" + item.getCNum())
                .deletable(true)
                .build()));

        noticeService.getNotices().forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("notice")
                .boardLabel("공지사항")
                .postId(item.getQNum())
                .title(item.getQTitle())
                .authorId(item.getQUid())
                .createdAt(item.getQRegDate())
                .statusLabel(resolveQnaStatus(item.getQStatus()))
                .detailUrl("/notices/" + item.getQNum())
                .deletable(true)
                .build()));

        qnaService.getQuestions("qTitle", null, "3").forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("qna")
                .boardLabel("QnA")
                .postId(item.getQNum())
                .title(item.getQTitle())
                .authorId(item.getQUid())
                .createdAt(item.getQRegDate())
                .statusLabel(resolveQnaStatus(item.getQStatus()))
                .detailUrl("/qna/" + item.getQNum())
                .deletable(true)
                .build()));

        requestBoardService.getRequests("reqTitle", null, "3").forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("request")
                .boardLabel("요청게시판")
                .postId(item.getReqNum())
                .title(item.getReqTitle())
                .authorId(item.getReqUid())
                .createdAt(item.getReqRegDate())
                .statusLabel(resolveRequestStatus(item.getReqStatus()))
                .detailUrl("/requests/" + item.getReqNum())
                .deletable(true)
                .build()));

        reviewService.getReviews("rTitle", null, "3").forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("review")
                .boardLabel("후기")
                .postId(item.getRNum())
                .title(item.getRTitle())
                .authorId(item.getRUid())
                .createdAt(item.getRRegDate())
                .statusLabel(resolveReviewStatus(item.getRStatus()))
                .detailUrl("/reviews/" + item.getRNum())
                .deletable(true)
                .build()));

        levelUpService.getRequests(null, true).forEach(item -> items.add(AdminBoardItemDto.builder()
                .boardType("levelup")
                .boardLabel("등업신청")
                .postId(item.getLvlNum())
                .title(item.getLvlTitle())
                .authorId(item.getLvlUid())
                .createdAt(item.getLvlRegDate())
                .statusLabel(resolveLevelUpStatus(item.getLvlStatus()))
                .detailUrl("/levelups/" + item.getLvlNum())
                .deletable(true)
                .build()));

        items.sort(Comparator.comparing(AdminBoardItemDto::getCreatedAt, Comparator.nullsLast(String::compareTo)).reversed()
                .thenComparing(AdminBoardItemDto::getPostId, Comparator.nullsLast(Integer::compareTo)).reversed());
        return items;
    }

    private List<AdminBoardItemDto> filterBoardItems(List<AdminBoardItemDto> items, AdminBoardFilter filter) {
        String boardType = normalizeBoardType(filter.getBoardType());
        String keyword = normalizeKeyword(filter.getKeyword()).toLowerCase(Locale.ROOT);

        return items.stream()
                .filter(item -> "all".equals(boardType) || item.getBoardType().equals(boardType))
                .filter(item -> keyword.isBlank()
                        || safeLower(item.getTitle()).contains(keyword)
                        || safeLower(item.getAuthorId()).contains(keyword))
                .collect(Collectors.toList());
    }

    private AdminBoardStatsDto buildStats(List<AdminBoardItemDto> items) {
        return AdminBoardStatsDto.builder()
                .totalPosts(items.size())
                .classCount(countByBoardType(items, "class"))
                .noticeCount(countByBoardType(items, "notice"))
                .qnaCount(countByBoardType(items, "qna"))
                .requestCount(countByBoardType(items, "request"))
                .reviewCount(countByBoardType(items, "review"))
                .levelUpCount(countByBoardType(items, "levelup"))
                .pendingClassCount(classService.getPendingClasses().size())
                .pendingLevelUpCount((int) items.stream()
                        .filter(item -> "levelup".equals(item.getBoardType()) && "대기".equals(item.getStatusLabel()))
                        .count())
                .deletedCount((int) items.stream()
                        .filter(item -> "삭제됨".equals(item.getStatusLabel()))
                        .count())
                .build();
    }

    private int countByBoardType(List<AdminBoardItemDto> items, String boardType) {
        return (int) items.stream()
                .filter(item -> boardType.equals(item.getBoardType()))
                .count();
    }

    private String normalizeBoardType(String boardType) {
        if (boardType == null) {
            return "all";
        }
        return switch (boardType.toLowerCase(Locale.ROOT)) {
            case "class", "notice", "qna", "request", "review", "levelup" -> boardType.toLowerCase(Locale.ROOT);
            default -> "all";
        };
    }

    private String normalizeKeyword(String keyword) {
        return keyword == null ? "" : keyword.trim();
    }

    private String safeLower(String value) {
        return value == null ? "" : value.toLowerCase(Locale.ROOT);
    }

    private String resolveQnaStatus(Integer status) {
        if (status != null && status >= 3) {
            return "삭제됨";
        }
        return "게시중";
    }

    private String resolveClassStatus(Integer status) {
        if (status != null && status >= 3) {
            return "삭제됨";
        }
        if (status != null && status == 1) {
            return "승인대기";
        }
        return "게시중";
    }

    private String resolveRequestStatus(Integer status) {
        if (status != null && status >= 3) {
            return "삭제됨";
        }
        return "게시중";
    }

    private String resolveReviewStatus(Integer status) {
        if (status != null && status >= 3) {
            return "삭제됨";
        }
        if (status != null && status == 1) {
            return "대기";
        }
        return "게시중";
    }

    private String resolveLevelUpStatus(Integer status) {
        if (status != null && status >= 3) {
            return "삭제됨";
        }
        if (status != null && status == 2) {
            return "승인";
        }
        return "대기";
    }

    public static class AdminBoardFilter {
        private String boardType;
        private String keyword;

        public String getBoardType() {
            return boardType;
        }

        public void setBoardType(String boardType) {
            this.boardType = boardType;
        }

        public String getKeyword() {
            return keyword;
        }

        public void setKeyword(String keyword) {
            this.keyword = keyword;
        }
    }
}
