package com.example.onedayclass.review.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ReviewDto extends BaseVo {
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
