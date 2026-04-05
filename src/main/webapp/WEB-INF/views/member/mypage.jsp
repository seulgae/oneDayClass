<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>My Page</h2><a class="btn secondary" href="/members/edit">Edit</a></div>
    <dl><dt>User ID</dt><dd>${member.UId}</dd></dl>
    <dl><dt>Name</dt><dd>${member.UName}</dd></dl>
    <dl><dt>Level</dt><dd>${member.ULevel}</dd></dl>
    <dl><dt>Phone</dt><dd>${member.UPhone}</dd></dl>
    <dl><dt>Email</dt><dd>${member.UEmail}</dd></dl>
    <dl><dt>Address</dt><dd>${member.UAddr1} ${member.UAddr2}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="/payments/history">Payment history</a>
        <form method="post" action="/members/delete" class="inline-form">
            <button type="submit">Delete account</button>
        </form>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
