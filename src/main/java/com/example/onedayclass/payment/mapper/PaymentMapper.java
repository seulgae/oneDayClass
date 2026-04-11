package com.example.onedayclass.payment.mapper;

import com.example.onedayclass.payment.dto.CartItemDto;
import com.example.onedayclass.payment.dto.PaymentHistoryDto;
import com.example.onedayclass.payment.dto.PaymentRequestDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PaymentMapper {
    int countCart(String uId);

    boolean existsCart(@Param("uId") String uId, @Param("cNum") int cNum);

    int insertCart(@Param("uId") String uId, @Param("cNum") int cNum);

    int deleteCart(@Param("uId") String uId, @Param("cNum") int cNum);

    List<CartItemDto> findCartItems(String uId);

    int insertPaymentInfo(PaymentRequestDto paymentRequestDto);

    int insertPaymentComplete(PaymentHistoryDto paymentHistoryDto);

    List<PaymentHistoryDto> findStudentPayments(String uId);

    List<PaymentHistoryDto> findTeacherPayments(String uId);

    PaymentRequestDto findPaymentInfoByPNum(@Param("pNum") int pNum, @Param("uId") String uId);

    List<PaymentHistoryDto> findPaymentItemsByPNum(@Param("pNum") int pNum, @Param("uId") String uId);
}
