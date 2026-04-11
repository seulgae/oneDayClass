package com.example.onedayclass.payment.service;

import com.example.onedayclass.payment.dto.CartItemDto;
import com.example.onedayclass.payment.dto.PaymentHistoryDto;
import com.example.onedayclass.payment.dto.PaymentRequestDto;

import java.util.List;

public interface PaymentService {
    int getCartCount(String uId);

    boolean addCart(String uId, int cNum);

    boolean removeCart(String uId, int cNum);

    List<CartItemDto> getCartItems(String uId);

    boolean checkout(PaymentRequestDto paymentRequestDto, String uId);

    List<PaymentHistoryDto> getStudentPayments(String uId);

    List<PaymentHistoryDto> getTeacherPayments(String uId);

    PaymentRequestDto getPaymentInfo(int pNum, String uId);

    List<PaymentHistoryDto> getPaymentItems(int pNum, String uId);
}
