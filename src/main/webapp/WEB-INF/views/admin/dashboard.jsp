<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="two-column">
    <article class="panel">
        <h2>Pending Classes</h2>
        <c:forEach var="item" items="${pendingClasses}">
            <div class="list-link">
                ${item.CTitle}<em>${item.CUid}</em>
                <form method="post" action="/admin/classes/${item.CNum}/approve" class="inline-form">
                    <button type="submit">Approve</button>
                </form>
            </div>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>Pending Level Up</h2>
        <c:forEach var="item" items="${pendingLevelUps}">
            <a class="list-link" href="/levelups/${item.LvlNum}">${item.LvlTitle}<em>${item.LvlUid}</em></a>
        </c:forEach>
    </article>
</section>
<section class="two-column">
    <article class="panel">
        <h2>QnA</h2>
        <c:forEach var="item" items="${questions}">
            <a class="list-link" href="/qna/${item.QNum}">${item.QTitle}<em>${item.QUid}</em></a>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>Reviews</h2>
        <c:forEach var="item" items="${reviews}">
            <a class="list-link" href="/reviews/${item.RNum}">${item.RTitle}<em>${item.RUid}</em></a>
        </c:forEach>
    </article>
</section>
<jsp:include page="../include/footer.jsp" />
