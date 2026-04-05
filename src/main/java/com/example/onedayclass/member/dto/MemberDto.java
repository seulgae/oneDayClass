package com.example.onedayclass.member.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class MemberDto {
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
