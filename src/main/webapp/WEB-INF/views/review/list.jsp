<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>Review Board</h2><a class="btn" href="/reviews/new">New review</a></div>
    <div class="card-grid">
        <c:forEach var="item" items="${reviews}">
            <a class="card" href="/reviews/${item.RNum}">
                <strong>${item.RTitle}</strong>
                <span>${item.RUid}</span>
                <span>read ${item.RCnt} / likes ${item.RLikes}</span>
            </a>
        </c:forEach>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
