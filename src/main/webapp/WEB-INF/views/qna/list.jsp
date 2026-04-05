<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>QnA Board</h2><a class="btn" href="/qna/new">New question</a></div>
    <table class="table">
        <thead><tr><th>No</th><th>Title</th><th>Writer</th><th>Status</th><th>Date</th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${questions}">
            <tr>
                <td>${item.QNum}</td>
                <td><a href="/qna/${item.QNum}">${item.QTitle}</a></td>
                <td>${item.QUid}</td>
                <td>${item.QStatus}</td>
                <td>${item.QRegDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<jsp:include page="../include/footer.jsp" />
