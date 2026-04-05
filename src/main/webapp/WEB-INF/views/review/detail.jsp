<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>${review.RTitle}</h2><a class="btn secondary" href="/reviews">Back</a></div>
    <dl><dt>Writer</dt><dd>${review.RUid}</dd></dl>
    <dl><dt>Stats</dt><dd>read ${review.RCnt} / likes ${review.RLikes}</dd></dl>
    <dl><dt>Content</dt><dd>${review.RContent}</dd></dl>
    <div class="actions">
        <form method="post" action="/reviews/${review.RNum}/like" class="inline-form"><button type="submit">Like</button></form>
        <form method="post" action="/reviews/${review.RNum}/delete" class="inline-form"><button type="submit">Delete</button></form>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
