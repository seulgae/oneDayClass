<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="include/header.jsp" />
<section class="hero">
    <div>
        <p class="eyebrow">Spring MVC Refactor</p>
        <h1>oneDayClass legacy project has been reorganized into domain-based MVC layers.</h1>
        <p>Controllers, services, mappers, and JSP views are now separated for member, class, review, qna, payment, level-up, and admin flows.</p>
    </div>
</section>
<section class="grid-section">
    <div class="section-head"><h2>Featured Online Classes</h2><a href="/classes?onoff=N">View all</a></div>
    <div class="card-grid">
        <c:forEach var="item" items="${featuredClasses}">
            <a class="card" href="/classes/${item.CNum}">
                <strong>${item.CTitle}</strong>
                <span>${item.CTeacher}</span>
                <span>${item.CCategory} / ${item.CPrice}</span>
            </a>
        </c:forEach>
    </div>
</section>
<section class="grid-section">
    <div class="section-head"><h2>Featured Offline Classes</h2><a href="/classes?onoff=Y">View all</a></div>
    <div class="card-grid">
        <c:forEach var="item" items="${offlineClasses}">
            <a class="card" href="/classes/${item.CNum}">
                <strong>${item.CTitle}</strong>
                <span>${item.CTeacher}</span>
                <span>${item.CArea}</span>
            </a>
        </c:forEach>
    </div>
</section>
<section class="two-column">
    <article class="panel">
        <div class="section-head"><h2>Recent Reviews</h2><a href="/reviews">Review board</a></div>
        <c:forEach var="review" items="${latestReviews}">
            <a class="list-link" href="/reviews/${review.RNum}">${review.RTitle} <em>${review.RUid}</em></a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head"><h2>Pending Level Up</h2><a href="/levelups">Requests</a></div>
        <c:forEach var="request" items="${pendingLevelUps}">
            <a class="list-link" href="/levelups/${request.LvlNum}">${request.LvlTitle} <em>${request.LvlUid}</em></a>
        </c:forEach>
    </article>
</section>
<jsp:include page="include/footer.jsp" />
