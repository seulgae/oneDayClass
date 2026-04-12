<%-- 장바구니 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <div class="section-head"><h2>장바구니</h2><a class="btn" href="/payments/checkout">결제하기</a></div>
    <table class="table">
        <thead><tr><th>클래스</th><th>가격</th><th>배송비</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.CTitle}</td>
                <td>${item.CPrice}</td>
                <td>${item.CDelivery}</td>
                <td>
                    <form method="post" action="/payments/cart/${item.CNum}/delete" class="inline-form">
                        <button type="submit">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<%@ include file="../include/footer.jsp" %>

