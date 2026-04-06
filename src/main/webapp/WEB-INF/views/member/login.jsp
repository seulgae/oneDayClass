<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>로그인</h2>
    <c:if test="${param.error ne null}">
        <div class="flash">아이디 또는 비밀번호가 올바르지 않습니다.</div>
    </c:if>
    <form method="post" action="/members/login">
        <input type="text" name="uId" placeholder="아이디" required>
        <input type="password" name="uPw" placeholder="비밀번호" required>
        <div class="actions">
            <button type="submit">로그인</button>
            <a class="btn secondary" href="/members/join">회원가입</a>
        </div>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
