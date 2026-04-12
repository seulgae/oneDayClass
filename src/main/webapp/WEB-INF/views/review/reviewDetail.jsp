<%-- 후기 상세 화면 --%>
<%--@elvariable id="review" type="com.example.onedayclass.review.dto.ReviewDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head"><h2>${review.RTitle}</h2><a class="btn secondary" href="<c:url value='/reviews' />">목록으로</a></div>
    <dl><dt>작성자</dt><dd>${review.RUid}</dd></dl>
    <dl><dt>통계</dt><dd>조회 ${review.RCnt} / 좋아요 ${review.RLikes}</dd></dl>
    <dl><dt>내용</dt><dd>${review.RContent}</dd></dl>
    <div class="actions">
        <form method="post" action="<c:url value='/reviews/${review.RNum}/like' />" class="inline-form"><button type="submit">좋아요</button></form>
        <form method="post" action="<c:url value='/reviews/${review.RNum}/delete' />" class="inline-form"><button type="submit">삭제</button></form>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

