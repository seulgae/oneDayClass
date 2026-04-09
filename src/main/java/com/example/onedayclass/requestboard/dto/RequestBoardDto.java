package com.example.onedayclass.requestboard.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class RequestBoardDto extends BaseVo {
    private Integer reqNum;
    private String reqUid;
    private String reqTitle;
    private String reqContent;
    private String reqRegDate;
    private Integer reqPos;
    private Integer reqRef;
    private Integer reqDepth;
    private Integer parentReqNum;
    private String reqOriUid;
    private Integer reqStatus;
}
