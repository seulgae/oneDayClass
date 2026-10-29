<%-- 후기 상세 화면 --%>
<%--@elvariable id="review" type="com.example.onedayclass.review.dto.ReviewDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <div>
            <span class="badge badge-primary" style="margin-bottom:8px;"><i class="ri-star-smile-line"></i> 수강생 리얼 후기</span>
            <h2>${review.RTitle}</h2>
        </div>
        <a class="btn secondary" href="<c:url value='/reviews' />"><i class="ri-list-check"></i> 목록으로</a>
    </div>
    <dl>
        <dt><i class="ri-book-open-line"></i> 수강 클래스</dt>
        <dd>
            <c:choose>
                <c:when test="${not empty review.CTitle}">
                    <a href="<c:url value='/classes/${review.CNum}' />">${review.CTitle}</a>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </dd>
    </dl>
    <dl><dt><i class="ri-user-line"></i> 작성자</dt><dd>${review.RUid}</dd></dl>
    <dl><dt><i class="ri-bar-chart-line"></i> 조회 및 추천</dt><dd>조회 ${review.RCnt}회 &middot; <strong style="color:var(--primary);">좋아요 ${review.RLikes}</strong></dd></dl>
    <dl><dt><i class="ri-file-text-line"></i> 후기 내용</dt><dd><div class="content-body-box">${review.RContent}</div></dd></dl>
    <div class="actions" style="margin-top:8px;">
        <form method="post" action="<c:url value='/reviews/${review.RNum}/like' />" class="inline-form">
            <button type="submit"><i class="ri-heart-3-fill"></i> 도움이 됐어요 (좋아요)</button>
        </form>
        <c:if test="${loginMember != null and (loginMember.UId eq review.RUid or loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <form method="post" action="<c:url value='/reviews/${review.RNum}/delete' />" class="inline-form" onsubmit="return confirm('이 후기를 삭제하시겠습니까?');">
                <button type="submit" class="danger"><i class="ri-delete-bin-line"></i> 삭제</button>
            </form>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
