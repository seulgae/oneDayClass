<%-- 홈 화면 --%>
<%--@elvariable id="featuredClasses" type="java.util.List"--%>
<%--@elvariable id="offlineClasses" type="java.util.List"--%>
<%--@elvariable id="latestReviews" type="java.util.List"--%>
<%--@elvariable id="pendingLevelUps" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="include/header.jsp" %>

<section class="hero">
    <div class="hero-grid">
        <div class="hero-copy">
            <p class="eyebrow">CURATED ONEDAY EXPERIENCE</p>
            <h1>취향에 맞는 클래스를 더 빠르게 고르고, 더 편하게 예약하세요.</h1>
            <p>요즘 많이 찾는 인기 온라인 클래스와 바로 신청 가능한 오프라인 소규모 워크숍을 한눈에 살펴보고, 원하는 클래스로 빠르게 이동할 수 있습니다.</p>
            <div class="hero-actions">
                <a class="btn" href="<c:url value='/classes' />"><i class="ri-compass-discover-line"></i> 클래스 둘러보기</a>
                <a class="btn secondary" href="<c:url value='/reviews' />"><i class="ri-chat-smile-3-line"></i> 수강생 후기 보기</a>
            </div>
        </div>
        <div class="hero-side">
            <div class="hero-highlight">
                <span class="hero-highlight-label"><i class="ri-fire-fill"></i> Today&apos;s Pick</span>
                <strong>바로 신청 가능한 인기 클래스</strong>
                <p>온라인 키트 클래스부터 오프라인 소규모 공방 워크숍까지, 최근 수강생 만족도가 높은 수업을 중심으로 추천합니다.</p>
            </div>
            <div class="hero-stats">
                <article>
                    <strong>${featuredClasses.size()}</strong>
                    <span>추천 온라인</span>
                </article>
                <article>
                    <strong>${latestReviews.size()}</strong>
                    <span>최근 베스트 후기</span>
                </article>
                <article>
                    <strong>${pendingLevelUps.size()}</strong>
                    <span>강사 등업 대기</span>
                </article>
            </div>
        </div>
    </div>
</section>

<div class="quick-categories">
    <a class="category-chip is-active" href="<c:url value='/classes' />"><i class="ri-apps-2-line"></i> 전체 클래스</a>
    <a class="category-chip" href="<c:url value='/classes?onoff=N' />"><i class="ri-macbook-line"></i> 온라인 클래스</a>
    <a class="category-chip" href="<c:url value='/classes?onoff=Y' />"><i class="ri-store-2-line"></i> 오프라인 공방</a>
    <a class="category-chip" href="<c:url value='/reviews' />"><i class="ri-star-smile-line"></i> 베스트 후기</a>
    <a class="category-chip" href="<c:url value='/requests' />"><i class="ri-lightbulb-flash-line"></i> 클래스 개설 요청</a>
    <a class="category-chip" href="<c:url value='/notices' />"><i class="ri-megaphone-line"></i> 공지 &amp; 이벤트</a>
</div>

