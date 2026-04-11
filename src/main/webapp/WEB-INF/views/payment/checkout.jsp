<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<c:set var="totalPriceValue" value="0" />
<c:set var="totalDeliValue" value="0" />
<c:forEach var="item" items="${cartItems}">
    <c:set var="totalPriceValue" value="${totalPriceValue + item.CPrice}" />
    <c:set var="totalDeliValue" value="${totalDeliValue + item.CDelivery}" />
</c:forEach>
<c:set var="totalPayValue" value="${totalPriceValue + totalDeliValue}" />
<section class="form-panel checkout-panel">
    <div class="member-form-hero">
        <h2>결제 정보 입력</h2>
        <p>배송 정보만 입력하면 장바구니 기준으로 결제 금액이 자동 계산됩니다.</p>
    </div>
    <form method="post" action="/payments/checkout" id="checkoutForm">
        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>받는 사람 정보</h3>
                    <p class="section-copy">연락 가능한 휴대폰 번호와 배송지를 정확하게 입력해 주세요.</p>
                </div>
                <span class="required-guide"><span class="required-mark">*</span> 필수 입력</span>
            </div>
            <div class="field-grid two-column-grid">
                <label class="field-block">
                    <span class="field-label">받는 분 이름 <span class="required-mark">*</span></span>
                    <input type="text" name="rName" placeholder="예: 김태형" required minlength="2" maxlength="30" pattern="^[가-힣a-zA-Z\s]{2,30}$" title="이름은 2~30자 이내로 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">휴대폰 번호 <span class="required-mark">*</span></span>
                    <input type="text" id="rPhone" name="rPhone" placeholder="010-1234-5678" required maxlength="13" inputmode="numeric" pattern="^01[0-9]-?\d{3,4}-?\d{4}$" title="휴대폰 번호 형식이 올바르지 않습니다.">
                </label>
                <label class="field-block">
                    <span class="field-label">우편번호 <span class="required-mark">*</span></span>
                    <div class="zip-field">
                        <input type="text" id="rZip" name="rZip" placeholder="우편번호" required maxlength="10" readonly>
                        <button type="button" class="btn secondary" onclick="openPostcode('rZip', 'rAddr1', 'rAddr2')">주소찾기</button>
                    </div>
                </label>
                <label class="field-block">
                    <span class="field-label">이메일 <span class="required-mark">*</span></span>
                    <input type="email" name="rEmail" placeholder="name@example.com" required maxlength="100" title="이메일 형식이 올바르지 않습니다.">
                </label>
            </div>
            <div class="field-grid">
                <label class="field-block">
                    <span class="field-label">기본주소 <span class="required-mark">*</span></span>
                    <input type="text" id="rAddr1" name="rAddr1" placeholder="주소찾기 버튼으로 기본주소를 입력해 주세요." required maxlength="120" readonly>
                </label>
                <label class="field-block">
                    <span class="field-label">상세주소 <span class="required-mark">*</span></span>
                    <input type="text" id="rAddr2" name="rAddr2" placeholder="예: 101동 601호" required minlength="2" maxlength="120" title="상세주소를 입력해 주세요.">
                </label>
            </div>
        </section>

        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>결제 요약</h3>
                    <p class="section-copy">장바구니에 담긴 상품 기준으로 자동 계산된 금액입니다.</p>
                </div>
            </div>
            <c:if test="${not empty cartItems}">
                <div class="checkout-summary-list">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="checkout-summary-item">
                            <strong>${item.CTitle}</strong>
                            <span>상품 ${item.CPrice}원</span>
                            <span>배송비 ${item.CDelivery}원</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <div class="field-grid three-column-grid">
                <label class="field-block">
                    <span class="field-label">결제 금액</span>
                    <input type="number" id="totalPrice" name="totalPrice" required min="0" max="100000000" title="상품 금액은 0 이상 입력해 주세요." value="${totalPriceValue}" readonly>
                </label>
                <label class="field-block">
                    <span class="field-label">배송비</span>
                    <input type="number" id="totalDeli" name="totalDeli" required min="0" max="10000000" title="배송비는 0 이상 입력해 주세요." value="${totalDeliValue}" readonly>
                </label>
                <label class="field-block checkout-total-field">
                    <span class="field-label">총 결제금액</span>
                    <input type="number" id="totalPay" name="totalPay" required min="0" max="100000000" title="최종 결제 금액은 0 이상 입력해 주세요." value="${totalPayValue}" readonly>
                </label>
            </div>
        </section>
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
        var phone = document.getElementById("rPhone");
        var totalPrice = document.getElementById("totalPrice");
        var totalDeli = document.getElementById("totalDeli");
        var totalPay = document.getElementById("totalPay");

        function syncTotals() {
            var price = Number(totalPrice.value || 0);
            var deli = Number(totalDeli.value || 0);
            totalPay.value = price + deli;
            totalPay.setCustomValidity("");
        }

        function formatPhone(value) {
            var digits = value.replace(/\D/g, "").slice(0, 11);

            if (digits.length < 4) {
                return digits;
            }

            if (digits.length < 8) {
                return digits.slice(0, 3) + "-" + digits.slice(3);
            }

            if (digits.length < 11) {
                return digits.slice(0, 3) + "-" + digits.slice(3, 6) + "-" + digits.slice(6);
            }

            return digits.slice(0, 3) + "-" + digits.slice(3, 7) + "-" + digits.slice(7);
        }

        function validatePhone() {
            var formatted = formatPhone(phone.value);
            phone.value = formatted;

            if (!formatted) {
                phone.setCustomValidity("");
                return;
            }

            if (!/^01[0-9]-\d{3,4}-\d{4}$/.test(formatted)) {
                phone.setCustomValidity("휴대폰 번호 형식이 올바르지 않습니다.");
                return;
            }

            phone.setCustomValidity("");
        }

        phone.addEventListener("input", validatePhone);
        phone.addEventListener("blur", validatePhone);
        syncTotals();

        form.addEventListener("submit", function(event) {
            validatePhone();
            syncTotals();

            if (!form.checkValidity()) {
                event.preventDefault();
                form.reportValidity();
                return;
            }
        });
    })();
</script>
<%@ include file="../include/footer.jsp" %>
