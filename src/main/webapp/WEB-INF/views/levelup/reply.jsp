<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>?깆뾽 ?좎껌 ?듬?</h2>
    <p class="muted">?먭?: ${parent.lvlTitle}</p>
    <form method="post" action="/levelups/${parent.lvlNum}/reply">
        <input type="text" name="lvlTitle" placeholder="?듬? ?쒕ぉ" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="?쒕ぉ? 4~80???대궡濡??낅젰??二쇱꽭??">
        <input type="text" name="lvlName" placeholder="釉뚮옖?쒕챸" minlength="2" maxlength="50" pattern="^[媛-?즑-zA-Z0-9\\s.,()_-]{2,50}$" title="釉뚮옖?쒕챸? 2~50???대궡濡??낅젰??二쇱꽭??">
        <input type="url" name="lvlSns" placeholder="SNS" maxlength="255" title="?щ컮瑜?URL ?뺤떇?쇰줈 ?낅젰??二쇱꽭??">
        <textarea name="lvlContent" placeholder="?듬? ?댁슜???낅젰?섏꽭??" required minlength="20" maxlength="3000" title="?듬? ?댁슜? 20???댁긽 ?낅젰??二쇱꽭??"></textarea>
        <button type="submit">?듬? ???/button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
