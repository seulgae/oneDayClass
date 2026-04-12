<%-- 홈 화면 --%>
<%--@elvariable id="featuredClasses" type="java.util.List"--%>
<%--@elvariable id="offlineClasses" type="java.util.List"--%>
<%--@elvariable id="latestReviews" type="java.util.List"--%>
<%--@elvariable id="pendingLevelUps" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="include/header.jsp" %>
<section class="hero">
    <div class="hero-grid">
        <div class="hero-copy">
            <p class="eyebrow">OnedayClass</p>
            <h1>취향에 맞는 클래스를 더 빠르게 고르고, 더 편하게 예약하세요.</h1>
            <p>요즘 많이 찾는 클래스와 바로 신청 가능한 수업을 한눈에 살펴보고, 원하는 클래스로 빠르게 이동할 수 있도록 메인 화면을 구성했습니다.</p>
            <div class="hero-actions">
                <a class="btn" href="<c:url value='/classes' />">클래스 둘러보기</a>
                <a class="btn secondary" href="<c:url value='/reviews' />">후기 먼저 보기</a>
            </div>
        </div>
        <div class="hero-side">
            <div class="hero-highlight">
                <span class="hero-highlight-label">Today&apos;s pick</span>
                <strong>바로 신청 가능한 인기 클래스</strong>
                <p>온라인 키트 클래스부터 오프라인 소규모 워크숍까지, 최근 반응이 좋은 수업을 중심으로 추천합니다.</p>
            </div>
            <div class="hero-stats">
                <article>
                    <strong>${featuredClasses.size()}</strong>
                    <span>메인 추천 클래스</span>
                </article>
                <article>
                    <strong>${latestReviews.size()}</strong>
                    <span>최근 후기 미리보기</span>
                </article>
                <article>
                    <strong>${pendingLevelUps.size()}</strong>
                    <span>확인 중인 등업 요청</span>
                </article>
            </div>
        </div>
    </div>
</section>
<section class="grid-section">
    <div class="section-head">
        <h2>인기 온라인 클래스</h2>
        <a href="<c:url value='/classes?onoff=N' />">전체보기</a>
    </div>
    <div class="slider" data-slider data-interval="4000">
        <div class="slider-track">
            <c:forEach var="item" items="${featuredClasses}">
                <a class="card slider-card" href="<c:url value='/classes/${item.CNum}' />">
                    <c:if test="${not empty item.CThumbName}">
                        <img class="card-thumb" src="<c:url value='/uploads/classes/${item.CThumbName}' />" alt="${item.CTitle}">
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
    <div class="section-head">
        <h2>인기 온라인 키트 클래스</h2>
        <a href="<c:url value='/classes?onoff=Y' />">전체보기</a>
    </div>
    <div class="slider" data-slider data-interval="5000">
        <div class="slider-track">
            <c:forEach var="item" items="${offlineClasses}">
                <a class="card slider-card" href="<c:url value='/classes/${item.CNum}' />">
                    <c:if test="${not empty item.CThumbName}">
                        <img class="card-thumb" src="<c:url value='/uploads/classes/${item.CThumbName}' />" alt="${item.CTitle}">
                    </c:if>
                    <strong>${item.CTitle}</strong>
                    <span>${item.CTeacher}</span>
                    <span>${item.CArea}</span>
                </a>
            </c:forEach>
        </div>
    </div>
</section>
<script>
    document.querySelectorAll("[data-slider]").forEach(function (slider) {
        var track = slider.querySelector(".slider-track");
        var slides = Array.prototype.slice.call(track.children);
        if (slides.length <= 4) {
            return;
        }

        var pageSize = 4;
        var totalPages = Math.ceil(slides.length / pageSize);
        var currentPage = 0;
        var interval = Number(slider.dataset.interval || 4000);
        var startX = 0;
        var currentX = 0;
        var isDragging = false;
        var dragOffset = 0;

        function getBaseOffset() {
            return -slider.clientWidth * currentPage;
        }

        function updateSlider(offset) {
            var x = getBaseOffset() + (offset || 0);
            track.style.transform = "translateX(" + x + "px)";
        }

        function nextPage() {
            currentPage = (currentPage + 1) % totalPages;
            updateSlider();
        }

        function prevPage() {
            currentPage = (currentPage - 1 + totalPages) % totalPages;
            updateSlider();
        }

        function stopAuto() {
            clearInterval(slider._timer);
        }

        function startAuto() {
            stopAuto();
            slider._timer = setInterval(nextPage, interval);
        }

        function onPointerMove(event) {
            if (!isDragging) {
                return;
            }
            currentX = event.clientX;
            dragOffset = currentX - startX;
            track.style.transition = "none";
            updateSlider(dragOffset);
        }

        function onPointerUp() {
            if (!isDragging) {
                return;
            }

            isDragging = false;
            slider.classList.remove("is-dragging");
            track.style.transition = "";

            if (dragOffset <= -60) {
                nextPage();
            } else if (dragOffset >= 60) {
                prevPage();
            } else {
                updateSlider();
            }

            dragOffset = 0;
            window.removeEventListener("pointermove", onPointerMove);
            window.removeEventListener("pointerup", onPointerUp);
            window.removeEventListener("pointercancel", onPointerUp);
            startAuto();
        }

        slider.addEventListener("mouseenter", function () {
            stopAuto();
        });

        slider.addEventListener("mouseleave", function () {
            if (!isDragging) {
                startAuto();
            }
        });

        slider.addEventListener("pointerdown", function (event) {
            if (event.pointerType === "mouse" && event.button !== 0) {
                return;
            }

            isDragging = true;
            startX = event.clientX;
            currentX = event.clientX;
            dragOffset = 0;
            slider.classList.add("is-dragging");
            stopAuto();
            window.addEventListener("pointermove", onPointerMove);
            window.addEventListener("pointerup", onPointerUp);
            window.addEventListener("pointercancel", onPointerUp);
        });

        window.addEventListener("resize", updateSlider);

        updateSlider();
        startAuto();
    });
</script>
<%@ include file="include/footer.jspf" %>


