<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="요청게시판" />
    <c:set var="toolbarAction" value="/requests" />
    <c:set var="toolbarScope" value="request" />
    <c:set var="toolbarButtonHref" value="/requests/new" />
    <c:set var="toolbarButtonLabel" value="요청 올리기" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <p class="board-guide">필요한 기능이나 개선 아이디어가 있다면 편하게 올려 주세요. 운영자가 확인 후 답변 또는 반영 안내를 드립니다.</p>

    <table class="table board-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>상태</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${requestPage.items}">
            <tr>
                <td>${item.reqNum}</td>
                <td><a href="/requests/${item.reqNum}">${item.reqTitle}</a></td>
                <td>${item.reqUid}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.reqStatus eq 3}">삭제</c:when>
                        <c:otherwise>접수</c:otherwise>
                    </c:choose>
                </td>
                <td>${fn:substring(item.reqRegDate, 0, 10)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${requestPage.hasPrevious}">
            <a href="/requests?page=${requestPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}">이전</a>
        </c:if>
        <c:forEach begin="${requestPage.startPage}" end="${requestPage.endPage}" var="pageNum">
            <a class="${pageNum == requestPage.currentPage ? 'active' : ''}" href="/requests?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}">${pageNum}</a>
        </c:forEach>
        <c:if test="${requestPage.hasNext}">
            <a href="/requests?page=${requestPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>
