<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>${question.QTitle}</h2><a class="btn secondary" href="/qna">Back</a></div>
    <dl><dt>Writer</dt><dd>${question.QUid}</dd></dl>
    <dl><dt>Thread</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>Content</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="/qna/${question.QNum}/reply">Reply</a>
        <form method="post" action="/qna/${question.QRef}/delete" class="inline-form"><button type="submit">Delete thread</button></form>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
