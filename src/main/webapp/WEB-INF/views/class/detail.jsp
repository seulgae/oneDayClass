<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel detail">
    <div class="section-head"><h2>${classItem.CTitle}</h2><a class="btn secondary" href="/classes">Back</a></div>
    <dl><dt>Teacher</dt><dd>${classItem.CTeacher}</dd></dl>
    <dl><dt>Category</dt><dd>${classItem.CCategory}</dd></dl>
    <dl><dt>Price</dt><dd>${classItem.CPrice} / delivery ${classItem.CDelivery}</dd></dl>
    <dl><dt>Mode</dt><dd>${classItem.COnoff} / ${classItem.CArea}</dd></dl>
    <dl><dt>Capacity</dt><dd>${classItem.CApplyStu} / ${classItem.CMaxStu}</dd></dl>
    <dl><dt>Description</dt><dd>${classItem.CContent}</dd></dl>
    <div class="actions">
        <form method="post" action="/classes/${classItem.CNum}/like" class="inline-form"><button type="submit">Like</button></form>
        <form method="post" action="/payments/cart/${classItem.CNum}" class="inline-form"><button type="submit">Add cart</button></form>
        <a class="btn secondary" href="/reviews/new?cNum=${classItem.CNum}">Write review</a>
        <a class="btn secondary" href="/qna/new?cNum=${classItem.CNum}">Write qna</a>
    </div>
</section>
<section class="two-column">
    <article class="panel">
        <div class="section-head"><h2>Reviews</h2><a href="/reviews">All reviews</a></div>
        <c:forEach var="review" items="${reviews}">
            <a class="list-link" href="/reviews/${review.RNum}">${review.RTitle}<em>${review.RUid}</em></a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head"><h2>Questions</h2><a href="/qna">All qna</a></div>
        <c:forEach var="question" items="${questions}">
            <a class="list-link" href="/qna/${question.QNum}">${question.QTitle}<em>${question.QUid}</em></a>
        </c:forEach>
    </article>
</section>
<jsp:include page="../include/footer.jsp" />
