<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Reply Level Up</h2>
    <p class="muted">Parent: ${parent.LvlTitle}</p>
    <form method="post" action="/levelups/${parent.LvlNum}/reply">
        <input type="text" name="lvlTitle" placeholder="Reply title" required>
        <input type="text" name="lvlName" placeholder="Store name">
        <input type="text" name="lvlSns" placeholder="SNS">
        <textarea name="lvlContent" placeholder="Reply content" required></textarea>
        <button type="submit">Save reply</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
