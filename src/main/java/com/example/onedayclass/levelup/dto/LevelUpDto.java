package com.example.onedayclass.levelup.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LevelUpDto extends BaseVo {
    private Integer lvlNum;
    private String lvlUid;
    @Size(min = 4, max = 80)
    private String lvlTitle;

    @Size(min = 20, max = 3000)
    private String lvlContent;

    @Size(min = 2, max = 50)
    @Pattern(regexp = "^$|^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String lvlName;

    @Size(max = 255)
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
