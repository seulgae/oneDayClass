<%-- 공지사항 상세 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${notice.QTitle}</h2>
        <a class="btn secondary" href="/notices">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${notice.QUid}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(notice.QRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${notice.QContent}</dd></dl>
</section>
<%@ include file="../include/footer.jsp" %>

