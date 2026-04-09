package com.example.onedayclass.levelup.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class LevelUpDto extends BaseVo {
    private Integer lvlNum;
    private String lvlUid;
    private String lvlTitle;
    private String lvlContent;
    private String lvlName;
    private String lvlSns;
    private String lvlRegDate;
    private Integer lvlPos;
    private Integer lvlRef;
    private Integer lvlDepth;
    private String lvlFileName;
    private Integer lvlFileSize;
    private Integer lvlStatus;
    private String lvlOriUid;
}
