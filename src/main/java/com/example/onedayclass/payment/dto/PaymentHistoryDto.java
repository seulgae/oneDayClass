package com.example.onedayclass.payment.dto;

import lombok.Data;

@Data
public class PaymentHistoryDto {
    private Integer pNum;
    private String uId;
    private Integer cNum;
    private String cUid;
    private String cTitle;
    private Integer pQty;
    private String payDate;
    private String rEmail;
    private String cCategory;
    private Integer cPrice;
    private Integer cDelivery;
}
