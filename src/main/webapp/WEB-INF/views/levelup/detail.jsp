<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head"><h2>${requestItem.lvlTitle}</h2><a class="btn secondary" href="/levelups">목록으로</a></div>
    <dl><dt>작성자</dt><dd>${requestItem.lvlUid}</dd></dl>
    <dl><dt>브랜드명</dt><dd>${requestItem.lvlName}</dd></dl>
    <dl><dt>SNS</dt><dd>${requestItem.lvlSns}</dd></dl>
    <dl><dt>내용</dt><dd>${requestItem.lvlContent}</dd></dl>
    <div class="actions">
        <a class="btn secondary" href="/levelups/${requestItem.lvlNum}/reply">답변</a>
        <form method="post" action="/levelups/${requestItem.lvlNum}/approve" class="inline-form"><button type="submit">승인</button></form>
        <form method="post" action="/levelups/${requestItem.lvlNum}/delete" class="inline-form"><button type="submit">삭제</button></form>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>
