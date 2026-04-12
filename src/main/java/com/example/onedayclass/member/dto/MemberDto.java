package com.example.onedayclass.member.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDto extends BaseVo {
    @NotBlank
    @Size(min = 4, max = 20)
    @Pattern(regexp = "^[a-zA-Z0-9]{4,20}$")
    private String uId; /* 회원 아이디 */

    @NotBlank
    @Size(min = 8, max = 20)
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-={}\\[\\]:;,.?/]).{8,20}$")
    private String uPw; /* 회원 비밀번호 */

    @NotBlank
    @Size(min = 2, max = 20)
    @Pattern(regexp = "^[가-힣a-zA-Z]{2,20}$")
    private String uName; /* 회원 이름 */

    @Pattern(regexp = "^$|^01[0-9]-?\\d{3,4}-?\\d{4}$")
    private String uPhone; /* 회원 연락처 */

    @Size(max = 10)
    private String uZip; /* 우편번호 */

    @Size(max = 120)
    private String uAddr1; /* 기본 주소 */

    @Size(max = 120)
    private String uAddr2; /* 상세 주소 */

    @Email
    @Size(max = 100)
    private String uEmail; /* 이메일 주소 */

    @NotBlank
    private String uLevel; /* 회원 등급 */

    @Size(min = 2, max = 50)
    @Pattern(regexp = "^$|^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String sName; /* 스튜디오명 또는 상호명 */

    @Size(max = 255)
    private String sSns; /* SNS 주소 */
}
