<%-- QnA 작성 화면 --%>
<%--@elvariable id="qnaDto" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>문의 작성</h2>
    <form method="post" action="<c:url value='/qna' />">
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <input type="text" name="qTitle" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="qContent" placeholder="문의 내용을 입력해 주세요." rows="8" required minlength="10" maxlength="3000" title="문의 내용은 10자 이상 입력해 주세요."></textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>

