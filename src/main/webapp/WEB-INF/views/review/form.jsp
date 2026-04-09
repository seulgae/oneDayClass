<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>후기 작성</h2>
    <form method="post" action="/reviews">
        <input type="hidden" name="cNum" value="${reviewDto.CNum}">
        <input type="text" name="rTitle" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="rContent" placeholder="후기 내용을 입력하세요" required minlength="10" maxlength="3000" title="후기 내용은 10자 이상 입력해 주세요."></textarea>
        <button type="submit">저장</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
