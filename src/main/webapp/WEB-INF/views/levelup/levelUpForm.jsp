<%-- 등업 신청 작성 화면 --%>
<%--@elvariable id="levelUpDto" type="com.example.onedayclass.levelup.dto.LevelUpDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-award-line" style="color:var(--primary);"></i> 강사 등업 신청 작성</h2>
        <p>활동하실 강사명과 SNS/포트폴리오, 진행하고 싶은 클래스 소개를 작성해 주시면 관리자가 확인 후 등업을 승인합니다.</p>
    </div>
    <form method="post" action="<c:url value='/levelups' />">
        <label class="field-block">
            <span class="field-label">신청 제목 <span class="required-mark">*</span></span>
            <input type="text" name="lvlTitle" placeholder="제목 (4~80자)" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <div class="form-grid">
            <label class="field-block">
                <span class="field-label">강사 활동명 <span class="required-mark">*</span></span>
                <input type="text" name="lvlName" value="${levelUpDto.lvlName}" placeholder="활동명 (2~50자)" required maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="활동명은 2~50자 이내로 입력해 주세요.">
            </label>
            <label class="field-block">
                <span class="field-label">SNS 또는 포트폴리오 URL</span>
                <input type="url" name="lvlSns" placeholder="https://" maxlength="255" title="올바른 URL 형식으로 입력해 주세요.">
            </label>
        </div>
        <label class="field-block">
            <span class="field-label">상세 신청 사유 및 경력 소개 <span class="required-mark">*</span></span>
            <textarea name="lvlContent" placeholder="개설 희망 클래스 분야와 강사 이력을 20자 이상 입력해 주세요." required minlength="20" maxlength="3000" title="요청 내용은 20자 이상 입력해 주세요."></textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 등업 신청 등록</button>
            <a class="btn secondary member-submit" href="<c:url value='/levelups' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
