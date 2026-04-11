<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${question.QTitle}</h2>
        <a class="btn secondary" href="/qna">紐⑸줉?쇰줈</a>
    </div>
    <dl><dt>?묒꽦??/dt><dd>${question.QUid}</dd></dl>
    <dl><dt>臾몄쓽踰덊샇</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>?묒꽦??/dt><dd>${fn:substring(question.QRegDate, 0, 10)}</dd></dl>
    <dl><dt>?댁슜</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <a class="btn secondary" href="/qna/${question.QNum}/reply">?볤? ?묒꽦</a>
        </c:if>
        <form method="post" action="/qna/${question.QNum}/delete" class="inline-form">
            <button type="submit">臾몄쓽 ??젣</button>
        </form>
    </div>
</section>

<section class="panel">
    <div class="section-head">
        <h2>?볤?</h2>
        <span class="muted">${replies.size()}媛?/span>
    </div>
    <c:if test="${empty replies}">
        <p class="muted">?꾩쭅 ?깅줉???볤????놁뒿?덈떎.</p>
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
                        <input type="text" name="qTitle" placeholder="??볤? ?쒕ぉ" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="?쒕ぉ? 4~80???대궡濡??낅젰??二쇱꽭??">
                        <textarea name="qContent" placeholder="??볤? ?댁슜???낅젰?섏꽭??" rows="3" required minlength="10" maxlength="3000" title="??볤? ?댁슜? 10???댁긽 ?낅젰??二쇱꽭??"></textarea>
                        <button type="submit">??볤? ?깅줉</button>
                    </form>
                </c:if>
            </article>
        </c:forEach>
    </div>
</section>

<c:if test="${loginMember != null}">
    <section class="form-panel">
        <h2>?볤? ?묒꽦</h2>
        <form method="post" action="/qna/${question.QNum}/reply">
            <input type="text" name="qTitle" placeholder="?볤? ?쒕ぉ" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="?쒕ぉ? 4~80???대궡濡??낅젰??二쇱꽭??">
            <textarea name="qContent" placeholder="?볤? ?댁슜???낅젰?섏꽭??" rows="5" required minlength="10" maxlength="3000" title="?볤? ?댁슜? 10???댁긽 ?낅젰??二쇱꽭??"></textarea>
            <button type="submit">?볤? ?깅줉</button>
        </form>
    </section>
</c:if>
<%@ include file="../include/footer.jsp" %>
