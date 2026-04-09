<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>댓글 작성</h2>
    <p class="muted">원글: ${parent.reqTitle}</p>
    <form method="post" action="/requests/${parent.reqNum}/reply">
        <input type="text" name="reqTitle" placeholder="댓글 제목" required>
        <textarea name="reqContent" placeholder="댓글 내용을 입력하세요" rows="8" required></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
