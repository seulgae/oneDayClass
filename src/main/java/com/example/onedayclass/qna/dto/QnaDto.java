package com.example.onedayclass.qna.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class QnaDto extends BaseVo {
    private Integer qNum;
    private String qUid;
    private String qTitle;
    private String qContent;
    private String qRegDate;
    private Integer qPos;
    private Integer qRef;
    private Integer qDepth;
    private Integer parentQNum;
    private String qOriUid;
    private String qFileName;
    private Integer qFileSize;
    private Integer qStatus;
    private Integer cNum;
}
