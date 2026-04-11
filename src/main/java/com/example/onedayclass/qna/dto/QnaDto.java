package com.example.onedayclass.qna.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaDto extends BaseVo {
    private Integer qNum;
    private String qUid;
    @NotBlank
    @Size(min = 4, max = 80)
    private String qTitle;

    @NotBlank
    @Size(min = 10, max = 3000)
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
