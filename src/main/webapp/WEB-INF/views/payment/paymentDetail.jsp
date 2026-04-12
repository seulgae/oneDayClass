<%-- 결제 상세 화면 --%>
<%--@elvariable id="paymentInfo" type="com.example.onedayclass.payment.dto.PaymentRequestDto"--%>
<%--@elvariable id="paymentItems" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>결제내역 상세</h2>
        <a class="btn secondary" href="<c:url value='/payments/history' />">목록으로</a>
    </div>
    <dl><dt>주문번호</dt><dd>${paymentInfo.PNum}</dd></dl>
    <dl><dt>주문자</dt><dd>${paymentInfo.UId}</dd></dl>
    <dl><dt>결제일</dt><dd>${fn:substring(paymentInfo.payDate, 0, 19)}</dd></dl>
    <dl><dt>받는 분</dt><dd>${paymentInfo.RName}</dd></dl>
    <dl><dt>휴대폰 번호</dt><dd>${paymentInfo.RPhone}</dd></dl>
    <dl><dt>이메일</dt><dd>${paymentInfo.REmail}</dd></dl>
    <dl><dt>배송지</dt><dd>(${paymentInfo.RZip}) ${paymentInfo.RAddr1} ${paymentInfo.RAddr2}</dd></dl>
    <dl><dt>결제 금액</dt><dd>${paymentInfo.totalPrice}원</dd></dl>
    <dl><dt>배송비</dt><dd>${paymentInfo.totalDeli}원</dd></dl>
    <dl><dt>총 결제금액</dt><dd>${paymentInfo.totalPay}원</dd></dl>
</section>

<section class="panel">
    <div class="section-head">
        <h2>주문 상품</h2>
        <span class="muted">${paymentItems.size()}건</span>
    </div>
    <table class="table board-table">
        <thead>
        <tr>
            <th>상품명</th>
            <th>카테고리</th>
            <th>수량</th>
            <th>상품 금액</th>
            <th>배송비</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${paymentItems}">
            <tr>
                <td>${item.CTitle}</td>
                <td>${item.CCategory}</td>
                <td>${item.PQty}</td>
                <td>${item.CPrice}원</td>
                <td>${item.CDelivery}원</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<%@ include file="../include/footer.jspf" %>

