package com.example.onedayclass.admin.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AdminBoardItemDto {
    private final String boardType;
    private final String boardLabel;
    private final Integer postId;
    private final String title;
    private final String authorId;
    private final String createdAt;
    private final String statusLabel;
    private final String detailUrl;
    private final boolean deletable;
}
