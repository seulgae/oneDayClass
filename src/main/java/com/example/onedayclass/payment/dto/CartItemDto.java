package com.example.onedayclass.payment.dto;

import com.example.onedayclass.common.dto.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartItemDto extends BaseVo {
    private String uId; /* 장바구니 사용자 아이디 */
    private Integer cNum; /* 클래스 번호 */
    private String cUid; /* 강사 아이디 */
    private String cTitle; /* 클래스 제목 */
    private Integer cPrice; /* 클래스 가격 */
    private Integer cDelivery; /* 배송비 */
    private Integer cMaxStu; /* 최대 수강 인원 */
    private Integer cApplyStu; /* 현재 신청 인원 */
}
