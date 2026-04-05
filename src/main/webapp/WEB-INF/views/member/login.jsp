<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Login</h2>
    <form method="post" action="/members/login">
        <input type="text" name="uId" placeholder="User ID" required>
        <input type="password" name="uPw" placeholder="Password" required>
        <div class="actions">
            <button type="submit">Login</button>
            <a class="btn secondary" href="/members/join">Join</a>
        </div>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
