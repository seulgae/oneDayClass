<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>등업 요청 답변</h2>
    <p class="muted">원글: ${parent.lvlTitle}</p>
    <form method="post" action="/levelups/${parent.lvlNum}/reply">
        <input type="text" name="lvlTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <input type="text" name="lvlName" placeholder="활동명" minlength="2" maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="활동명은 2~50자 이내로 입력해 주세요.">
        <input type="url" name="lvlSns" placeholder="SNS" maxlength="255" title="올바른 URL 형식으로 입력해 주세요.">
        <textarea name="lvlContent" placeholder="답변 내용을 입력해 주세요." required minlength="20" maxlength="3000" title="답변 내용은 20자 이상 입력해 주세요."></textarea>
        <button type="submit">답변 등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
