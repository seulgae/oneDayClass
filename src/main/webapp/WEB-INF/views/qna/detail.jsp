<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>${question.QTitle}</h2><a class="btn secondary" href="/qna">목록으로</a></div>
    <dl><dt>작성자</dt><dd>${question.QUid}</dd></dl>
    <dl><dt>문의번호</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>내용</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="/qna/${question.QNum}/reply">답변</a>
        <form method="post" action="/qna/${question.QRef}/delete" class="inline-form"><button type="submit">문의 삭제</button></form>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
