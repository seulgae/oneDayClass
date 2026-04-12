package com.example.onedayclass.common.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;

@Getter
@Setter
public class BaseVo implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private String createdDate;
    private String createdBy;
    private String updatedDate;
    private String updatedBy;
}
