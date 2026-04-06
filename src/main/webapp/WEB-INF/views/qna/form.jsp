<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>문의 작성</h2>
    <form method="post" action="/qna">
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <input type="text" name="qTitle" placeholder="제목" required>
        <textarea name="qContent" placeholder="문의 내용을 입력하세요" required></textarea>
        <button type="submit">저장</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
