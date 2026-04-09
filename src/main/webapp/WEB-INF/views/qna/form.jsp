<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>문의 작성</h2>
    <form method="post" action="/qna">
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <input type="text" name="qTitle" placeholder="제목" required>
        <textarea name="qContent" placeholder="문의 내용을 입력하세요" rows="8" required></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
