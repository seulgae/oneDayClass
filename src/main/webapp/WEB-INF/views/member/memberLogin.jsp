<%-- 회원 로그인 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>로그인</h2>
    <c:if test="${param.error ne null}">
        <div class="flash">아이디 또는 비밀번호가 올바르지 않습니다.</div>
    </c:if>
    <form method="post" action="/members/login">
        <input type="text" name="uId" placeholder="아이디" required minlength="4" maxlength="20" pattern="^[a-zA-Z0-9]{4,20}$" title="아이디는 영문과 숫자 4~20자입니다." autocomplete="username">
        <input type="password" name="uPw" placeholder="비밀번호" required minlength="8" maxlength="20" title="비밀번호를 입력해 주세요." autocomplete="current-password">
        <div class="actions">
            <button type="submit">로그인</button>
            <a class="btn secondary" href="/members/join">회원가입</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>

