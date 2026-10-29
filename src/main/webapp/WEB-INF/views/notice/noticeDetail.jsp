<%-- 공지사항 상세 화면 --%>
<%--@elvariable id="notice" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <div>
            <span class="badge badge-primary" style="margin-bottom:8px;"><i class="ri-megaphone-line"></i> 공식 안내</span>
            <h2>${notice.QTitle}</h2>
        </div>
        <a class="btn secondary" href="<c:url value='/notices' />"><i class="ri-list-check"></i> 목록으로</a>
    </div>
    <dl><dt><i class="ri-user-line"></i> 작성자</dt><dd>${notice.QUid}</dd></dl>
    <dl><dt><i class="ri-calendar-line"></i> 작성일</dt><dd>${fn:substring(notice.QRegDate, 0, 10)}</dd></dl>
    <dl><dt><i class="ri-file-text-line"></i> 내용</dt><dd><div class="content-body-box">${notice.QContent}</div></dd></dl>
    <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
        <div class="actions" style="margin-top:8px;">
            <a class="btn secondary" href="<c:url value='/notices/${notice.QNum}/edit' />"><i class="ri-edit-line"></i> 수정</a>
            <form method="post" action="<c:url value='/notices/${notice.QNum}/delete' />" class="inline-form" onsubmit="return confirm('이 공지사항을 삭제하시겠습니까?');">
                <button type="submit" class="danger"><i class="ri-delete-bin-line"></i> 삭제</button>
            </form>
        </div>
    </c:if>
</section>
<%@ include file="../include/footer.jspf" %>
