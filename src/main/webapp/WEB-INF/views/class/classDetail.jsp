<%-- 클래스 상세 화면 --%>
<%--@elvariable id="classItem" type="com.example.onedayclass.clazz.dto.ClassDto"--%>
<%--@elvariable id="reviews" type="java.util.List"--%>
<%--@elvariable id="questions" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <c:set var="thumbImageName" value="${empty classItem.CThumbName ? 'default-class-thumb.svg' : classItem.CThumbName}" />
    <c:set var="detailImageName" value="${empty classItem.CFileName ? 'default-class-detail.svg' : classItem.CFileName}" />
    <div class="section-head">
        <div>
            <div class="card-badges" style="margin-bottom:10px;">
                <c:choose>
                    <c:when test="${classItem.COnoff eq 'Y'}">
                        <span class="badge badge-primary"><i class="ri-map-pin-2-line"></i> 오프라인 (${classItem.CArea})</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-indigo"><i class="ri-vidicon-line"></i> 온라인 클래스</span>
                    </c:otherwise>
                </c:choose>
                <span class="badge badge-slate">${classItem.CCategory}</span>
                <span class="badge badge-success"><i class="ri-heart-3-fill"></i> 좋아요 ${classItem.CLikes}</span>
            </div>
            <h2>${classItem.CTitle}</h2>
        </div>
        <div class="actions">
            <a class="btn secondary" href="<c:url value='/classes' />"><i class="ri-list-check"></i> 목록으로</a>
            <c:if test="${canManageClass}">
                <a class="btn secondary" href="<c:url value='/classes/${classItem.CNum}/edit' />"><i class="ri-edit-line"></i> 수정</a>
                <form method="post" action="<c:url value='/classes/${classItem.CNum}/delete' />" class="inline-form" onsubmit="return confirm('이 클래스를 삭제하시겠습니까?');">
                    <button type="submit" class="danger"><i class="ri-delete-bin-line"></i> 삭제</button>
                </form>
            </c:if>
        </div>
    </div>

    <div class="class-detail-grid">
        <div>
            <img class="detail-thumb" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="${classItem.CTitle}">
        </div>
        <div class="detail-sticky-card">
            <dl><dt><i class="ri-user-star-line"></i> 강사</dt><dd><strong>${classItem.CTeacher}</strong></dd></dl>
            <dl><dt><i class="ri-price-tag-3-line"></i> 카테고리</dt><dd>${classItem.CCategory}</dd></dl>
            <dl><dt><i class="ri-money-dollar-circle-line"></i> 수강료</dt><dd><strong style="font-size:20px; color:var(--primary);"><fmt:formatNumber value="${classItem.CPrice}" />원</strong> <span class="muted">(배송비 <fmt:formatNumber value="${classItem.CDelivery}" />원)</span></dd></dl>
            <dl><dt><i class="ri-compass-3-line"></i> 진행방식</dt><dd>${classItem.COnoff eq 'Y' ? '오프라인 대면' : '온라인 비대면'} / ${classItem.CArea}</dd></dl>
            <dl><dt><i class="ri-group-line"></i> 신청현황</dt><dd><span class="badge badge-indigo">${classItem.CApplyStu}명 신청중</span> / 정원 ${classItem.CMaxStu}명</dd></dl>

            <div class="actions" style="margin-top:8px;">
                <c:choose>
                    <c:when test="${loginMember != null and (loginMember.ULevel eq '1')}">
                        <form method="post" action="<c:url value='/payments/cart/${classItem.CNum}' />" class="inline-form" style="flex:1;">
                            <button type="submit" style="width:100%;"><i class="ri-shopping-bag-3-line"></i> 장바구니 담기</button>
                        </form>
                        <form method="post" action="<c:url value='/classes/${classItem.CNum}/like' />" class="inline-form">
                            <button type="submit" class="secondary"><i class="ri-heart-3-line" style="color:var(--primary);"></i> 좋아요</button>
                        </form>
                    </c:when>
                    <c:when test="${loginMember == null}">
                        <button type="button" style="flex:1;" data-auth-open="login"><i class="ri-shopping-bag-3-line"></i> 로그인하고 수강 신청하기</button>
                    </c:when>
                </c:choose>
            </div>
            <c:if test="${loginMember != null and (loginMember.ULevel eq '1')}">
                <div class="actions">
                    <c:choose>
                        <c:when test="${loginMember != null}">
                            <a class="btn secondary" style="flex:1;" href="<c:url value='/reviews/new?cNum=${classItem.CNum}' />"><i class="ri-quill-pen-line"></i> 후기 작성</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn secondary" style="flex:1;" href="<c:url value='/members/login' />" data-auth-open="login"><i class="ri-quill-pen-line"></i> 후기 작성</a>
                        </c:otherwise>
                    </c:choose>
                    <a class="btn secondary" style="flex:1;" href="<c:url value='/qna/new?cNum=${classItem.CNum}' />"><i class="ri-question-answer-line"></i> 문의 작성</a>
                </div>
            </c:if>
        </div>
    </div>

    <div class="detail-image-wrap">
        <h3 style="margin:0 0 12px; font-size:18px;"><i class="ri-file-text-line" style="color:var(--primary);"></i> 클래스 상세 소개</h3>
        <div class="content-body-box" style="margin-bottom:20px;">${classItem.CContent}</div>
        <img class="detail-image" src="<c:url value='/uploads/classes/${detailImageName}' />" alt="${classItem.CTitle}">
    </div>
</section>

<section class="two-column">
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-star-smile-line"></i> 수강 후기</h2>
            <a href="<c:url value='/reviews' />">전체 후기 <i class="ri-arrow-right-s-line"></i></a>
        </div>
        <c:choose>
            <c:when test="${empty reviews}">
                <p class="muted">아직 등록된 수강 후기가 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="stack-list">
                    <c:forEach var="review" items="${reviews}">
                        <a class="list-link" href="<c:url value='/reviews/${review.RNum}' />">
                            <span>${review.RTitle}</span>
                            <em><i class="ri-user-line"></i> ${review.RUid}</em>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </article>
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-question-answer-line"></i> 클래스 문의</h2>
            <a href="<c:url value='/qna' />">전체 문의 <i class="ri-arrow-right-s-line"></i></a>
        </div>
        <c:choose>
            <c:when test="${empty questions}">
                <p class="muted">아직 등록된 문의가 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="stack-list">
                    <c:forEach var="question" items="${questions}">
                        <a class="list-link" href="<c:url value='/qna/${question.QNum}' />">
                            <span>${question.QTitle}</span>
                            <em><span class="badge badge-slate">${empty question.QCategory ? '기타' : question.QCategory}</span> ${question.QUid}</em>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </article>
</section>
<%@ include file="../include/footer.jspf" %>
