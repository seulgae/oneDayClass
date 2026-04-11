<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>濡쒓렇??/h2>
    <c:if test="${param.error ne null}">
        <div class="flash">?꾩씠???먮뒗 鍮꾨?踰덊샇媛 ?щ컮瑜댁? ?딆뒿?덈떎.</div>
    </c:if>
    <form method="post" action="/members/login">
        <input type="text" name="uId" placeholder="?꾩씠??" required minlength="4" maxlength="20" pattern="^[a-zA-Z0-9]{4,20}$" title="?꾩씠?붾뒗 ?곷Ц怨??レ옄 4~20?먯엯?덈떎." autocomplete="username">
        <input type="password" name="uPw" placeholder="鍮꾨?踰덊샇" required minlength="8" maxlength="20" title="鍮꾨?踰덊샇瑜??낅젰??二쇱꽭??" autocomplete="current-password">
        <div class="actions">
            <button type="submit">濡쒓렇??/button>
            <a class="btn secondary" href="/members/join">?뚯썝媛??/a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
