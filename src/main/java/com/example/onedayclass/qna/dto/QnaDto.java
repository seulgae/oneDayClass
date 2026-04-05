package com.example.onedayclass.qna.dto;

import lombok.Data;

@Data
public class QnaDto {
    private Integer qNum;
    private String qUid;
    private String qTitle;
    private String qContent;
    private String qRegDate;
    private Integer qPos;
    private Integer qRef;
    private Integer qDepth;
    private String qOriUid;
    private String qFileName;
    private Integer qFileSize;
    private Integer qStatus;
    private Integer cNum;
}
