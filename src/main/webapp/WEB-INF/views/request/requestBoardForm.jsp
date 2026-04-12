<%-- 요청 게시판 작성 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>요청 올리기</h2>
    <p class="muted">필요한 기능, 개선 아이디어, 사용 중 불편했던 점을 자세히 적어 주세요.</p>
    <form method="post" action="/requests">
        <input type="text" name="reqTitle" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="reqContent" placeholder="예: 이런 기능이 있으면 더 편하게 사용할 수 있을 것 같아요." rows="8" required minlength="10" maxlength="3000" title="요청 내용은 10자 이상 입력해 주세요."></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>

