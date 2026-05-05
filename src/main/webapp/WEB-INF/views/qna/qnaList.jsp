<%-- QnA 목록 화면 --%>
<%--@elvariable id="questionPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%--@elvariable id="selectedKeyField" type="java.lang.String"--%>
<%--@elvariable id="keyword" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="문의 QnA" />
    <c:url var="toolbarAction" value="/qna" />
    <c:set var="toolbarScope" value="qna" />
    <c:url var="toolbarButtonHref" value="/classes" />
    <c:set var="toolbarButtonLabel" value="문의할 클래스 찾기" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <table class="table board-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>분류</th>
            <th>제목</th>
            <th>작성자</th>
            <th>상태</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${questionPage.items}">
            <tr>
                <td>${item.QNum}</td>
                <td>${empty item.QCategory ? '기타' : item.QCategory}</td>
                <td><a href="<c:url value='/qna/${item.QNum}' />">${item.QTitle}</a></td>
                <td>${item.QUid}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.QStatus eq 3}">삭제</c:when>
                        <c:when test="${item.QRef ge 9000}">공지</c:when>
                        <c:otherwise>문의</c:otherwise>
                    </c:choose>
                </td>
                <td>${fn:substring(item.QRegDate, 0, 10)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${questionPage.hasPrevious}">
            <a href="<c:url value='/qna?page=${questionPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}' />">이전</a>
        </c:if>
        <c:forEach begin="${questionPage.startPage}" end="${questionPage.endPage}" var="pageNum">
            <a class="${pageNum == questionPage.currentPage ? 'active' : ''}" href="<c:url value='/qna?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${questionPage.hasNext}">
            <a href="<c:url value='/qna?page=${questionPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}' />">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