<section class="grid-section">
    <div class="section-head">
        <div>
            <h2><i class="ri-vidicon-line"></i> 인기 온라인 클래스</h2>
            <p class="section-subtitle">집에서도 키트와 영상으로 편하게 배우는 인기 온라인 수업</p>
        </div>
        <a href="<c:url value='/classes?onoff=N' />">전체보기 <i class="ri-arrow-right-s-line"></i></a>
    </div>
    <div class="slider" data-slider data-interval="4000">
        <div class="slider-track">
            <c:forEach var="item" items="${featuredClasses}">
                <c:set var="thumbImageName" value="${empty item.CThumbName ? 'default-class-thumb.svg' : item.CThumbName}" />
                <a class="card slider-card" href="<c:url value='/classes/${item.CNum}' />">
                    <div class="card-thumb-wrap">
                        <img class="card-thumb" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="${item.CTitle}">
                    </div>
                    <div class="card-badges">
                        <span class="badge badge-indigo"><i class="ri-vidicon-line"></i> 온라인</span>
                        <span class="badge badge-slate">${item.CCategory}</span>
                    </div>
                    <strong>${item.CTitle}</strong>
                    <span><i class="ri-user-star-line"></i> ${item.CTeacher}</span>
                    <div class="card-price-row">
                        <span class="card-price"><fmt:formatNumber value="${item.CPrice}" />원</span>
                        <span class="card-likes"><i class="ri-heart-3-fill"></i> ${item.CLikes}</span>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<section class="grid-section">
    <div class="section-head">
        <div>
            <h2><i class="ri-map-pin-user-line"></i> 인기 오프라인 &amp; 원데이 워크숍</h2>
            <p class="section-subtitle">강사님과 직접 만나 체험하고 완성하는 생생한 현장 클래스</p>
        </div>
        <a href="<c:url value='/classes?onoff=Y' />">전체보기 <i class="ri-arrow-right-s-line"></i></a>
    </div>
    <div class="slider" data-slider data-interval="5000">
        <div class="slider-track">
            <c:forEach var="item" items="${offlineClasses}">
                <c:set var="thumbImageName" value="${empty item.CThumbName ? 'default-class-thumb.svg' : item.CThumbName}" />
                <a class="card slider-card" href="<c:url value='/classes/${item.CNum}' />">
                    <div class="card-thumb-wrap">
                        <img class="card-thumb" src="<c:url value='/uploads/classes/${thumbImageName}' />" alt="${item.CTitle}">
                    </div>
                    <div class="card-badges">
                        <span class="badge badge-primary"><i class="ri-map-pin-2-line"></i> ${empty item.CArea ? '오프라인' : item.CArea}</span>
                        <span class="badge badge-slate">${item.CCategory}</span>
                    </div>
                    <strong>${item.CTitle}</strong>
                    <span><i class="ri-user-star-line"></i> ${item.CTeacher}</span>
                    <div class="card-price-row">
                        <span class="card-price"><fmt:formatNumber value="${item.CPrice}" />원</span>
                        <span class="card-likes"><i class="ri-heart-3-fill"></i> ${item.CLikes}</span>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<c:if test="${not empty latestReviews}">
    <section class="two-column">
        <article class="panel">
            <div class="section-head">
                <div>
                    <h2><i class="ri-chat-quote-line"></i> 생생한 최근 수강후기</h2>
                    <p class="section-subtitle">수강생들이 직접 남긴 솔직한 클래스 경험담</p>
                </div>
                <a href="<c:url value='/reviews' />">더보기 <i class="ri-arrow-right-s-line"></i></a>
            </div>
            <div class="stack-list">
                <c:forEach var="rev" items="${latestReviews}">
                    <a class="list-link" href="<c:url value='/reviews/${rev.RNum}' />">
                        <span><i class="ri-double-quotes-l" style="color:var(--primary); margin-right:6px;"></i>${rev.RTitle}</span>
                        <em><i class="ri-user-line"></i> ${rev.RUid} &middot; <i class="ri-heart-fill" style="color:var(--primary);"></i> ${rev.RLikes}</em>
                    </a>
                </c:forEach>
            </div>
        </article>
        <article class="panel">
            <div class="section-head">
                <div>
                    <h2><i class="ri-award-line"></i> 강사 파트너 등업 현황</h2>
                    <p class="section-subtitle">나만의 재능으로 원데이 클래스 강사에 도전해보세요</p>
                </div>
                <a href="<c:url value='/levelups' />">등업게시판 <i class="ri-arrow-right-s-line"></i></a>
            </div>
            <div class="stack-list">
                <c:choose>
                    <c:when test="${empty pendingLevelUps}">
                        <p class="muted">현재 대기 중인 등업 신청이 없습니다. 첫 번째 파트너 강사로 신청해보세요!</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="lvl" items="${pendingLevelUps}">
                            <a class="list-link" href="<c:url value='/levelups/${lvl.lvlNum}' />">
                                <span><i class="ri-sparkling-line" style="color:var(--indigo); margin-right:6px;"></i>${lvl.lvlTitle}</span>
                                <em><span class="badge badge-warn">심사대기</span> ${lvl.lvlUid}</em>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </article>
    </section>
</c:if>

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
