<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>QnA 게시판</h2><a class="btn" href="/qna/new">문의하기</a></div>
    <form class="toolbar" method="get" action="/qna">
        <select name="keyField">
            <option value="qTitle" ${selectedKeyField eq 'qTitle' ? 'selected' : ''}>제목</option>
            <option value="qUid" ${selectedKeyField eq 'qUid' ? 'selected' : ''}>작성자</option>
            <option value="qContent" ${selectedKeyField eq 'qContent' ? 'selected' : ''}>내용</option>
        </select>
        <input type="text" name="keyword" value="${keyword}" placeholder="검색어">
        <button type="submit">검색</button>
    </form>
    <table class="table">
        <thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>상태</th><th>작성일</th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${questionPage.items}">
            <tr>
                <td>${item.QNum}</td>
                <td><a href="/qna/${item.QNum}">${item.QTitle}</a></td>
                <td>${item.QUid}</td>
                <td>${item.QStatus}</td>
                <td>${item.QRegDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <c:if test="${questionPage.hasPrevious}">
            <a href="/qna?page=${questionPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}">이전</a>
        </c:if>
        <c:forEach begin="${questionPage.startPage}" end="${questionPage.endPage}" var="pageNum">
            <a class="${pageNum == questionPage.currentPage ? 'active' : ''}" href="/qna?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}">${pageNum}</a>
        </c:forEach>
        <c:if test="${questionPage.hasNext}">
            <a href="/qna?page=${questionPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}">다음</a>
        </c:if>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
