package com.example.onedayclass.member.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class MemberDto extends BaseVo {
    @NotBlank
    private String uId;

    @NotBlank
    private String uPw;

    @NotBlank
    private String uName;

    private String uPhone;
    private String uZip;
    private String uAddr1;
    private String uAddr2;

    @Email
    private String uEmail;

    private String uLevel;
    private String sName;
    private String sSns;
}
