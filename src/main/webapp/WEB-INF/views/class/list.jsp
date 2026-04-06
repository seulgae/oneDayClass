<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>클래스</h2><a class="btn" href="/classes/new">새 클래스 등록</a></div>
    <form class="toolbar" method="get" action="/classes">
        <input type="text" name="category" value="${selectedCategory}" placeholder="카테고리">
        <select name="onoff">
            <option value="">전체</option>
            <option value="N" ${selectedOnOff eq 'N' ? 'selected' : ''}>온라인</option>
            <option value="Y" ${selectedOnOff eq 'Y' ? 'selected' : ''}>오프라인</option>
        </select>
        <button type="submit">검색</button>
    </form>
    <div class="card-grid">
        <c:forEach var="item" items="${classPage.items}">
            <a class="card" href="/classes/${item.CNum}">
                <c:if test="${not empty item.CThumbName}">
                    <img class="card-thumb" src="/uploads/classes/${item.CThumbName}" alt="${item.CTitle}">
                </c:if>
                <strong>${item.CTitle}</strong>
                <span>${item.CTeacher}</span>
                <span>${item.CCategory} / ${item.CPrice}원 / 좋아요 ${item.CLikes}</span>
            </a>
        </c:forEach>
    </div>
    <div class="pagination">
        <c:if test="${classPage.hasPrevious}">
            <a href="/classes?page=${classPage.startPage - 1}&category=${selectedCategory}&onoff=${selectedOnOff}">이전</a>
        </c:if>
        <c:forEach begin="${classPage.startPage}" end="${classPage.endPage}" var="pageNum">
            <a class="${pageNum == classPage.currentPage ? 'active' : ''}" href="/classes?page=${pageNum}&category=${selectedCategory}&onoff=${selectedOnOff}">${pageNum}</a>
        </c:forEach>
        <c:if test="${classPage.hasNext}">
            <a href="/classes?page=${classPage.endPage + 1}&category=${selectedCategory}&onoff=${selectedOnOff}">다음</a>
        </c:if>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
