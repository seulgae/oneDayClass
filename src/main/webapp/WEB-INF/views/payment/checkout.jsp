<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Checkout</h2>
    <form method="post" action="/payments/checkout">
        <div class="form-grid">
            <input type="text" name="rName" placeholder="Receiver" required>
            <input type="text" name="rPhone" placeholder="Phone" required>
            <input type="text" name="rZip" placeholder="Zip">
            <input type="email" name="rEmail" placeholder="Email">
        </div>
        <input type="text" name="rAddr1" placeholder="Address 1">
        <input type="text" name="rAddr2" placeholder="Address 2">
        <div class="form-grid">
            <input type="number" name="totalPrice" placeholder="Item total" required>
            <input type="number" name="totalDeli" placeholder="Delivery total" required>
            <input type="number" name="totalPay" placeholder="Grand total" required>
        </div>
        <button type="submit">Complete payment</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
