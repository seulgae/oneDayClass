<%-- 요청 게시판 목록 화면 --%>
<%--@elvariable id="requestPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%--@elvariable id="selectedKeyField" type="java.lang.String"--%>
<%--@elvariable id="keyword" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="요청게시판" />
    <c:url var="toolbarAction" value="/requests" />
    <c:set var="toolbarScope" value="request" />
    <c:url var="toolbarButtonHref" value="/requests/new" />
    <c:set var="toolbarButtonLabel" value="요청 올리기" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <p class="board-guide"><i class="ri-lightbulb-flash-line" style="font-size:18px;"></i> 배우고 싶은 원데이 클래스나 플랫폼 개선 아이디어가 있다면 편하게 올려 주세요. 강사님과 운영자가 확인 후 답변을 드립니다.</p>

    <table class="table board-table">
        <thead>
        <tr>
            <th style="width:80px;">번호</th>
            <th>제목</th>
            <th style="width:140px;">작성자</th>
            <th style="width:110px;">상태</th>
            <th style="width:130px;">작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${requestPage.items}">
            <tr>
                <td class="muted">#${item.reqNum}</td>
                <td><a href="<c:url value='/requests/${item.reqNum}' />">${item.reqTitle}</a></td>
                <td>${item.reqUid}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.reqStatus eq 3}"><span class="status-badge is-danger">삭제</span></c:when>
                        <c:otherwise><span class="status-badge is-ok">접수</span></c:otherwise>
                    </c:choose>
                </td>
                <td class="muted">${fn:substring(item.reqRegDate, 0, 10)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${requestPage.hasPrevious}">
            <a href="<c:url value='/requests?page=${requestPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}' />"><i class="ri-arrow-left-s-line"></i> 이전</a>
        </c:if>
        <c:forEach begin="${requestPage.startPage}" end="${requestPage.endPage}" var="pageNum">
            <a class="${pageNum == requestPage.currentPage ? 'active' : ''}" href="<c:url value='/requests?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${requestPage.hasNext}">
            <a href="<c:url value='/requests?page=${requestPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}' />">다음 <i class="ri-arrow-right-s-line"></i></a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
