package com.example.onedayclass.clazz.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClassDto extends BaseVo {
    private Integer cNum;
    private String cCode;
    @NotBlank
    @Size(min = 2, max = 50)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String cTeacher;
    private String cUid;

    @NotBlank
    @Size(min = 2, max = 30)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s]{2,30}$")
    private String cCategory;

    @NotBlank
    @Size(min = 4, max = 80)
    private String cTitle;

    @NotBlank
    @Size(min = 20, max = 3000)
    private String cContent;
    private String cRegDate;

    @Min(0)
    @Max(10000000)
    private Integer cPrice;

    @Min(0)
    @Max(1000000)
    private Integer cDelivery;
    private String cThumbName;
    private Integer cThumbSize;
    private String cFileName;
    private Integer cFileSize;

    @Min(1)
    @Max(999)
    private Integer cMaxStu;
    private Integer cApplyStu;

    @NotBlank
    @Size(min = 2, max = 40)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s]{2,40}$")
    private String cArea;

    @NotBlank
    @Pattern(regexp = "^[NY]$")
    private String cOnoff;
    private Integer cStatus;
    private Integer cLikes;
}
