<%-- 결제 내역 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="two-column">
    <article class="panel">
        <h2>내 결제 내역</h2>
        <c:forEach var="item" items="${studentPayments}">
            <a class="list-link" href="/payments/history/${item.PNum}">
                ${item.CTitle}<em>${fn:substring(item.payDate, 0, 10)} / ${item.CPrice}원</em>
            </a>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>판매 내역</h2>
        <c:forEach var="item" items="${teacherPayments}">
            <a class="list-link" href="/payments/history/${item.PNum}">
                ${item.CTitle}<em>${item.UId} / ${item.REmail}</em>
            </a>
        </c:forEach>
    </article>
</section>
<%@ include file="../include/footer.jsp" %>

