package com.example.onedayclass.member.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class MemberDto extends BaseVo {
    @NotBlank
    @Size(min = 4, max = 20)
    @Pattern(regexp = "^[a-zA-Z0-9]{4,20}$")
    private String uId;

    @NotBlank
    @Size(min = 8, max = 20)
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-={}\\[\\]:;,.?/]).{8,20}$")
    private String uPw;

    @NotBlank
    @Size(min = 2, max = 20)
    @Pattern(regexp = "^[가-힣a-zA-Z]{2,20}$")
    private String uName;

    @Pattern(regexp = "^$|^01[0-9]-?\\d{3,4}-?\\d{4}$")
    private String uPhone;

    @Size(max = 10)
    private String uZip;

    @Size(max = 120)
    private String uAddr1;

    @Size(max = 120)
    private String uAddr2;

    @Email
    @Size(max = 100)
    private String uEmail;

    @NotBlank
    private String uLevel;

    @Size(max = 50)
    @Pattern(regexp = "^$|^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String sName;

    @Size(max = 255)
    private String sSns;

    public String getUId() {
        return uId;
    }

    public void setUId(String uId) {
        this.uId = uId;
    }

    public String getUPw() {
        return uPw;
    }

    public void setUPw(String uPw) {
        this.uPw = uPw;
    }

    public String getUName() {
        return uName;
    }

    public void setUName(String uName) {
        this.uName = uName;
    }

    public String getUPhone() {
        return uPhone;
    }

    public void setUPhone(String uPhone) {
        this.uPhone = uPhone;
    }

    public String getUZip() {
        return uZip;
    }

    public void setUZip(String uZip) {
        this.uZip = uZip;
    }

    public String getUAddr1() {
        return uAddr1;
    }

    public void setUAddr1(String uAddr1) {
        this.uAddr1 = uAddr1;
    }

    public String getUAddr2() {
        return uAddr2;
    }

    public void setUAddr2(String uAddr2) {
        this.uAddr2 = uAddr2;
    }

    public String getUEmail() {
        return uEmail;
    }

    public void setUEmail(String uEmail) {
        this.uEmail = uEmail;
    }

    public String getULevel() {
        return uLevel;
    }

    public void setULevel(String uLevel) {
        this.uLevel = uLevel;
    }

    public String getSName() {
        return sName;
    }

    public void setSName(String sName) {
        this.sName = sName;
    }

    public String getSSns() {
        return sSns;
    }

    public void setSSns(String sSns) {
        this.sSns = sSns;
    }
}
