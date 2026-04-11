package com.example.onedayclass.review.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDto extends BaseVo {
    private String rUid;
    private Integer rNum;

    @NotBlank
    @Size(min = 4, max = 80)
    private String rTitle;

    @NotBlank
    @Size(min = 10, max = 3000)
    private String rContent;
    private Integer rCnt;
    private Integer rLikes;
    private String rRegDate;
    private String rFileName;
    private Integer rFileSize;
    private Integer rStatus;
    private Integer cNum;
}
