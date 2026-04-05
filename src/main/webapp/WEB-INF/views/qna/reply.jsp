<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Reply Question</h2>
    <p class="muted">Parent: ${parent.QTitle}</p>
    <form method="post" action="/qna/${parent.QNum}/reply">
        <input type="text" name="qTitle" placeholder="Reply title" required>
        <textarea name="qContent" placeholder="Reply content" required></textarea>
        <button type="submit">Save reply</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
