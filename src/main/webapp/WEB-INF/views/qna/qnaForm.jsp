<%-- QnA 작성 화면 --%>
<%--@elvariable id="qnaDto" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%--@elvariable id="qnaCategories" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-question-answer-line" style="color:var(--primary);"></i> 클래스 문의 작성</h2>
        <p>수강 일정, 준비물, 커리큘럼 등 궁금한 점을 남겨주시면 강사님 또는 운영팀이 답변해 드립니다.</p>
    </div>
    <form method="post" action="<c:url value='/qna' />">
        <c:if test="${not empty message}">
            <p class="form-error">${message}</p>
        </c:if>
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <div class="detail" style="background:var(--surface-soft); padding:14px 20px; border-radius:var(--radius-md); border:1px solid var(--line);">
            <dl style="padding:0; border:0;">
                <dt><i class="ri-book-open-line"></i> 대상 클래스</dt>
                <dd><a href="<c:url value='/classes/${qnaDto.CNum}' />">${qnaDto.CTitle}</a></dd>
            </dl>
        </div>
        <label class="field-block">
            <span class="field-label">문의 분류 <span class="required-mark">*</span></span>
            <select name="qCategory" required>
                <option value="">문의 분류를 선택해 주세요.</option>
                <c:forEach var="category" items="${qnaCategories}">
                    <option value="${category}" ${qnaDto.QCategory eq category ? 'selected' : ''}>${category}</option>
                </c:forEach>
            </select>
        </label>
        <label class="field-block">
            <span class="field-label">문의 제목 <span class="required-mark">*</span></span>
            <input type="text" name="qTitle" value="${qnaDto.QTitle}" placeholder="문의 제목을 입력해 주세요 (4~80자)" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <label class="field-block">
            <span class="field-label">문의 내용 <span class="required-mark">*</span></span>
            <textarea name="qContent" placeholder="문의 내용을 10자 이상 자세히 입력해 주세요." rows="8" required minlength="10" maxlength="3000" title="문의 내용은 10자 이상 입력해 주세요.">${qnaDto.QContent}</textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 문의 등록하기</button>
            <a class="btn secondary member-submit" href="<c:url value='/qna' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
