<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>?볤? ?묒꽦</h2>
    <p class="muted">?먭?: ${parent.QTitle}</p>
    <form method="post" action="/qna/${parent.QNum}/reply">
        <input type="text" name="qTitle" placeholder="?볤? ?쒕ぉ" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="?쒕ぉ? 4~80???대궡濡??낅젰??二쇱꽭??">
        <textarea name="qContent" placeholder="?볤? ?댁슜???낅젰?섏꽭??" rows="8" required minlength="10" maxlength="3000" title="?볤? ?댁슜? 10???댁긽 ?낅젰??二쇱꽭??"></textarea>
        <button type="submit">?깅줉</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
