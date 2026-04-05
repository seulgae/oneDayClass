<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Join</h2>
    <form method="post" action="/members/join">
        <div class="form-grid">
            <input type="text" name="uId" placeholder="User ID" required>
            <input type="password" name="uPw" placeholder="Password" required>
            <input type="text" name="uName" placeholder="Name" required>
            <input type="text" name="uPhone" placeholder="Phone">
            <input type="text" name="uZip" placeholder="Zip">
            <input type="email" name="uEmail" placeholder="Email">
        </div>
        <input type="text" name="uAddr1" placeholder="Address 1">
        <input type="text" name="uAddr2" placeholder="Address 2">
        <button type="submit">Create account</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
