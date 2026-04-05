<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel">
    <h2>Class Form</h2>
    <c:url var="formAction" value="/classes" />
    <c:if test="${classDto.CNum != null}">
        <c:url var="formAction" value="/classes/${classDto.CNum}/edit" />
    </c:if>
    <form method="post" action="${formAction}">
        <div class="form-grid">
            <input type="text" name="cTeacher" value="${classDto.CTeacher}" placeholder="Teacher">
            <input type="text" name="cCategory" value="${classDto.CCategory}" placeholder="Category">
            <input type="text" name="cTitle" value="${classDto.CTitle}" placeholder="Title">
            <select name="cOnoff">
                <option value="N" ${classDto.COnoff ne 'Y' ? 'selected' : ''}>Online</option>
                <option value="Y" ${classDto.COnoff eq 'Y' ? 'selected' : ''}>Offline</option>
            </select>
            <input type="number" name="cPrice" value="${classDto.CPrice}" placeholder="Price">
            <input type="number" name="cDelivery" value="${classDto.CDelivery}" placeholder="Delivery">
            <input type="number" name="cMaxStu" value="${classDto.CMaxStu}" placeholder="Max Students">
            <input type="text" name="cArea" value="${classDto.CArea}" placeholder="Area">
        </div>
        <textarea name="cContent" placeholder="Description">${classDto.CContent}</textarea>
        <button type="submit">Save</button>
    </form>
</section>
<jsp:include page="../include/footer.jsp" />
