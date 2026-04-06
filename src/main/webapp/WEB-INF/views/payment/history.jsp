<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="two-column">
    <article class="panel">
        <h2>내 결제내역</h2>
        <c:forEach var="item" items="${studentPayments}">
            <div class="list-link">${item.CTitle}<em>${item.payDate} / ${item.CPrice}</em></div>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>판매내역</h2>
        <c:forEach var="item" items="${teacherPayments}">
            <div class="list-link">${item.CTitle}<em>${item.UId} / ${item.REmail}</em></div>
        </c:forEach>
    </article>
</section>
<jsp:include page="../include/footer.jsp" />
