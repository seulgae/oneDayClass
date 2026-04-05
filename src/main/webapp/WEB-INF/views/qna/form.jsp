<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>New Question</h2>
    <form method="post" action="/qna">
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <input type="text" name="qTitle" placeholder="Title" required>
        <textarea name="qContent" placeholder="Question content" required></textarea>
        <button type="submit">Save</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
