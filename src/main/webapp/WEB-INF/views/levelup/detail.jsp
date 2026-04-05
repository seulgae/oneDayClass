<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>${requestItem.LvlTitle}</h2><a class="btn secondary" href="/levelups">Back</a></div>
    <dl><dt>Writer</dt><dd>${requestItem.LvlUid}</dd></dl>
    <dl><dt>Store</dt><dd>${requestItem.LvlName}</dd></dl>
    <dl><dt>SNS</dt><dd>${requestItem.LvlSns}</dd></dl>
    <dl><dt>Content</dt><dd>${requestItem.LvlContent}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="/levelups/${requestItem.LvlNum}/reply">Reply</a>
        <form method="post" action="/levelups/${requestItem.LvlNum}/approve" class="inline-form"><button type="submit">Approve</button></form>
        <form method="post" action="/levelups/${requestItem.LvlNum}/delete" class="inline-form"><button type="submit">Delete</button></form>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
