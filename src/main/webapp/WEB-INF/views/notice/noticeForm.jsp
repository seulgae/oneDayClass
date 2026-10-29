<%-- 공지사항 작성/수정 화면 --%>
<%--@elvariable id="noticeDto" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <c:choose>
        <c:when test="${noticeDto.QNum != null}">
            <c:url var="noticeFormAction" value="/notices/${noticeDto.QNum}/edit" />
        </c:when>
        <c:otherwise>
            <c:url var="noticeFormAction" value="/notices" />
        </c:otherwise>
    </c:choose>
    <div class="member-form-hero">
        <h2><i class="ri-megaphone-line" style="color:var(--primary);"></i> <c:choose><c:when test="${noticeDto.QNum != null}">공지사항 수정</c:when><c:otherwise>공지사항 작성</c:otherwise></c:choose></h2>
        <p>회원들에게 전달할 공지사항 제목과 본문을 입력해 주세요.</p>
    </div>
    <form method="post" action="${noticeFormAction}">
        <label class="field-block">
            <span class="field-label">제목 <span class="required-mark">*</span></span>
            <input type="text" name="qTitle" value="${noticeDto.QTitle}" placeholder="공지사항 제목 (4~80자)" required minlength="4" maxlength="80">
        </label>
        <label class="field-block">
            <span class="field-label">내용 <span class="required-mark">*</span></span>
            <textarea name="qContent" placeholder="공지 내용을 입력해 주세요." required minlength="10" maxlength="3000">${noticeDto.QContent}</textarea>
        </label>
        <div class="form-actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 저장하기</button>
            <a class="btn secondary member-submit" href="<c:url value='/notices' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
