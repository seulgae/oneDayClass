<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="two-column">
    <article class="panel">
        <h2>내 결제내역</h2>
        <c:forEach var="item" items="${studentPayments}">
                <div class="list-link">${item.CTitle}<em>${fn:substring(item.payDate, 0, 10)} / ${item.CPrice}</em></div>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>판매내역</h2>
        <c:forEach var="item" items="${teacherPayments}">
            <div class="list-link">${item.CTitle}<em>${item.UId} / ${item.REmail}</em></div>
        </c:forEach>
    </article>
</section>
<%@ include file="../include/footer.jsp" %>
