<%-- 등업 신청 목록 화면 --%>
<%--@elvariable id="requestPage" type="com.example.onedayclass.common.paging.PageResult"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <div class="section-head">
        <div>
            <h2><i class="ri-award-line"></i> 강사 등업 요청 게시판</h2>
            <p class="section-subtitle">나만의 원데이 클래스를 개설하기 위해 강사(레벨 2) 권한을 신청하는 공간입니다.</p>
        </div>
        <a class="btn" href="<c:url value='/levelups/new' />"><i class="ri-add-circle-line"></i> 등업 신청하기</a>
    </div>
    <table class="table board-table">
        <thead>
        <tr>
            <th style="width:90px;">번호</th>
            <th>신청 제목</th>
            <th style="width:150px;">작성자</th>
            <th style="width:120px;">심사 상태</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${requestPage.items}">
            <tr>
                <td class="muted">#${item.lvlNum}</td>
                <td><a href="<c:url value='/levelups/${item.lvlNum}' />">${item.lvlTitle}</a></td>
                <td>${item.lvlUid}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.lvlStatus eq '승인' or item.lvlStatus eq '2'}"><span class="status-badge is-ok">승인완료</span></c:when>
                        <c:otherwise><span class="status-badge is-warn">${empty item.lvlStatus ? '심사대기' : item.lvlStatus}</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <c:if test="${requestPage.hasPrevious}">
            <a href="<c:url value='/levelups?page=${requestPage.startPage - 1}' />"><i class="ri-arrow-left-s-line"></i> 이전</a>
        </c:if>
        <c:forEach begin="${requestPage.startPage}" end="${requestPage.endPage}" var="pageNum">
            <a class="${pageNum == requestPage.currentPage ? 'active' : ''}" href="<c:url value='/levelups?page=${pageNum}' />">${pageNum}</a>
        </c:forEach>
        <c:if test="${requestPage.hasNext}">
            <a href="<c:url value='/levelups?page=${requestPage.endPage + 1}' />">다음 <i class="ri-arrow-right-s-line"></i></a>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
