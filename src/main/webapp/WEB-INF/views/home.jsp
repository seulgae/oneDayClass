<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="include/header.jsp" />
<section class="hero">
    <div>
        <p class="eyebrow">OnedayClass</p>
        <h1>배우고 싶은 하루를 고르고 바로 신청할 수 있는 원데이 클래스 플랫폼입니다.</h1>
        <p>인기 클래스, 최신 후기, 등업 요청 현황까지 한 화면에서 빠르게 확인할 수 있습니다.</p>
    </div>
</section>
<section class="grid-section">
    <div class="section-head"><h2>인기 온라인 클래스</h2><a href="/classes?onoff=N">전체보기</a></div>
    <div class="slider" data-slider data-interval="4000">
        <div class="slider-track">
            <c:forEach var="item" items="${featuredClasses}">
                <a class="card slider-card" href="/classes/${item.CNum}">
                    <c:if test="${not empty item.CThumbName}">
                        <img class="card-thumb" src="/uploads/classes/${item.CThumbName}" alt="${item.CTitle}">
                    </c:if>
                    <strong>${item.CTitle}</strong>
                    <span>${item.CTeacher}</span>
                    <span>${item.CCategory} / ${item.CPrice}원</span>
                </a>
            </c:forEach>
        </div>
    </div>
</section>
<section class="grid-section">
    <div class="section-head"><h2>인기 오프라인 클래스</h2><a href="/classes?onoff=Y">전체보기</a></div>
    <div class="slider" data-slider data-interval="5000">
        <div class="slider-track">
            <c:forEach var="item" items="${offlineClasses}">
                <a class="card slider-card" href="/classes/${item.CNum}">
                    <c:if test="${not empty item.CThumbName}">
                        <img class="card-thumb" src="/uploads/classes/${item.CThumbName}" alt="${item.CTitle}">
                    </c:if>
                    <strong>${item.CTitle}</strong>
                    <span>${item.CTeacher}</span>
                    <span>${item.CArea}</span>
                </a>
            </c:forEach>
        </div>
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
        <div class="section-head"><h2>등업 요청 현황</h2><a href="/levelups">요청목록</a></div>
        <c:forEach var="request" items="${pendingLevelUps}">
            <a class="list-link" href="/levelups/${request.lvlNum}">${request.lvlTitle} <em>${request.lvlUid}</em></a>
        </c:forEach>
    </article>
</section>
<script>
    document.querySelectorAll('[data-slider]').forEach(function(slider) {
        var track = slider.querySelector('.slider-track');
        var slides = Array.prototype.slice.call(track.children);
        if (slides.length <= 4) {
            return;
        }

        var pageSize = 4;
        var totalPages = Math.ceil(slides.length / pageSize);
        var currentPage = 0;
        var interval = Number(slider.dataset.interval || 4000);

        function updateSlider() {
            track.style.transform = 'translateX(' + (-slider.clientWidth * currentPage) + 'px)';
        }

        function nextPage() {
            currentPage = (currentPage + 1) % totalPages;
            updateSlider();
        }

        slider.addEventListener('mouseenter', function() {
            clearInterval(slider._timer);
        });

        slider.addEventListener('mouseleave', function() {
            slider._timer = setInterval(nextPage, interval);
        });

        window.addEventListener('resize', updateSlider);

        updateSlider();
        slider._timer = setInterval(nextPage, interval);
    });
</script>
<jsp:include page="include/footer.jsp" />
