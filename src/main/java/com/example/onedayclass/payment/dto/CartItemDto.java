package com.example.onedayclass.payment.dto;

import lombok.Data;

@Data
public class CartItemDto {
    private String uId;
    private Integer cNum;
    private String cUid;
    private String cTitle;
    private Integer cPrice;
    private Integer cDelivery;
    private Integer cMaxStu;
    private Integer cApplyStu;
}
