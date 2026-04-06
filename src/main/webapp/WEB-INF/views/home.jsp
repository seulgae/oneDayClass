<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="include/header.jsp" />
<section class="hero">
    <div>
        <p class="eyebrow">OnedayClass</p>
        <h1>배우고 싶은 하루를 고르고, 바로 신청할 수 있는 클래스 플랫폼입니다.</h1>
        <p>인기 클래스, 최신 후기, 등업 신청 현황까지 한 화면에서 편하게 확인해보세요.</p>
    </div>
</section>
<section class="grid-section">
    <div class="section-head"><h2>인기 온라인 클래스</h2><a href="/classes?onoff=N">전체보기</a></div>
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
    <div class="section-head"><h2>인기 오프라인 클래스</h2><a href="/classes?onoff=Y">전체보기</a></div>
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
        <div class="section-head"><h2>최신 후기</h2><a href="/reviews">후기게시판</a></div>
        <c:forEach var="review" items="${latestReviews}">
            <a class="list-link" href="/reviews/${review.RNum}">${review.RTitle} <em>${review.RUid}</em></a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head"><h2>등업 신청 현황</h2><a href="/levelups">신청목록</a></div>
        <c:forEach var="request" items="${pendingLevelUps}">
            <a class="list-link" href="/levelups/${request.lvlNum}">${request.lvlTitle} <em>${request.lvlUid}</em></a>
        </c:forEach>
    </article>
</section>
<jsp:include page="include/footer.jsp" />
