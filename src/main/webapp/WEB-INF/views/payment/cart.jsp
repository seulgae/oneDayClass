<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>Cart</h2><a class="btn" href="/payments/checkout">Checkout</a></div>
    <table class="table">
        <thead><tr><th>Class</th><th>Price</th><th>Delivery</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.CTitle}</td>
                <td>${item.CPrice}</td>
                <td>${item.CDelivery}</td>
                <td>
                    <form method="post" action="/payments/cart/${item.CNum}/delete" class="inline-form">
                        <button type="submit">Remove</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<jsp:include page="../include/footer.jsp" />
