package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentHistoryDto extends BaseVo {
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
