<%-- 관리자 대시보드 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="two-column">
    <article class="panel">
        <h2>승인 대기 클래스</h2>
        <c:forEach var="item" items="${pendingClasses}">
            <div class="list-link">
                ${item.CTitle}<em>${item.CUid}</em>
                <form method="post" action="/admin/classes/${item.CNum}/approve" class="inline-form">
                    <button type="submit">승인</button>
                </form>
            </div>
        </c:forEach>
    </article>
    <article class="panel">
        <h2>등업 신청 대기</h2>
        <c:forEach var="item" items="${pendingLevelUps}">
            <a class="list-link" href="/levelups/${item.lvlNum}">${item.lvlTitle}<em>${item.lvlUid}</em></a>
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
        <h2>후기</h2>
        <c:forEach var="item" items="${reviews}">
            <a class="list-link" href="/reviews/${item.RNum}">${item.RTitle}<em>${item.RUid}</em></a>
        </c:forEach>
    </article>
</section>
<%@ include file="../include/footer.jsp" %>

