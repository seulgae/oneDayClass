<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>결제정보 입력</h2>
    <form method="post" action="/payments/checkout" id="checkoutForm">
        <div class="form-grid">
            <input type="text" name="rName" placeholder="받는 분 이름" required pattern="^[가-힣a-zA-Z\\s]{2,30}$" title="이름은 2~30자 이내로 입력해 주세요.">
            <input type="text" name="rPhone" placeholder="받는 분 연락처" required pattern="^01[0-9]-?\\d{3,4}-?\\d{4}$" title="휴대폰 번호 형식이 올바르지 않습니다.">
            <div class="zip-field">
                <input type="text" id="rZip" name="rZip" placeholder="우편번호" required readonly>
                <button type="button" class="btn secondary" onclick="openPostcode('rZip', 'rAddr1', 'rAddr2')">주소찾기</button>
            </div>
            <input type="email" name="rEmail" placeholder="이메일" required title="이메일 형식이 올바르지 않습니다.">
        </div>
        <input type="text" id="rAddr1" name="rAddr1" placeholder="기본주소" required readonly>
        <input type="text" id="rAddr2" name="rAddr2" placeholder="상세주소" required minlength="2" maxlength="120" title="상세주소를 입력해 주세요.">
        <div class="form-grid">
            <input type="number" id="totalPrice" name="totalPrice" placeholder="상품 금액" required min="0" max="100000000" title="상품 금액은 0원 이상 입력해 주세요.">
            <input type="number" id="totalDeli" name="totalDeli" placeholder="배송비 합계" required min="0" max="10000000" title="배송비는 0원 이상 입력해 주세요.">
            <input type="number" id="totalPay" name="totalPay" placeholder="최종 결제 금액" required min="0" max="100000000" title="최종 결제 금액은 0원 이상 입력해 주세요.">
        </div>
        <button type="submit">결제 완료</button>
    </form>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function openPostcode(zipId, addr1Id, addr2Id) {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById(zipId).value = data.zonecode;
                document.getElementById(addr1Id).value = data.roadAddress || data.jibunAddress;
                document.getElementById(addr2Id).focus();
            }
        }).open();
    }

    (function() {
        var form = document.getElementById("checkoutForm");
        var totalPrice = document.getElementById("totalPrice");
        var totalDeli = document.getElementById("totalDeli");
        var totalPay = document.getElementById("totalPay");

        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                form.reportValidity();
                return;
            }

            var expected = Number(totalPrice.value || 0) + Number(totalDeli.value || 0);
            if (Number(totalPay.value || 0) !== expected) {
                event.preventDefault();
                totalPay.setCustomValidity("최종 결제 금액은 상품 금액과 배송비 합계와 같아야 합니다.");
                totalPay.reportValidity();
                totalPay.focus();
                totalPay.setCustomValidity("");
            }
        });
    })();
</script>
<%@ include file="../include/footer.jsp" %>
