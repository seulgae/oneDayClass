<%-- QnA 답변 화면 --%>
<%--@elvariable id="parent" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-reply-line" style="color:var(--primary);"></i> 문의 답변 작성</h2>
        <p>원글: <strong>${parent.QTitle}</strong></p>
    </div>
    <form method="post" action="<c:url value='/qna/${parent.QNum}/reply' />">
        <label class="field-block">
            <span class="field-label">답변 제목 <span class="required-mark">*</span></span>
            <input type="text" name="qTitle" placeholder="답변 제목 (4~80자)" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <label class="field-block">
            <span class="field-label">답변 내용 <span class="required-mark">*</span></span>
            <textarea name="qContent" placeholder="답변 내용을 입력해 주세요." rows="8" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 답변 등록</button>
            <a class="btn secondary member-submit" href="<c:url value='/qna/${parent.QNum}' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
