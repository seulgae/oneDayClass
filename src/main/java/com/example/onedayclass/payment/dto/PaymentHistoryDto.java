package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentHistoryDto extends BaseVo {
    private Integer pNum; /* 결제 번호 */
    private String uId; /* 구매자 아이디 */
    private Integer cNum; /* 클래스 번호 */
    private String cUid; /* 강사 아이디 */
    private String cTitle; /* 클래스 제목 */
    private Integer pQty; /* 구매 수량 */
    private String payDate; /* 결제일 */
    private String rEmail; /* 수령인 이메일 */
    private String cCategory; /* 클래스 카테고리 */
    private Integer cPrice; /* 클래스 가격 */
    private Integer cDelivery; /* 배송비 */
}
