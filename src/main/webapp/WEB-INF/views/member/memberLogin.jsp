<%-- 회원 로그인 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel auth-card-wrap">
    <div class="member-form-hero" style="text-align:center;">
        <div style="display:inline-flex; margin:0 auto 6px; width:48px; height:48px; border-radius:14px; background:var(--primary-soft); color:var(--primary); align-items:center; justify-content:center; font-size:24px;">
            <i class="ri-lock-unlock-line"></i>
        </div>
        <h2>로그인</h2>
        <p>OnedayClass 계정으로 로그인하고 다양한 클래스를 만나보세요.</p>
    </div>
    <c:if test="${param.error ne null}">
        <div class="flash" style="margin-top:16px;">
            <i class="ri-error-warning-line"></i>
            <span>아이디 또는 비밀번호가 올바르지 않습니다.</span>
        </div>
    </c:if>
    <form method="post" action="<c:url value='/members/login' />" style="margin-top:18px;">
        <label class="field-block">
            <span class="field-label">아이디</span>
            <input type="text" name="uId" placeholder="아이디 입력 (영문/숫자 4~20자)" required minlength="4" maxlength="20" pattern="^[a-zA-Z0-9]{4,20}$" title="아이디는 영문과 숫자 4~20자입니다." autocomplete="username">
        </label>
        <label class="field-block">
            <span class="field-label">비밀번호</span>
            <input type="password" name="uPw" placeholder="비밀번호 입력" required minlength="8" maxlength="20" title="비밀번호를 입력해 주세요." autocomplete="current-password">
        </label>
        <div class="actions" style="flex-direction:column; align-items:stretch; gap:10px; margin-top:6px;">
            <button type="submit" class="member-submit"><i class="ri-login-box-line"></i> 로그인</button>
            <a class="btn secondary member-submit" href="<c:url value='/members/join' />"><i class="ri-user-add-line"></i> 아직 회원이 아니신가요? 회원가입</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
