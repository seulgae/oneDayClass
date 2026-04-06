<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>문의 답변</h2>
    <p class="muted">원글: ${parent.QTitle}</p>
    <form method="post" action="/qna/${parent.QNum}/reply">
        <input type="text" name="qTitle" placeholder="답변 제목" required>
        <textarea name="qContent" placeholder="답변 내용을 입력하세요" required></textarea>
        <button type="submit">답변 저장</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
