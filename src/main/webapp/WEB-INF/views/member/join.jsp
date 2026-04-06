<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>회원가입</h2>
    <form method="post" action="/members/join">
        <div class="form-grid">
            <input type="text" name="uId" placeholder="아이디" required>
            <input type="password" name="uPw" placeholder="비밀번호" required>
            <input type="text" name="uName" placeholder="이름" required>
            <input type="text" name="uPhone" placeholder="휴대폰 번호">
            <input type="text" name="uZip" placeholder="우편번호">
            <input type="email" name="uEmail" placeholder="이메일">
        </div>
        <input type="text" name="uAddr1" placeholder="기본주소">
        <input type="text" name="uAddr2" placeholder="상세주소">
        <button type="submit">가입하기</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
