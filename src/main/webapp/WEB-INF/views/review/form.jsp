<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>New Review</h2>
    <form method="post" action="/reviews">
        <input type="hidden" name="cNum" value="${reviewDto.CNum}">
        <input type="text" name="rTitle" placeholder="Title" required>
        <textarea name="rContent" placeholder="Review content" required></textarea>
        <button type="submit">Save</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
