<%-- 클래스 등록 및 수정 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>클래스 등록</h2>
    <c:url var="formAction" value="/classes" />
    <c:if test="${classDto.CNum != null}">
        <c:url var="formAction" value="/classes/${classDto.CNum}/edit" />
    </c:if>
    <form method="post" action="${formAction}" enctype="multipart/form-data">
        <div class="form-grid">
        <input type="text" name="cTeacher" value="${classDto.CTeacher}" placeholder="강사명" required maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="강사명은 2~50자 이내로 입력해 주세요.">
        <input type="text" name="cCategory" value="${classDto.CCategory}" placeholder="카테고리" required maxlength="30" pattern="^[가-힣a-zA-Z0-9\s]{2,30}$" title="카테고리는 2~30자 이내로 입력해 주세요.">
            <input type="text" name="cTitle" value="${classDto.CTitle}" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
            <select name="cOnoff" required>
                <option value="N" ${classDto.COnoff ne 'Y' ? 'selected' : ''}>온라인</option>
                <option value="Y" ${classDto.COnoff eq 'Y' ? 'selected' : ''}>오프라인</option>
            </select>
            <input type="number" name="cPrice" value="${classDto.CPrice}" placeholder="가격" required min="0" max="10000000" title="가격은 0원 이상 입력해 주세요.">
            <input type="number" name="cDelivery" value="${classDto.CDelivery}" placeholder="배송비" required min="0" max="1000000" title="배송비는 0원 이상 입력해 주세요.">
            <input type="number" name="cMaxStu" value="${classDto.CMaxStu}" placeholder="최대 수강 인원" required min="1" max="999" title="최대 수강 인원은 1명 이상 입력해 주세요.">
        <input type="text" name="cArea" value="${classDto.CArea}" placeholder="지역" required maxlength="40" pattern="^[가-힣a-zA-Z0-9\s]{2,40}$" title="지역은 2~40자 이내로 입력해 주세요.">
        </div>
        <div class="form-grid">
            <div class="file-field">
                <label for="thumbnailImage">썸네일 이미지</label>
                <input id="thumbnailImage" type="file" name="thumbnailImage" accept="image/*">
                <c:if test="${not empty classDto.CThumbName}">
                    <img class="form-preview" src="/uploads/classes/${classDto.CThumbName}" alt="썸네일 미리보기">
                </c:if>
            </div>
            <div class="file-field">
                <label for="detailImage">소개 이미지</label>
                <input id="detailImage" type="file" name="detailImage" accept="image/*">
                <c:if test="${not empty classDto.CFileName}">
                    <img class="form-preview" src="/uploads/classes/${classDto.CFileName}" alt="소개 이미지 미리보기">
                </c:if>
            </div>
        </div>
        <textarea name="cContent" placeholder="클래스 소개" required minlength="20" maxlength="3000" title="클래스 소개는 20자 이상 입력해 주세요.">${classDto.CContent}</textarea>
        <button type="submit">저장</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>

