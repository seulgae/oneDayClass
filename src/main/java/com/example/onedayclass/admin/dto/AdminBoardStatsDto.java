package com.example.onedayclass.admin.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AdminBoardStatsDto {
    private final int totalPosts;
    private final int classCount;
    private final int noticeCount;
    private final int qnaCount;
    private final int requestCount;
    private final int reviewCount;
    private final int levelUpCount;
    private final int pendingClassCount;
    private final int pendingLevelUpCount;
    private final int deletedCount;
}
