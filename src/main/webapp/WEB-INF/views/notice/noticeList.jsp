<%-- 공지사항 목록 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <div class="section-head">
        <h2>공지사항</h2>
    </div>

    <table class="table board-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${noticePage.items}">
            <tr>
                <td>${item.QNum}</td>
                <td><a href="/notices/${item.QNum}">${item.QTitle}</a></td>
                <td>${item.QUid}</td>
                <td>${fn:substring(item.QRegDate, 0, 10)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${noticePage.hasPrevious}">
            <a href="/notices?page=${noticePage.startPage - 1}">이전</a>
        </c:if>
        <c:forEach begin="${noticePage.startPage}" end="${noticePage.endPage}" var="pageNum">
            <a class="${pageNum == noticePage.currentPage ? 'active' : ''}" href="/notices?page=${pageNum}">${pageNum}</a>
        </c:forEach>
        <c:if test="${noticePage.hasNext}">
            <a href="/notices?page=${noticePage.endPage + 1}">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>

