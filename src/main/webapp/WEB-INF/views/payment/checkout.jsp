<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>결제정보 입력</h2>
    <form method="post" action="/payments/checkout">
        <div class="form-grid">
            <input type="text" name="rName" placeholder="받는 분 이름" required>
            <input type="text" name="rPhone" placeholder="받는 분 연락처" required>
            <input type="text" name="rZip" placeholder="우편번호">
            <input type="email" name="rEmail" placeholder="이메일">
        </div>
        <input type="text" name="rAddr1" placeholder="기본주소">
        <input type="text" name="rAddr2" placeholder="상세주소">
        <div class="form-grid">
            <input type="number" name="totalPrice" placeholder="상품 금액" required>
            <input type="number" name="totalDeli" placeholder="배송비 합계" required>
            <input type="number" name="totalPay" placeholder="최종 결제 금액" required>
        </div>
        <button type="submit">결제 완료</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
