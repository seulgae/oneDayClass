<%-- 클래스 등록 및 수정 화면 --%>
<%--@elvariable id="classDto" type="com.example.onedayclass.clazz.dto.ClassDto"--%>
<%--@elvariable id="formAction" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-Presentation-line" style="color:var(--primary);"></i> ${classDto.CNum != null ? '클래스 수정' : '새 클래스 등록'}</h2>
        <p>수강생들에게 매력적으로 보일 수 있도록 클래스 기본 정보와 대표 썸네일, 상세 커리큘럼을 입력해 주세요.</p>
    </div>
    <c:set var="thumbImageName" value="${empty classDto.CThumbName ? 'default-class-thumb.svg' : classDto.CThumbName}" />
    <c:set var="detailImageName" value="${empty classDto.CFileName ? 'default-class-detail.svg' : classDto.CFileName}" />
    <c:url var="formAction" value="/classes" />
    <c:if test="${classDto.CNum != null}">
        <c:url var="formAction" value="/classes/${classDto.CNum}/edit" />
    </c:if>
    <form method="post" action="${formAction}" enctype="multipart/form-data">
        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>기본 클래스 정보</h3>
                    <p class="section-copy">강사명, 카테고리, 온/오프라인 여부와 수강료를 설정합니다.</p>
                </div>
            </div>
            <div class="form-grid">
                <label class="field-block">
                    <span class="field-label">강사명 <span class="required-mark">*</span></span>
                    <input type="text" name="cTeacher" value="${classDto.CTeacher}" placeholder="강사명" required maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="강사명은 2~50자 이내로 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">카테고리 <span class="required-mark">*</span></span>
                    <input type="text" name="cCategory" value="${classDto.CCategory}" placeholder="예: 공예, 베이킹, 드로잉" required maxlength="30" pattern="^[가-힣a-zA-Z0-9\s]{2,30}$" title="카테고리는 2~30자 이내로 입력해 주세요.">
                </label>
                <label class="field-block" style="grid-column: 1 / -1;">
                    <span class="field-label">클래스 제목 <span class="required-mark">*</span></span>
                    <input type="text" name="cTitle" value="${classDto.CTitle}" placeholder="수강생의 눈길을 사로잡는 클래스 제목 (4~80자)" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">진행 방식 <span class="required-mark">*</span></span>
                    <select name="cOnoff" required>
                        <option value="N" ${classDto.COnoff ne 'Y' ? 'selected' : ''}>온라인</option>
                        <option value="Y" ${classDto.COnoff eq 'Y' ? 'selected' : ''}>오프라인</option>
                    </select>
                </label>
                <label class="field-block">
                    <span class="field-label">진행 지역 / 플랫폼 <span class="required-mark">*</span></span>
                    <input type="text" name="cArea" value="${classDto.CArea}" placeholder="예: 서울 성수동 / 온라인 VOD" required maxlength="40" pattern="^[가-힣a-zA-Z0-9\s]{2,40}$" title="지역은 2~40자 이내로 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">수강료 (원) <span class="required-mark">*</span></span>
                    <input type="number" name="cPrice" value="${classDto.CPrice}" placeholder="가격" required min="0" max="10000000" title="가격은 0원 이상 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">키트 배송비 (원) <span class="required-mark">*</span></span>
                    <input type="number" name="cDelivery" value="${classDto.CDelivery}" placeholder="배송비" required min="0" max="1000000" title="배송비는 0원 이상 입력해 주세요.">
                </label>
                <label class="field-block">
                    <span class="field-label">최대 수강 정원 (명) <span class="required-mark">*</span></span>
                    <input type="number" name="cMaxStu" value="${classDto.CMaxStu}" placeholder="최대 수강 인원" required min="1" max="999" title="최대 수강 인원은 1명 이상 입력해 주세요.">
                </label>
            </div>
        </section>

        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>클래스 이미지 및 상세 소개</h3>
                    <p class="section-copy">썸네일과 소개 이미지를 등록하고 상세 커리큘럼을 작성해 주세요.</p>
                </div>
            </div>
            <div class="form-grid">
                <div class="file-field">
                    <label for="thumbnailImage"><i class="ri-image-add-line"></i> 썸네일 이미지</label>
                    <input id="thumbnailImage" type="file" name="thumbnailImage" accept="image/*">
                    <img class="form-preview" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="썸네일 미리보기">
                </div>
                <div class="file-field">
                    <label for="detailImage"><i class="ri-gallery-upload-line"></i> 소개 이미지</label>
                    <input id="detailImage" type="file" name="detailImage" accept="image/*">
                    <img class="form-preview" src="<c:url value='/uploads/classes/${detailImageName}' />" alt="소개 이미지 미리보기">
                </div>
            </div>
            <label class="field-block">
                <span class="field-label">클래스 상세 소개 <span class="required-mark">*</span></span>
                <textarea name="cContent" placeholder="클래스 소개 및 커리큘럼을 20자 이상 자세히 작성해 주세요." required minlength="20" maxlength="3000" title="클래스 소개는 20자 이상 입력해 주세요.">${classDto.CContent}</textarea>
            </label>
        </section>

        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 저장하기</button>
            <a class="btn secondary member-submit" href="<c:url value='/classes' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
