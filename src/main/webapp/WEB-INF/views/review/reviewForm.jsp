<%-- 후기 작성 화면 --%>
<%--@elvariable id="reviewDto" type="com.example.onedayclass.review.dto.ReviewDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2><i class="ri-quill-pen-line" style="color:var(--primary);"></i> 수강 후기 작성</h2>
        <p>클래스를 통해 경험한 솔직한 후기를 남겨주시면 다른 수강생들에게 큰 도움이 됩니다.</p>
    </div>
    <form method="post" action="<c:url value='/reviews' />">
        <input type="hidden" name="cNum" value="${reviewDto.CNum}">
        <div class="detail" style="background:var(--surface-soft); padding:14px 20px; border-radius:var(--radius-md); border:1px solid var(--line);">
            <dl style="padding:0; border:0;">
                <dt><i class="ri-book-open-line"></i> 대상 클래스</dt>
                <dd><a href="<c:url value='/classes/${reviewDto.CNum}' />">${reviewDto.CTitle}</a></dd>
            </dl>
        </div>
        <label class="field-block">
            <span class="field-label">후기 제목 <span class="required-mark">*</span></span>
            <input type="text" name="rTitle" value="${reviewDto.RTitle}" placeholder="후기 제목을 입력해 주세요 (4~80자)" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        </label>
        <label class="field-block">
            <span class="field-label">상세 후기 내용 <span class="required-mark">*</span></span>
            <textarea name="rContent" placeholder="수업 분위기, 강사님의 설명, 완성작에 대한 만족도 등 후기 내용을 10자 이상 입력해 주세요." required minlength="10" maxlength="3000" title="후기 내용은 10자 이상 입력해 주세요.">${reviewDto.RContent}</textarea>
        </label>
        <div class="actions">
            <button type="submit" class="member-submit" style="flex:1;"><i class="ri-check-line"></i> 후기 등록하기</button>
            <a class="btn secondary member-submit" href="<c:url value='/reviews' />">취소</a>
        </div>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
