<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>New Level Up Request</h2>
    <form method="post" action="/levelups">
        <input type="text" name="lvlTitle" placeholder="Title" required>
        <input type="text" name="lvlName" value="${levelUpDto.LvlName}" placeholder="Store name">
        <input type="text" name="lvlSns" placeholder="SNS">
        <textarea name="lvlContent" placeholder="Request content" required></textarea>
        <button type="submit">Save</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
