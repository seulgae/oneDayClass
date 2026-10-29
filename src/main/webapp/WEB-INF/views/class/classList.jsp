<%-- 클래스 목록 화면 --%>
<%--@elvariable id="classPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%--@elvariable id="selectedKeyField" type="java.lang.String"--%>
<%--@elvariable id="keyword" type="java.lang.String"--%>
<%--@elvariable id="selectedOnOff" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:set var="toolbarTitle" value="클래스 탐색" />
    <c:url var="toolbarAction" value="/classes" />
    <c:set var="toolbarScope" value="class" />
    <c:if test="${loginMember != null and loginMember.ULevel eq '2'}">
        <c:url var="toolbarButtonHref" value="/classes/new" />
        <c:set var="toolbarButtonLabel" value="새 클래스 등록" />
    </c:if>
    <%@ include file="../include/list-toolbar.jspf" %>

    <div class="quick-categories" style="margin-top:0; margin-bottom:24px;">
        <a class="category-chip ${empty selectedOnOff ? 'is-active' : ''}" href="<c:url value='/classes?keyField=${selectedKeyField}&keyword=${keyword}' />"><i class="ri-apps-line"></i> 전체 보기</a>
        <a class="category-chip ${selectedOnOff eq 'N' ? 'is-active' : ''}" href="<c:url value='/classes?onoff=N&keyField=${selectedKeyField}&keyword=${keyword}' />"><i class="ri-vidicon-line"></i> 온라인 클래스</a>
        <a class="category-chip ${selectedOnOff eq 'Y' ? 'is-active' : ''}" href="<c:url value='/classes?onoff=Y&keyField=${selectedKeyField}&keyword=${keyword}' />"><i class="ri-map-pin-user-line"></i> 오프라인 공방</a>
    </div>

    <div class="card-grid">
        <c:forEach var="item" items="${classPage.items}">
            <c:set var="thumbImageName" value="${empty item.CThumbName ? 'default-class-thumb.svg' : item.CThumbName}" />
            <a class="card" href="<c:url value='/classes/${item.CNum}' />">
                <div class="card-thumb-wrap">
                    <img class="card-thumb" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="${item.CTitle}">
                </div>
                <div class="card-badges">
                    <c:choose>
                        <c:when test="${item.COnoff eq 'Y'}">
                            <span class="badge badge-primary"><i class="ri-map-pin-2-line"></i> ${empty item.CArea ? '오프라인' : item.CArea}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-indigo"><i class="ri-vidicon-line"></i> 온라인</span>
                        </c:otherwise>
                    </c:choose>
                    <span class="badge badge-slate">${item.CCategory}</span>
                </div>
                <strong>${item.CTitle}</strong>
                <span><i class="ri-user-star-line"></i> ${item.CTeacher}</span>
                <div class="card-price-row">
                    <span class="card-price"><fmt:formatNumber value="${item.CPrice}" />원</span>
                    <span class="card-likes"><i class="ri-heart-3-fill"></i> ${item.CLikes}</span>
                </div>
            </a>
        </c:forEach>
    </div>

    <div class="pagination">
        <c:if test="${classPage.hasPrevious}">
            <a href="<c:url value='/classes?page=${classPage.startPage - 1}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />"><i class="ri-arrow-left-s-line"></i> 이전</a>
        </c:if>
        <c:forEach begin="${classPage.startPage}" end="${classPage.endPage}" var="pageNum">
            <a class="${pageNum == classPage.currentPage ? 'active' : ''}" href="<c:url value='/classes?page=${pageNum}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${classPage.hasNext}">
            <a href="<c:url value='/classes?page=${classPage.endPage + 1}&keyField=${selectedKeyField}&keyword=${keyword}&onoff=${selectedOnOff}' />">다음 <i class="ri-arrow-right-s-line"></i></a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
