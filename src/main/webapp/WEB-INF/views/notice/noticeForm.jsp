<%-- 공지사항 작성/수정 화면 --%>
<%--@elvariable id="noticeDto" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <c:choose>
        <c:when test="${noticeDto.QNum != null}">
            <c:url var="noticeFormAction" value="/notices/${noticeDto.QNum}/edit" />
        </c:when>
        <c:otherwise>
            <c:url var="noticeFormAction" value="/notices" />
        </c:otherwise>
    </c:choose>
    <h2><c:choose><c:when test="${noticeDto.QNum != null}">공지사항 수정</c:when><c:otherwise>공지사항 작성</c:otherwise></c:choose></h2>
    <form method="post" action="${noticeFormAction}">
        <label>
            제목
            <input type="text" name="qTitle" value="${noticeDto.QTitle}" required minlength="4" maxlength="80">
        </label>
        <label>
            내용
            <textarea name="qContent" required minlength="10" maxlength="3000">${noticeDto.QContent}</textarea>
        </label>
        <div class="form-actions">
            <button type="submit">저장</button>
            <a class="btn secondary" href="<c:url value='/notices' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
