<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>寃곗젣?뺣낫 ?낅젰</h2>
    <form method="post" action="/payments/checkout" id="checkoutForm">
        <div class="form-grid">
            <input type="text" name="rName" placeholder="諛쏅뒗 遺??대쫫" required minlength="2" maxlength="30" pattern="^[媛-?즑-zA-Z\\s]{2,30}$" title="?대쫫? 2~30???대궡濡??낅젰??二쇱꽭??">
            <input type="text" name="rPhone" placeholder="諛쏅뒗 遺??곕씫泥?" required maxlength="13" pattern="^01[0-9]-?\\d{3,4}-?\\d{4}$" title="?대???踰덊샇 ?뺤떇???щ컮瑜댁? ?딆뒿?덈떎.">
            <div class="zip-field">
                <input type="text" id="rZip" name="rZip" placeholder="?고렪踰덊샇" required maxlength="10" readonly>
                <button type="button" class="btn secondary" onclick="openPostcode('rZip', 'rAddr1', 'rAddr2')">二쇱냼李얘린</button>
            </div>
            <input type="email" name="rEmail" placeholder="?대찓??" required maxlength="100" title="?대찓???뺤떇???щ컮瑜댁? ?딆뒿?덈떎.">
        </div>
        <input type="text" id="rAddr1" name="rAddr1" placeholder="湲곕낯二쇱냼" required maxlength="120" readonly>
        <input type="text" id="rAddr2" name="rAddr2" placeholder="?곸꽭二쇱냼" required minlength="2" maxlength="120" title="?곸꽭二쇱냼瑜??낅젰??二쇱꽭??">
        <div class="form-grid">
            <input type="number" id="totalPrice" name="totalPrice" placeholder="?곹뭹 湲덉븸" required min="0" max="100000000" title="?곹뭹 湲덉븸? 0???댁긽 ?낅젰??二쇱꽭??">
            <input type="number" id="totalDeli" name="totalDeli" placeholder="諛곗넚鍮??⑷퀎" required min="0" max="10000000" title="諛곗넚鍮꾨뒗 0???댁긽 ?낅젰??二쇱꽭??">
            <input type="number" id="totalPay" name="totalPay" placeholder="理쒖쥌 寃곗젣 湲덉븸" required min="0" max="100000000" title="理쒖쥌 寃곗젣 湲덉븸? 0???댁긽 ?낅젰??二쇱꽭??">
        </div>
        <button type="submit">寃곗젣 ?꾨즺</button>
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
                totalPay.setCustomValidity("理쒖쥌 寃곗젣 湲덉븸? ?곹뭹 湲덉븸怨?諛곗넚鍮??⑷퀎? 媛숈븘???⑸땲??");
                totalPay.reportValidity();
                totalPay.focus();
                totalPay.setCustomValidity("");
            }
        });
    })();
</script>
<%@ include file="../include/footer.jsp" %>
