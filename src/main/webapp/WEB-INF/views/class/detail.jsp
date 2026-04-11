<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${classItem.CTitle}</h2>
        <a class="btn secondary" href="/classes">목록으로</a>
    </div>
    <c:if test="${not empty classItem.CThumbName}">
        <img class="detail-thumb" src="/uploads/classes/${classItem.CThumbName}" alt="${classItem.CTitle}">
    </c:if>
    <dl><dt>강사</dt><dd>${classItem.CTeacher}</dd></dl>
    <dl><dt>카테고리</dt><dd>${classItem.CCategory}</dd></dl>
    <dl><dt>가격</dt><dd>${classItem.CPrice}원 / 배송비 ${classItem.CDelivery}원</dd></dl>
    <dl><dt>진행방식</dt><dd>${classItem.COnoff} / ${classItem.CArea}</dd></dl>
    <dl><dt>신청현황</dt><dd>${classItem.CApplyStu} / ${classItem.CMaxStu}</dd></dl>
    <dl><dt>소개</dt><dd>${classItem.CContent}</dd></dl>
    <c:if test="${not empty classItem.CFileName}">
        <div class="detail-image-wrap">
            <img class="detail-image" src="/uploads/classes/${classItem.CFileName}" alt="${classItem.CTitle}">
        </div>
    </c:if>
    <div class="actions">
        <form method="post" action="/classes/${classItem.CNum}/like" class="inline-form">
            <button type="submit">좋아요</button>
        </form>
        <form method="post" action="/payments/cart/${classItem.CNum}" class="inline-form">
            <button type="submit">장바구니 담기</button>
        </form>
        <a class="btn secondary" href="/reviews/new?cNum=${classItem.CNum}">후기 작성</a>
        <a class="btn secondary" href="/qna/new?cNum=${classItem.CNum}">문의 작성</a>
    </div>
</section>

<section class="two-column">
    <article class="panel">
        <div class="section-head">
            <h2>후기</h2>
            <a href="/reviews">전체 후기</a>
        </div>
        <c:forEach var="review" items="${reviews}">
            <a class="list-link" href="/reviews/${review.RNum}">
                ${review.RTitle}<em>${review.RUid}</em>
            </a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head">
            <h2>문의</h2>
            <a href="/qna">전체 문의</a>
        </div>
        <c:forEach var="question" items="${questions}">
            <a class="list-link" href="/qna/${question.QNum}">
                ${question.QTitle}<em>${question.QUid}</em>
            </a>
        </c:forEach>
    </article>
</section>
<%@ include file="../include/footer.jsp" %>
