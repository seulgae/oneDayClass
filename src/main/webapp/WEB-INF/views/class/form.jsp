<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>클래스 등록</h2>
    <c:url var="formAction" value="/classes" />
    <c:if test="${classDto.CNum != null}">
        <c:url var="formAction" value="/classes/${classDto.CNum}/edit" />
    </c:if>
    <form method="post" action="${formAction}">
        <div class="form-grid">
            <input type="text" name="cTeacher" value="${classDto.CTeacher}" placeholder="강사명">
            <input type="text" name="cCategory" value="${classDto.CCategory}" placeholder="카테고리">
            <input type="text" name="cTitle" value="${classDto.CTitle}" placeholder="제목">
            <select name="cOnoff">
                <option value="N" ${classDto.COnoff ne 'Y' ? 'selected' : ''}>온라인</option>
                <option value="Y" ${classDto.COnoff eq 'Y' ? 'selected' : ''}>오프라인</option>
            </select>
            <input type="number" name="cPrice" value="${classDto.CPrice}" placeholder="가격">
            <input type="number" name="cDelivery" value="${classDto.CDelivery}" placeholder="배송비">
            <input type="number" name="cMaxStu" value="${classDto.CMaxStu}" placeholder="최대 수강 인원">
            <input type="text" name="cArea" value="${classDto.CArea}" placeholder="지역">
        </div>
        <textarea name="cContent" placeholder="클래스 소개">${classDto.CContent}</textarea>
        <button type="submit">저장</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
