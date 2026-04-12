<%-- 공통 오류 안내 화면 --%>
<%--@elvariable id="errorTitle" type="java.lang.String"--%>
<%--@elvariable id="errorMessage" type="java.lang.String"--%>
<%--@elvariable id="backUrl" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <div class="member-form-hero">
        <h2>${empty errorTitle ? '오류가 발생했습니다.' : errorTitle}</h2>
        <p>${empty errorMessage ? '요청을 처리하지 못했습니다. 잠시 후 다시 시도해 주세요.' : errorMessage}</p>
    </div>
    <div class="actions">
        <a class="btn secondary" href="${empty backUrl ? '/' : backUrl}">이전 화면으로</a>
    <a class="btn" href="<c:url value='/' />">홈으로 이동</a>
    </div>
</section>
<%@ include file="../include/footer.jspf" %>

