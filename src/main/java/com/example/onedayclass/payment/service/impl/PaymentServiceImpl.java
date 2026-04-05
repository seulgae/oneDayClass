package com.example.onedayclass.payment.service.impl;

import com.example.onedayclass.clazz.mapper.ClassMapper;
import com.example.onedayclass.payment.dto.CartItemDto;
import com.example.onedayclass.payment.dto.PaymentHistoryDto;
import com.example.onedayclass.payment.dto.PaymentRequestDto;
import com.example.onedayclass.payment.mapper.PaymentMapper;
import com.example.onedayclass.payment.service.PaymentService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService {

    private final PaymentMapper paymentMapper;
    private final ClassMapper classMapper;

    public PaymentServiceImpl(PaymentMapper paymentMapper, ClassMapper classMapper) {
        this.paymentMapper = paymentMapper;
        this.classMapper = classMapper;
    }

    @Override
    public int getCartCount(String uId) {
        return paymentMapper.countCart(uId);
    }

    @Override
    public boolean addCart(String uId, int cNum) {
        if (paymentMapper.existsCart(uId, cNum)) {
            return false;
        }
        return paymentMapper.insertCart(uId, cNum) > 0;
    }

    @Override
    public boolean removeCart(String uId, int cNum) {
        return paymentMapper.deleteCart(uId, cNum) > 0;
    }

    @Override
    public List<CartItemDto> getCartItems(String uId) {
        return paymentMapper.findCartItems(uId);
    }

    @Override
    @Transactional
    public boolean checkout(PaymentRequestDto paymentRequestDto, String uId) {
        List<CartItemDto> items = paymentMapper.findCartItems(uId);
        if (items.isEmpty()) {
            return false;
        }

        paymentRequestDto.setUId(uId);
        int inserted = paymentMapper.insertPaymentInfo(paymentRequestDto);
        if (inserted == 0 || paymentRequestDto.getPNum() == null) {
            return false;
        }

        for (CartItemDto item : items) {
            PaymentHistoryDto historyDto = new PaymentHistoryDto();
            historyDto.setPNum(paymentRequestDto.getPNum());
            historyDto.setUId(uId);
            historyDto.setCNum(item.getCNum());
            historyDto.setCUid(item.getCUid());
            historyDto.setCTitle(item.getCTitle());
            historyDto.setPQty(1);
            paymentMapper.insertPaymentComplete(historyDto);
            classMapper.increaseApplyStu(item.getCNum(), 1);
            paymentMapper.deleteCart(uId, item.getCNum());
        }
        return true;
    }

    @Override
    public List<PaymentHistoryDto> getStudentPayments(String uId) {
        return paymentMapper.findStudentPayments(uId);
    }

    @Override
    public List<PaymentHistoryDto> getTeacherPayments(String uId) {
        return paymentMapper.findTeacherPayments(uId);
    }
}
