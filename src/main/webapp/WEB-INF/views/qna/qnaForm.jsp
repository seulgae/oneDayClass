<%-- QnA 작성 화면 --%>
<%--@elvariable id="qnaDto" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%--@elvariable id="qnaCategories" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>문의 작성</h2>
    <form method="post" action="<c:url value='/qna' />">
        <c:if test="${not empty message}">
            <p class="form-error">${message}</p>
        </c:if>
        <input type="hidden" name="cNum" value="${qnaDto.CNum}">
        <dl>
            <dt>대상 클래스</dt>
            <dd><a href="<c:url value='/classes/${qnaDto.CNum}' />">${qnaDto.CTitle}</a></dd>
        </dl>
        <label>
            문의 분류
            <select name="qCategory" required>
                <option value="">문의 분류를 선택해 주세요.</option>
                <c:forEach var="category" items="${qnaCategories}">
                    <option value="${category}" ${qnaDto.QCategory eq category ? 'selected' : ''}>${category}</option>
                </c:forEach>
            </select>
        </label>
        <input type="text" name="qTitle" value="${qnaDto.QTitle}" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="qContent" placeholder="문의 내용을 입력해 주세요." rows="8" required minlength="10" maxlength="3000" title="문의 내용은 10자 이상 입력해 주세요.">${qnaDto.QContent}</textarea>
        <button type="submit">등록</button>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
