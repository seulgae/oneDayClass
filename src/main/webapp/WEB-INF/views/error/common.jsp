<%-- 공통 오류 안내 화면 --%>
<%--@elvariable id="errorTitle" type="java.lang.String"--%>
<%--@elvariable id="errorMessage" type="java.lang.String"--%>
<%--@elvariable id="backUrl" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel auth-card-wrap" style="text-align:center;">
    <div style="display:inline-flex; margin:0 auto 12px; width:56px; height:56px; border-radius:16px; background:var(--danger-soft); color:var(--danger); align-items:center; justify-content:center; font-size:28px;">
        <i class="ri-error-warning-line"></i>
    </div>
    <div class="member-form-hero" style="border-bottom:0;">
        <h2>${empty errorTitle ? '오류가 발생했습니다.' : errorTitle}</h2>
        <p>${empty errorMessage ? '요청을 처리하지 못했습니다. 잠시 후 다시 시도해 주세요.' : errorMessage}</p>
    </div>
    <div class="actions" style="justify-content:center; margin-top:16px;">
        <a class="btn secondary" href="${empty backUrl ? '/' : backUrl}"><i class="ri-arrow-left-line"></i> 이전 화면으로</a>
        <a class="btn" href="<c:url value='/' />"><i class="ri-home-4-line"></i> 홈으로 이동</a>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>
