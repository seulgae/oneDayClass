<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>Level Up Board</h2><a class="btn" href="/levelups/new">New request</a></div>
    <table class="table">
        <thead><tr><th>No</th><th>Title</th><th>Writer</th><th>Status</th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${requests}">
            <tr>
                <td>${item.LvlNum}</td>
                <td><a href="/levelups/${item.LvlNum}">${item.LvlTitle}</a></td>
                <td>${item.LvlUid}</td>
                <td>${item.LvlStatus}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<jsp:include page="../include/footer.jsp" />
