<%-- 요청 게시판 작성 화면 --%>
<%--@elvariable id="requestBoardDto" type="com.example.onedayclass.requestboard.dto.RequestBoardDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-lightbulb-flash-line" style="color:var(--primary);"></i> 요청 올리기</h2>
        <p>개설을 희망하는 클래스 분야나 필요한 기능, 개선 아이디어를 자세히 적어 주세요.</p>
    </div>
    <form method="post" action="<c:url value='/requests' />">
        <label class="field-block">
            <span class="field-label">요청 제목 <span class="required-mark">*</span></span>
            <input type="text" name="reqTitle" placeholder="제목 (4~80자)" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <label class="field-block">
            <span class="field-label">요청 내용 <span class="required-mark">*</span></span>
            <textarea name="reqContent" placeholder="예: 이런 클래스나 기능이 있으면 더 편하게 사용할 수 있을 것 같아요." rows="8" required minlength="10" maxlength="3000" title="요청 내용은 10자 이상 입력해 주세요."></textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 등록하기</button>
            <a class="btn secondary member-submit" href="<c:url value='/requests' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
