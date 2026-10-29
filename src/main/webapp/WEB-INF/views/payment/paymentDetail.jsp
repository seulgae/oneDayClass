<%-- 결제 상세 화면 --%>
<%--@elvariable id="paymentInfo" type="com.example.onedayclass.payment.dto.PaymentRequestDto"--%>
<%--@elvariable id="paymentItems" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <div>
            <h2><i class="ri-file-list-3-line"></i> 결제내역 상세</h2>
            <p class="section-subtitle">주문번호 #${paymentInfo.PNum} 의 상세 결제 및 배송 정보입니다.</p>
        </div>
        <a class="btn secondary" href="<c:url value='/payments/history' />"><i class="ri-arrow-left-line"></i> 목록으로</a>
    </div>
    <dl><dt><i class="ri-hashtag"></i> 주문번호</dt><dd><strong>#${paymentInfo.PNum}</strong></dd></dl>
    <dl><dt><i class="ri-user-line"></i> 주문자</dt><dd>${paymentInfo.UId}</dd></dl>
    <dl><dt><i class="ri-calendar-check-line"></i> 결제일시</dt><dd>${fn:substring(paymentInfo.payDate, 0, 19)}</dd></dl>
    <dl><dt><i class="ri-user-received-line"></i> 받는 분</dt><dd>${paymentInfo.RName}</dd></dl>
    <dl><dt><i class="ri-smartphone-line"></i> 휴대폰 번호</dt><dd>${paymentInfo.RPhone}</dd></dl>
    <dl><dt><i class="ri-mail-line"></i> 이메일</dt><dd>${paymentInfo.REmail}</dd></dl>
    <dl><dt><i class="ri-map-pin-line"></i> 배송지</dt><dd>(${paymentInfo.RZip}) ${paymentInfo.RAddr1} ${paymentInfo.RAddr2}</dd></dl>
    <dl><dt><i class="ri-price-tag-3-line"></i> 상품 금액</dt><dd><fmt:formatNumber value="${paymentInfo.totalPrice}" />원</dd></dl>
    <dl><dt><i class="ri-truck-line"></i> 배송비</dt><dd><fmt:formatNumber value="${paymentInfo.totalDeli}" />원</dd></dl>
    <dl><dt><i class="ri-money-dollar-circle-line"></i> 총 결제금액</dt><dd><strong style="font-size:18px; color:var(--primary);"><fmt:formatNumber value="${paymentInfo.totalPay}" />원</strong></dd></dl>
</section>

<section class="panel">
    <div class="section-head">
        <h2><i class="ri-shopping-bag-3-line"></i> 주문 상품</h2>
        <span class="badge badge-indigo">총 ${paymentItems.size()}건</span>
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
                <td><strong>${item.CTitle}</strong></td>
                <td><span class="badge badge-slate">${item.CCategory}</span></td>
                <td>${item.PQty}</td>
                <td><fmt:formatNumber value="${item.CPrice}" />원</td>
                <td><fmt:formatNumber value="${item.CDelivery}" />원</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<%@ include file="../include/footer.jspf" %>
