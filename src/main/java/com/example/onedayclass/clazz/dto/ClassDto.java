package com.example.onedayclass.clazz.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ClassDto extends BaseVo {
    private Integer cNum;
    private String cCode;
    private String cTeacher;
    private String cUid;
    private String cCategory;
    private String cTitle;
    private String cContent;
    private String cRegDate;
    private Integer cPrice;
    private Integer cDelivery;
    private String cThumbName;
    private Integer cThumbSize;
    private String cFileName;
    private Integer cFileSize;
    private Integer cMaxStu;
    private Integer cApplyStu;
    private String cArea;
    private String cOnoff;
    private Integer cStatus;
    private Integer cLikes;
}
