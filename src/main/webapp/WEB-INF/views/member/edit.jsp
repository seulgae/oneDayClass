<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Edit Member</h2>
    <form method="post" action="/members/edit">
        <div class="form-grid">
            <input type="password" name="uPw" value="${memberDto.UPw}" placeholder="Password">
            <input type="text" name="uPhone" value="${memberDto.UPhone}" placeholder="Phone">
            <input type="text" name="uZip" value="${memberDto.UZip}" placeholder="Zip">
            <input type="email" name="uEmail" value="${memberDto.UEmail}" placeholder="Email">
        </div>
        <input type="text" name="uAddr1" value="${memberDto.UAddr1}" placeholder="Address 1">
        <input type="text" name="uAddr2" value="${memberDto.UAddr2}" placeholder="Address 2">
        <button type="submit">Save</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
