<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="사용자 후기" />
    <c:set var="toolbarAction" value="/reviews" />
    <c:set var="toolbarScope" value="review" />
    <c:set var="toolbarButtonHref" value="/reviews/new" />
    <c:set var="toolbarButtonLabel" value="후기 작성" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <table class="table board-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회/추천</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${reviewPage.items}">
            <tr>
                <td>${item.RNum}</td>
                <td><a href="/reviews/${item.RNum}">${item.RTitle}</a></td>
                <td>${item.RUid}</td>
                <td>조회 ${item.RCnt} / 좋아요 ${item.RLikes}</td>
                <td>${item.RRegDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${reviewPage.hasPrevious}">
            <a href="/reviews?page=${reviewPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}">이전</a>
        </c:if>
        <c:forEach begin="${reviewPage.startPage}" end="${reviewPage.endPage}" var="pageNum">
            <a class="${pageNum == reviewPage.currentPage ? 'active' : ''}" href="/reviews?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}">${pageNum}</a>
        </c:forEach>
        <c:if test="${reviewPage.hasNext}">
            <a href="/reviews?page=${reviewPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>
