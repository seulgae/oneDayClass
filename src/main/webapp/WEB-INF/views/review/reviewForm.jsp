<%-- 후기 작성 화면 --%>
<%--@elvariable id="reviewDto" type="com.example.onedayclass.review.dto.ReviewDto"--%>
<%--@elvariable id="classOptions" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel">
    <h2>후기 작성</h2>
    <form method="post" action="<c:url value='/reviews' />">
        <label>
            클래스 선택
            <select name="cNum" required>
                <option value="">후기를 작성할 클래스를 선택해 주세요.</option>
                <c:forEach var="classItem" items="${classOptions}">
                    <option value="${classItem.CNum}" ${reviewDto.CNum eq classItem.CNum ? 'selected' : ''}>${classItem.CTitle}</option>
                </c:forEach>
            </select>
        </label>
        <input type="text" name="rTitle" value="${reviewDto.RTitle}" placeholder="제목" required maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
        <textarea name="rContent" placeholder="후기 내용을 입력하세요" required minlength="10" maxlength="3000" title="후기 내용은 10자 이상 입력해 주세요.">${reviewDto.RContent}</textarea>
        <button type="submit">저장</button>
    </form>
</section>
<%@ include file="../include/footer.jspf" %>
