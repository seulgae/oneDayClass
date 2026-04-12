<%-- 등업 신청 목록 화면 --%>
<%--@elvariable id="requestPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <div class="section-head">
        <h2>등업 요청 게시판</h2>
        <a class="btn" href="<c:url value='/levelups/new' />">요청하기</a>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>상태</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${requestPage.items}">
            <tr>
                <td>${item.lvlNum}</td>
                <td><a href="<c:url value='/levelups/${item.lvlNum}' />">${item.lvlTitle}</a></td>
                <td>${item.lvlUid}</td>
                <td>${item.lvlStatus}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <c:if test="${requestPage.hasPrevious}">
            <a href="<c:url value='/levelups?page=${requestPage.startPage - 1}' />">이전</a>
        </c:if>
        <c:forEach begin="${requestPage.startPage}" end="${requestPage.endPage}" var="pageNum">
            <a class="${pageNum == requestPage.currentPage ? 'active' : ''}" href="<c:url value='/levelups?page=${pageNum}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${requestPage.hasNext}">
            <a href="<c:url value='/levelups?page=${requestPage.endPage + 1}' />">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

