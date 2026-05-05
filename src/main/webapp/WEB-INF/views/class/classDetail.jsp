<%-- 클래스 상세 화면 --%>
<%--@elvariable id="classItem" type="com.example.onedayclass.clazz.dto.ClassDto"--%>
<%--@elvariable id="reviews" type="java.util.List"--%>
<%--@elvariable id="questions" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <c:set var="thumbImageName" value="${empty classItem.CThumbName ? 'default-class-thumb.svg' : classItem.CThumbName}" />
    <c:set var="detailImageName" value="${empty classItem.CFileName ? 'default-class-detail.svg' : classItem.CFileName}" />
    <div class="section-head">
        <h2>${classItem.CTitle}</h2>
        <div class="actions">
            <a class="btn secondary" href="<c:url value='/classes' />">목록으로</a>
            <c:if test="${canManageClass}">
                <a class="btn secondary" href="<c:url value='/classes/${classItem.CNum}/edit' />">수정</a>
                <form method="post" action="<c:url value='/classes/${classItem.CNum}/delete' />" class="inline-form" onsubmit="return confirm('이 클래스를 삭제하시겠습니까?');">
                    <button type="submit" class="danger">삭제</button>
                </form>
            </c:if>
        </div>
    </div>
    <img class="detail-thumb" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="${classItem.CTitle}">
    <dl><dt>강사</dt><dd>${classItem.CTeacher}</dd></dl>
    <dl><dt>카테고리</dt><dd>${classItem.CCategory}</dd></dl>
    <dl><dt>가격</dt><dd>${classItem.CPrice}원 / 배송비 ${classItem.CDelivery}원</dd></dl>
    <dl><dt>진행방식</dt><dd>${classItem.COnoff} / ${classItem.CArea}</dd></dl>
    <dl><dt>신청현황</dt><dd>${classItem.CApplyStu} / ${classItem.CMaxStu}</dd></dl>
    <dl><dt>소개</dt><dd>${classItem.CContent}</dd></dl>
    <div class="detail-image-wrap">
        <img class="detail-image" src="<c:url value='/uploads/classes/${detailImageName}' />" alt="${classItem.CTitle}">
    </div>
    <div class="actions">
        <c:if test="${loginMember != null and (loginMember.ULevel eq '1')}">
            <form method="post" action="<c:url value='/classes/${classItem.CNum}/like' />" class="inline-form">
                <button type="submit">좋아요</button>
            </form>
            <form method="post" action="<c:url value='/payments/cart/${classItem.CNum}' />" class="inline-form">
                <button type="submit">장바구니 담기</button>
            </form>
        <c:choose>
            <c:when test="${loginMember != null}">
                <a class="btn secondary" href="<c:url value='/reviews/new?cNum=${classItem.CNum}' />">후기 작성</a>
            </c:when>
            <c:otherwise>
                <a class="btn secondary" href="<c:url value='/members/login' />">후기 작성</a>
            </c:otherwise>
        </c:choose>
            <a class="btn secondary" href="<c:url value='/qna/new?cNum=${classItem.CNum}' />">문의 작성</a>
        </c:if>
    </div>
</section>

<section class="two-column">
    <article class="panel">
        <div class="section-head">
            <h2>후기</h2>
            <a href="<c:url value='/reviews' />">전체 후기</a>
        </div>
        <c:forEach var="review" items="${reviews}">
            <a class="list-link" href="<c:url value='/reviews/${review.RNum}' />">
                ${review.RTitle}<em>${review.RUid}</em>
            </a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head">
            <h2>문의</h2>
            <a href="<c:url value='/qna' />">전체 문의</a>
        </div>
        <c:forEach var="question" items="${questions}">
            <a class="list-link" href="<c:url value='/qna/${question.QNum}' />">
                ${question.QTitle}<em>${question.QUid}</em>
            </a>
        </c:forEach>
    </article>
</section>
<%@ include file="../include/footer.jspf" %>



