<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${requestItem.reqTitle}</h2>
        <a class="btn secondary" href="/requests">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${requestItem.reqUid}</dd></dl>
    <dl><dt>요청번호</dt><dd>${requestItem.reqRef}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(requestItem.reqRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${requestItem.reqContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <a class="btn secondary" href="/requests/${requestItem.reqNum}/reply">답변 작성</a>
        </c:if>
        <form method="post" action="/requests/${requestItem.reqNum}/delete" class="inline-form">
            <button type="submit">요청 삭제</button>
        </form>
    </div>
</section>

<section class="panel">
    <div class="section-head">
        <h2>답변</h2>
        <span class="muted">${replies.size()}개</span>
    </div>
    <c:if test="${empty replies}">
        <p class="muted">아직 등록된 답변이 없습니다.</p>
    </c:if>
    <div class="qna-reply-list">
        <c:forEach var="reply" items="${replies}">
            <article class="qna-reply qna-depth-${reply.reqDepth}">
                <div class="qna-reply-head">
                    <strong>${reply.reqUid}</strong>
                    <span class="muted">${fn:substring(reply.reqRegDate, 0, 10)}</span>
                </div>
                <h3>${reply.reqTitle}</h3>
                <p>${reply.reqContent}</p>
                <c:if test="${loginMember != null and reply.reqDepth lt 2}">
                    <form method="post" action="/requests/${reply.reqNum}/reply" class="qna-inline-reply-form">
                        <input type="text" name="reqTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
                        <textarea name="reqContent" placeholder="답변 내용을 입력해 주세요." rows="3" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
                        <button type="submit">답변 등록</button>
                    </form>
                </c:if>
            </article>
        </c:forEach>
    </div>
</section>

<c:if test="${loginMember != null}">
    <section class="form-panel">
        <h2>답변 작성</h2>
        <form method="post" action="/requests/${requestItem.reqNum}/reply">
            <input type="text" name="reqTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
            <textarea name="reqContent" placeholder="답변 내용을 입력해 주세요." rows="5" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
            <button type="submit">답변 등록</button>
        </form>
    </section>
</c:if>
<%@ include file="../include/footer.jsp" %>
