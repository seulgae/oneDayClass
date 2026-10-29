<%-- 마이페이지 화면 --%>
<%--@elvariable id="member" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail" style="max-width:860px; margin:0 auto;">
    <div class="section-head">
        <div>
            <h2><i class="ri-user-settings-line"></i> 마이페이지</h2>
            <p class="section-subtitle">내 계정 정보와 수강·결제 내역을 한눈에 관리합니다.</p>
        </div>
        <a class="btn secondary" href="<c:url value='/members/edit' />"><i class="ri-edit-2-line"></i> 회원정보 수정</a>
    </div>
    <dl><dt><i class="ri-id-card-line"></i> 아이디</dt><dd><strong>${member.UId}</strong></dd></dl>
    <dl><dt><i class="ri-user-smile-line"></i> 이름</dt><dd>${member.UName}</dd></dl>
    <dl>
        <dt><i class="ri-vip-crown-line"></i> 회원 등급</dt>
        <dd>
            <c:choose>
                <c:when test="${member.ULevel eq '1'}"><span class="badge badge-indigo">레벨 1 &middot; 수강생</span></c:when>
                <c:when test="${member.ULevel eq '2'}"><span class="badge badge-primary">레벨 2 &middot; 강사 (선생님)</span></c:when>
                <c:when test="${member.ULevel eq '3'}"><span class="badge badge-success">레벨 3 &middot; 관리자</span></c:when>
                <c:when test="${member.ULevel eq '4'}"><span class="badge badge-warn">레벨 4 &middot; 운영자</span></c:when>
                <c:otherwise><span class="badge badge-slate">${member.ULevel}</span></c:otherwise>
            </c:choose>
        </dd>
    </dl>
    <dl><dt><i class="ri-smartphone-line"></i> 휴대폰 번호</dt><dd>${empty member.UPhone ? '-' : member.UPhone}</dd></dl>
    <dl><dt><i class="ri-mail-line"></i> 이메일</dt><dd>${empty member.UEmail ? '-' : member.UEmail}</dd></dl>
    <dl><dt><i class="ri-map-pin-line"></i> 주소</dt><dd>${empty member.UAddr1 ? '-' : member.UAddr1} ${member.UAddr2}</dd></dl>
    <div class="actions" style="margin-top:16px; padding-top:16px; border-top:1px solid var(--line);">
        <a class="btn" href="<c:url value='/payments/history' />"><i class="ri-file-list-3-line"></i> 결제내역 확인</a>
        <c:if test="${loginMember != null and (loginMember.ULevel eq '1')}">
            <a class="btn secondary" href="<c:url value='/levelups' />"><i class="ri-award-line"></i> 강사 등업 요청</a>
        </c:if>
        <form method="post" action="<c:url value='/members/delete' />" class="inline-form" style="margin-left:auto;" onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
            <button type="submit" class="danger"><i class="ri-user-unfollow-line"></i> 회원탈퇴</button>
        </form>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
