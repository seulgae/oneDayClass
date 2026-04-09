<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>등업 신청 작성</h2>
    <form method="post" action="/levelups">
        <input type="text" name="lvlTitle" placeholder="제목" required>
        <input type="text" name="lvlName" value="${levelUpDto.lvlName}" placeholder="브랜드명">
        <input type="text" name="lvlSns" placeholder="SNS">
        <textarea name="lvlContent" placeholder="신청 내용을 입력하세요" required></textarea>
        <button type="submit">저장</button>
    </form>
</section>
<%@ include file="../include/footer.jsp" %>
