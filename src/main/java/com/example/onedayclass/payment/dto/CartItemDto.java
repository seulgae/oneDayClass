package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class CartItemDto extends BaseVo {
    private String uId;
    private Integer cNum;
    private String cUid;
    private String cTitle;
    private Integer cPrice;
    private Integer cDelivery;
    private Integer cMaxStu;
    private Integer cApplyStu;
}
