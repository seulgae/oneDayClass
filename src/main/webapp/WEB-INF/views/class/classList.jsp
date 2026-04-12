<%-- 클래스 목록 화면 --%>
<%--@elvariable id="classPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%--@elvariable id="selectedKeyField" type="java.lang.String"--%>
<%--@elvariable id="keyword" type="java.lang.String"--%>
<%--@elvariable id="selectedOnOff" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="클래스" />
    <c:url var="toolbarAction" value="/classes" />
    <c:set var="toolbarScope" value="class" />
    <c:url var="toolbarButtonHref" value="/classes/new" />
    <c:set var="toolbarButtonLabel" value="클래스 등록" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <div class="card-grid">
        <c:forEach var="item" items="${classPage.items}">
            <a class="card" href="<c:url value='/classes/${item.CNum}' />">
                <c:if test="${not empty item.CThumbName}">
                    <img class="card-thumb" src="<c:url value='/uploads/classes/${item.CThumbName}' />" alt="${item.CTitle}">
                </c:if>
                <strong>${item.CTitle}</strong>
                <span>${item.CTeacher}</span>
                <span>${item.CCategory} / ${item.CPrice}원 / 좋아요 ${item.CLikes}</span>
            </a>
        </c:forEach>
    </div>

    <div class="pagination">
        <c:if test="${classPage.hasPrevious}">
            <a href="<c:url value='/classes?page=${classPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />">이전</a>
        </c:if>
        <c:forEach begin="${classPage.startPage}" end="${classPage.endPage}" var="pageNum">
            <a class="${pageNum == classPage.currentPage ? 'active' : ''}" href="<c:url value='/classes?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${classPage.hasNext}">
            <a href="<c:url value='/classes?page=${classPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />">다음</a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>


