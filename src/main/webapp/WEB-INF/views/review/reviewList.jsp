<%-- 후기 목록 화면 --%>
<%--@elvariable id="reviewPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%--@elvariable id="selectedKeyField" type="java.lang.String"--%>
<%--@elvariable id="keyword" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="수강생 후기" />
    <c:url var="toolbarAction" value="/reviews" />
    <c:set var="toolbarScope" value="review" />
    <c:choose>
        <c:when test="${loginMember != null}">
            <c:url var="toolbarButtonHref" value="/classes" />
        </c:when>
        <c:otherwise>
            <c:url var="toolbarButtonHref" value="/members/login" />
        </c:otherwise>
    </c:choose>
    <c:set var="toolbarButtonLabel" value="후기 작성할 클래스 찾기" />
    <%@ include file="../include/list-toolbar.jspf" %>

    <table class="table board-table">
        <thead>
        <tr>
            <th style="width:80px;">번호</th>
            <th>후기 제목</th>
            <th>수강 클래스</th>
            <th style="width:120px;">작성자</th>
            <th style="width:160px;">조회 / 추천</th>
            <th style="width:120px;">작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${reviewPage.items}">
            <tr>
                <td class="muted">#${item.RNum}</td>
                <td><a href="<c:url value='/reviews/${item.RNum}' />">${item.RTitle}</a></td>
                <td>
                    <c:choose>
                        <c:when test="${not empty item.CTitle}">
                            <a href="<c:url value='/classes/${item.CNum}' />" class="badge badge-indigo"><i class="ri-book-open-line"></i> ${item.CTitle}</a>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${item.RUid}</td>
                <td><span class="muted"><i class="ri-eye-line"></i> ${item.RCnt}</span> &middot; <span style="color:var(--primary); font-weight:600;"><i class="ri-heart-3-fill"></i> ${item.RLikes}</span></td>
                <td class="muted">${fn:substring(item.RRegDate, 0, 10)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${reviewPage.hasPrevious}">
            <a href="<c:url value='/reviews?page=${reviewPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}' />"><i class="ri-arrow-left-s-line"></i> 이전</a>
        </c:if>
        <c:forEach begin="${reviewPage.startPage}" end="${reviewPage.endPage}" var="pageNum">
            <a class="${pageNum == reviewPage.currentPage ? 'active' : ''}" href="<c:url value='/reviews?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${reviewPage.hasNext}">
            <a href="<c:url value='/reviews?page=${reviewPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}' />">다음 <i class="ri-arrow-right-s-line"></i></a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
