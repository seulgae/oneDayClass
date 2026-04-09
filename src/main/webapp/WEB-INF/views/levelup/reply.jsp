<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>등업 신청 답변</h2>
    <p class="muted">원글: ${parent.lvlTitle}</p>
    <form method="post" action="/levelups/${parent.lvlNum}/reply">
        <input type="text" name="lvlTitle" placeholder="답변 제목" required>
        <input type="text" name="lvlName" placeholder="브랜드명">
        <input type="text" name="lvlSns" placeholder="SNS">
        <textarea name="lvlContent" placeholder="답변 내용을 입력하세요" required></textarea>
        <button type="submit">답변 저장</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
