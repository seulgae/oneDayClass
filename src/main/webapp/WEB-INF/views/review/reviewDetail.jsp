<%-- 후기 상세 화면 --%>
<%--@elvariable id="review" type="com.example.onedayclass.review.dto.ReviewDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head"><h2>${review.RTitle}</h2><a class="btn secondary" href="<c:url value='/reviews' />">목록으로</a></div>
    <dl>
        <dt>클래스</dt>
        <dd>
            <c:choose>
                <c:when test="${not empty review.CTitle}">
                    <a href="<c:url value='/classes/${review.CNum}' />">${review.CTitle}</a>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </dd>
    </dl>
    <dl><dt>작성자</dt><dd>${review.RUid}</dd></dl>
    <dl><dt>통계</dt><dd>조회 ${review.RCnt} / 좋아요 ${review.RLikes}</dd></dl>
    <dl><dt>내용</dt><dd>${review.RContent}</dd></dl>
    <div class="actions">
        <form method="post" action="<c:url value='/reviews/${review.RNum}/like' />" class="inline-form"><button type="submit">좋아요</button></form>
        <c:if test="${loginMember != null and (loginMember.UId eq review.RUid or loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <form method="post" action="<c:url value='/reviews/${review.RNum}/delete' />" class="inline-form">
                <button type="submit">삭제</button>
            </form>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

