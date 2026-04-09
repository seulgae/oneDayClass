package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class PaymentRequestDto extends BaseVo {
    private Integer pNum;
    private String uId;
    private String rName;
    private String rPhone;
    private String rZip;
    private String rAddr1;
    private String rAddr2;
    private String rEmail;
    private Integer totalPrice;
    private Integer totalDeli;
    private Integer totalPay;
    private String payDate;
}
