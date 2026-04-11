package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentRequestDto extends BaseVo {
    private Integer pNum;
    private String uId;

    @NotBlank
    @Size(min = 2, max = 30)
    @Pattern(regexp = "^[가-힣a-zA-Z\\s]{2,30}$")
    private String rName;

    @NotBlank
    @Pattern(regexp = "^01[0-9]-?\\d{3,4}-?\\d{4}$")
    private String rPhone;

    @NotBlank
    @Size(max = 10)
    private String rZip;

    @NotBlank
    @Size(max = 120)
    private String rAddr1;

    @NotBlank
    @Size(min = 2, max = 120)
    private String rAddr2;

    @NotBlank
    @Email
    @Size(max = 100)
    private String rEmail;

    @Min(0)
    @Max(100000000)
    private Integer totalPrice;

    @Min(0)
    @Max(10000000)
    private Integer totalDeli;

    @Min(0)
    @Max(100000000)
    private Integer totalPay;
    private String payDate;
}
