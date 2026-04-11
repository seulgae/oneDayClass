<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>등업 요청 작성</h2>
    <form method="post" action="/levelups">
        <input type="text" name="lvlTitle" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <input type="text" name="lvlName" value="${levelUpDto.lvlName}" placeholder="활동명" required maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="활동명은 2~50자 이내로 입력해 주세요.">
        <input type="url" name="lvlSns" placeholder="SNS" maxlength="255" title="올바른 URL 형식으로 입력해 주세요.">
        <textarea name="lvlContent" placeholder="요청 내용을 입력해 주세요." required minlength="20" maxlength="3000" title="요청 내용은 20자 이상 입력해 주세요."></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
