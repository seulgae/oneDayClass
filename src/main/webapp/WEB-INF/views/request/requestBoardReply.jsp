<%-- 요청 게시판 답변 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>답변 작성</h2>
    <p class="muted">원글: ${parent.reqTitle}</p>
    <form method="post" action="/requests/${parent.reqNum}/reply">
        <input type="text" name="reqTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="reqContent" placeholder="답변 내용을 입력해 주세요." rows="8" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>

