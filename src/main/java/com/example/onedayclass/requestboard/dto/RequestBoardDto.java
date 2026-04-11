package com.example.onedayclass.requestboard.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestBoardDto extends BaseVo {
    private Integer reqNum;
    private String reqUid;
    @NotBlank
    @Size(min = 4, max = 80)
    private String reqTitle;

    @NotBlank
    @Size(min = 10, max = 3000)
    private String reqContent;
    private String reqRegDate;
    private Integer reqPos;
    private Integer reqRef;
    private Integer reqDepth;
    private Integer parentReqNum;
    private String reqOriUid;
    private Integer reqStatus;
}
