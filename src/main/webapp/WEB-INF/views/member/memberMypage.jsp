<%-- 마이페이지 화면 --%>
<%--@elvariable id="member" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head"><h2>마이페이지</h2><a class="btn secondary" href="<c:url value='/members/edit' />">수정</a></div>
    <dl><dt>아이디</dt><dd>${member.UId}</dd></dl>
    <dl><dt>이름</dt><dd>${member.UName}</dd></dl>
    <dl><dt>등급</dt><dd>${member.ULevel}</dd></dl>
    <dl><dt>휴대폰 번호</dt><dd>${member.UPhone}</dd></dl>
    <dl><dt>이메일</dt><dd>${member.UEmail}</dd></dl>
    <dl><dt>주소</dt><dd>${member.UAddr1} ${member.UAddr2}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="<c:url value='/levelups' />">등업 요청</a>
        <a class="btn secondary" href="<c:url value='/payments/history' />">결제내역</a>
        <form method="post" action="<c:url value='/members/delete' />" class="inline-form">
            <button type="submit">회원탈퇴</button>
        </form>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

