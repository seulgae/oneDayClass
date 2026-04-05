<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>Classes</h2><a class="btn" href="/classes/new">New class</a></div>
    <form class="toolbar" method="get" action="/classes">
        <input type="text" name="category" value="${selectedCategory}" placeholder="Category">
        <select name="onoff">
            <option value="">All</option>
            <option value="N" ${selectedOnOff eq 'N' ? 'selected' : ''}>Online</option>
            <option value="Y" ${selectedOnOff eq 'Y' ? 'selected' : ''}>Offline</option>
        </select>
        <button type="submit">Filter</button>
    </form>
    <div class="card-grid">
        <c:forEach var="item" items="${classes}">
            <a class="card" href="/classes/${item.CNum}">
                <strong>${item.CTitle}</strong>
                <span>${item.CTeacher}</span>
                <span>${item.CCategory} / ${item.CPrice} / likes ${item.CLikes}</span>
            </a>
        </c:forEach>
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
