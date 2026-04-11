<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${question.QTitle}</h2>
        <a class="btn secondary" href="/qna">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${question.QUid}</dd></dl>
    <dl><dt>문의번호</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(question.QRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <a class="btn secondary" href="/qna/${question.QNum}/reply">답변 작성</a>
        </c:if>
        <form method="post" action="/qna/${question.QNum}/delete" class="inline-form">
            <button type="submit">문의 삭제</button>
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
            <article class="qna-reply qna-depth-${reply.QDepth}">
                <div class="qna-reply-head">
                    <strong>${reply.QUid}</strong>
                    <span class="muted">${fn:substring(reply.QRegDate, 0, 10)}</span>
                </div>
                <h3>${reply.QTitle}</h3>
                <p>${reply.QContent}</p>
                <c:if test="${loginMember != null and reply.QDepth lt 2}">
                    <form method="post" action="/qna/${reply.QNum}/reply" class="qna-inline-reply-form">
                        <input type="text" name="qTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
                        <textarea name="qContent" placeholder="답변 내용을 입력해 주세요." rows="3" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
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
        <form method="post" action="/qna/${question.QNum}/reply">
            <input type="text" name="qTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
            <textarea name="qContent" placeholder="답변 내용을 입력해 주세요." rows="5" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
            <button type="submit">답변 등록</button>
        </form>
    </section>
</c:if>
<%@ include file="../include/footer.jsp" %>
