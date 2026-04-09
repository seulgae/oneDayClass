<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>댓글 작성</h2>
    <p class="muted">원글: ${parent.QTitle}</p>
    <form method="post" action="/qna/${parent.QNum}/reply">
        <input type="text" name="qTitle" placeholder="댓글 제목" required>
        <textarea name="qContent" placeholder="댓글 내용을 입력하세요" rows="8" required></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
