<%-- 등업 신청 상세 화면 --%>
<%--@elvariable id="requestItem" type="com.example.onedayclass.levelup.dto.LevelUpDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <div>
            <span class="badge badge-warn" style="margin-bottom:8px;"><i class="ri-award-line"></i> 강사 등업 심사</span>
            <h2>${requestItem.lvlTitle}</h2>
        </div>
        <a class="btn secondary" href="<c:url value='/levelups' />"><i class="ri-list-check"></i> 목록으로</a>
    </div>
    <dl><dt><i class="ri-user-line"></i> 작성자</dt><dd>${requestItem.lvlUid}</dd></dl>
    <dl><dt><i class="ri-user-star-line"></i> 활동명</dt><dd><strong>${requestItem.lvlName}</strong></dd></dl>
    <dl><dt><i class="ri-links-line"></i> SNS / 포트폴리오</dt><dd>${empty requestItem.lvlSns ? '-' : requestItem.lvlSns}</dd></dl>
    <dl><dt><i class="ri-file-text-line"></i> 신청 내용</dt><dd><div class="content-body-box">${requestItem.lvlContent}</div></dd></dl>
    <div class="actions" style="margin-top:8px;">
        <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <form method="post" action="<c:url value='/levelups/${requestItem.lvlNum}/approve' />" class="inline-form">
                <button type="submit"><i class="ri-checkbox-circle-line"></i> 강사 등업 승인</button>
            </form>
            <a class="btn secondary" href="<c:url value='/levelups/${requestItem.lvlNum}/reply' />"><i class="ri-reply-line"></i> 심사 답변</a>
        </c:if>
        <c:if test="${loginMember != null and (loginMember.UId eq requestItem.lvlUid or loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <form method="post" action="<c:url value='/levelups/${requestItem.lvlNum}/delete' />" class="inline-form" onsubmit="return confirm('이 등업 신청을 삭제하시겠습니까?');">
                <button type="submit" class="danger"><i class="ri-delete-bin-line"></i> 삭제</button>
            </form>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
