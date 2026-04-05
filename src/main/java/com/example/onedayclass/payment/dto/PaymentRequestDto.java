package com.example.onedayclass.payment.dto;

import lombok.Data;

@Data
public class PaymentRequestDto {
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
