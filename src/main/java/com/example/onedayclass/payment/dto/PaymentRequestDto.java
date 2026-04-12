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
    private Integer pNum; /* 결제 번호 */
    private String uId; /* 구매자 아이디 */

    @NotBlank
    @Size(min = 2, max = 30)
    @Pattern(regexp = "^[가-힣a-zA-Z\\s]{2,30}$")
    private String rName; /* 수령인 이름 */

    @NotBlank
    @Pattern(regexp = "^01[0-9]-?\\d{3,4}-?\\d{4}$")
    private String rPhone; /* 수령인 연락처 */

    @NotBlank
    @Size(max = 10)
    private String rZip; /* 우편번호 */

    @NotBlank
    @Size(max = 120)
    private String rAddr1; /* 기본 주소 */

    @NotBlank
    @Size(min = 2, max = 120)
    private String rAddr2; /* 상세 주소 */

    @NotBlank
    @Email
    @Size(max = 100)
    private String rEmail; /* 수령인 이메일 */

    @Min(0)
    @Max(100000000)
    private Integer totalPrice; /* 총 상품 금액 */

    @Min(0)
    @Max(10000000)
    private Integer totalDeli; /* 총 배송비 */

    @Min(0)
    @Max(100000000)
    private Integer totalPay; /* 최종 결제 금액 */
    private String payDate; /* 결제일 */
}
