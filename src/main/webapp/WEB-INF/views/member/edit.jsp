<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>회원정보 수정</h2>
    <form method="post" action="/members/edit">
        <div class="form-grid">
            <input type="password" name="uPw" value="${memberDto.UPw}" placeholder="비밀번호">
            <input type="text" name="uPhone" value="${memberDto.UPhone}" placeholder="휴대폰 번호">
            <input type="text" name="uZip" value="${memberDto.UZip}" placeholder="우편번호">
            <input type="email" name="uEmail" value="${memberDto.UEmail}" placeholder="이메일">
        </div>
        <input type="text" name="uAddr1" value="${memberDto.UAddr1}" placeholder="기본주소">
        <input type="text" name="uAddr2" value="${memberDto.UAddr2}" placeholder="상세주소">
        <button type="submit">저장</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
