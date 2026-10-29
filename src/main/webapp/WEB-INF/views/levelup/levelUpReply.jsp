<%-- 등업 신청 답변 화면 --%>
<%--@elvariable id="parent" type="com.example.onedayclass.levelup.dto.LevelUpDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-reply-line" style="color:var(--primary);"></i> 등업 요청 심사 답변</h2>
        <p>원글: <strong>${parent.lvlTitle}</strong></p>
    </div>
    <form method="post" action="<c:url value='/levelups/${parent.lvlNum}/reply' />">
        <label class="field-block">
            <span class="field-label">답변 제목 <span class="required-mark">*</span></span>
            <input type="text" name="lvlTitle" placeholder="답변 제목 (4~80자)" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <div class="form-grid">
            <label class="field-block">
                <span class="field-label">활동명</span>
                <input type="text" name="lvlName" placeholder="활동명" minlength="2" maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="활동명은 2~50자 이내로 입력해 주세요.">
            </label>
            <label class="field-block">
                <span class="field-label">SNS</span>
                <input type="url" name="lvlSns" placeholder="https://" maxlength="255" title="올바른 URL 형식으로 입력해 주세요.">
            </label>
        </div>
        <label class="field-block">
            <span class="field-label">답변 내용 <span class="required-mark">*</span></span>
            <textarea name="lvlContent" placeholder="답변 내용을 입력해 주세요." required minlength="20" maxlength="3000" title="답변 내용은 20자 이상 입력해 주세요."></textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 답변 등록</button>
            <a class="btn secondary member-submit" href="<c:url value='/levelups/${parent.lvlNum}' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
