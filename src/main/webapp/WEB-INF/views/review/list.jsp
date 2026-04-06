<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>후기 게시판</h2><a class="btn" href="/reviews/new">후기 작성</a></div>
    <div class="card-grid">
        <c:forEach var="item" items="${reviewPage.items}">
            <a class="card" href="/reviews/${item.RNum}">
                <strong>${item.RTitle}</strong>
                <span>${item.RUid}</span>
                <span>조회 ${item.RCnt} / 좋아요 ${item.RLikes}</span>
            </a>
        </c:forEach>
    </div>
    <div class="pagination">
        <c:if test="${reviewPage.hasPrevious}">
            <a href="/reviews?page=${reviewPage.startPage - 1}">이전</a>
        </c:if>
        <c:forEach begin="${reviewPage.startPage}" end="${reviewPage.endPage}" var="pageNum">
            <a class="${pageNum == reviewPage.currentPage ? 'active' : ''}" href="/reviews?page=${pageNum}">${pageNum}</a>
        </c:forEach>
        <c:if test="${reviewPage.hasNext}">
            <a href="/reviews?page=${reviewPage.endPage + 1}">다음</a>
        </c:if>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
