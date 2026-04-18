<%-- 공지사항 상세 화면 --%>
<%--@elvariable id="notice" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${notice.QTitle}</h2>
        <a class="btn secondary" href="<c:url value='/notices' />">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${notice.QUid}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(notice.QRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${notice.QContent}</dd></dl>
    <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
        <div class="actions">
            <a class="btn secondary" href="<c:url value='/notices/${notice.QNum}/edit' />">수정</a>
            <form method="post" action="<c:url value='/notices/${notice.QNum}/delete' />" class="inline-form">
                <button type="submit">삭제</button>
            </form>
        </div>
    </c:if>
</section>
<%@ include file="../include/footer.jspf" %>

