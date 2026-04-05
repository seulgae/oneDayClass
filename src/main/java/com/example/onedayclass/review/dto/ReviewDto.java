package com.example.onedayclass.review.dto;

import lombok.Data;

@Data
public class ReviewDto {
    private String rUid;
    private Integer rNum;
    private String rTitle;
    private String rContent;
    private Integer rCnt;
    private Integer rLikes;
    private String rRegDate;
    private String rFileName;
    private Integer rFileSize;
    private Integer rStatus;
    private Integer cNum;
}
