<%-- 등업 신청 상세 화면 --%>
<%--@elvariable id="requestItem" type="com.example.onedayclass.levelup.dto.LevelUpDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head"><h2>${requestItem.lvlTitle}</h2><a class="btn secondary" href="<c:url value='/levelups' />">목록으로</a></div>
    <dl><dt>작성자</dt><dd>${requestItem.lvlUid}</dd></dl>
    <dl><dt>활동명</dt><dd>${requestItem.lvlName}</dd></dl>
    <dl><dt>SNS</dt><dd>${requestItem.lvlSns}</dd></dl>
    <dl><dt>내용</dt><dd>${requestItem.lvlContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <a class="btn secondary" href="<c:url value='/levelups/${requestItem.lvlNum}/reply' />">답변</a>
            <form method="post" action="<c:url value='/levelups/${requestItem.lvlNum}/approve' />" class="inline-form"><button type="submit">승인</button></form>
        </c:if>
        <c:if test="${loginMember != null and (loginMember.UId eq requestItem.lvlUid or loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
            <form method="post" action="<c:url value='/levelups/${requestItem.lvlNum}/delete' />" class="inline-form"><button type="submit">삭제</button></form>
        </c:if>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

