<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>후기 게시판</h2><a class="btn" href="/reviews/new">후기 작성</a></div>
    <div class="card-grid">
        <c:forEach var="item" items="${reviews}">
            <a class="card" href="/reviews/${item.RNum}">
                <strong>${item.RTitle}</strong>
                <span>${item.RUid}</span>
                <span>조회 ${item.RCnt} / 좋아요 ${item.RLikes}</span>
            </a>
        </c:forEach>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
