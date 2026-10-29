<%-- 관리자 대시보드 화면 --%>
<%--@elvariable id="pendingClasses" type="java.util.List"--%>
<%--@elvariable id="pendingLevelUps" type="java.util.List"--%>
<%--@elvariable id="questions" type="java.util.List"--%>
<%--@elvariable id="reviews" type="java.util.List"--%>
<%--@elvariable id="boardItems" type="java.util.List"--%>
<%--@elvariable id="boardStats" type="com.example.onedayclass.admin.dto.AdminBoardStatsDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="hero admin-hero">
    <div class="hero-grid">
        <div class="hero-copy">
            <p class="eyebrow">ADMIN BOARD CENTER</p>
            <div>
                <h1>게시글 통합 관리와 통계를 한 화면에서 처리합니다.</h1>
                <p>공지사항, QnA, 요청게시판, 후기, 등업신청 글을 한 번에 조회하고 관리자 권한으로 바로 승인 및 삭제를 수행할 수 있습니다.</p>
            </div>
        </div>
        <div class="hero-side">
            <div class="hero-highlight">
                <span class="hero-highlight-label"><i class="ri-bar-chart-grouped-line"></i> Overview</span>
                <strong>${boardStats.totalPosts}개의 관리 대상 글</strong>
                <p>삭제 처리된 글 수 ${boardStats.deletedCount}개, 승인 대기 클래스 ${boardStats.pendingClassCount}개, 등업 대기 ${boardStats.pendingLevelUpCount}개</p>
            </div>
            <div class="hero-stats admin-mini-stats">
                <article>
                    <strong>${boardStats.classCount}</strong>
                    <span>클래스</span>
                </article>
                <article>
                    <strong>${boardStats.noticeCount}</strong>
                    <span>공지사항</span>
                </article>
                <article>
                    <strong>${boardStats.qnaCount}</strong>
                    <span>QnA</span>
                </article>
                <article>
                    <strong>${boardStats.reviewCount}</strong>
                    <span>후기</span>
                </article>
            </div>
        </div>
    </div>
</section>
<section class="grid-section" style="margin-top:24px;">
    <div class="card-grid admin-stats-grid">
        <article class="card admin-stat-card">
            <strong><i class="ri-lightbulb-flash-line" style="color:var(--indigo);"></i> 요청게시판</strong>
            <span>${boardStats.requestCount}개</span>
        </article>
        <article class="card admin-stat-card">
            <strong><i class="ri-award-line" style="color:var(--primary);"></i> 등업신청 누적</strong>
            <span>${boardStats.levelUpCount}개</span>
        </article>
        <article class="card admin-stat-card">
            <strong><i class="ri-time-line" style="color:var(--warning);"></i> 승인 대기 클래스</strong>
            <span>${boardStats.pendingClassCount}개</span>
        </article>
        <article class="card admin-stat-card">
            <strong><i class="ri-delete-bin-line" style="color:var(--danger);"></i> 삭제 처리 글</strong>
            <span>${boardStats.deletedCount}개</span>
        </article>
    </div>
</section>
<section class="two-column">
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-checkbox-multiple-line"></i> 승인 대기 클래스</h2>
            <span class="badge badge-warn">${pendingClasses.size()}건</span>
        </div>
        <c:choose>
            <c:when test="${empty pendingClasses}">
                <p class="muted">현재 승인 대기 중인 클래스가 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${pendingClasses}">
                    <div class="list-link">
                        <span><strong>${item.CTitle}</strong> <em style="margin-left:8px;">(${item.CUid})</em></span>
                        <form method="post" action="<c:url value='/admin/classes/${item.CNum}/approve' />" class="inline-form">
                            <button type="submit"><i class="ri-check-line"></i> 승인</button>
                        </form>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </article>
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-award-line"></i> 등업 신청 대기</h2>
            <span class="badge badge-indigo">${pendingLevelUps.size()}건</span>
        </div>
        <c:choose>
            <c:when test="${empty pendingLevelUps}">
                <p class="muted">현재 대기 중인 강사 등업 신청이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${pendingLevelUps}">
                    <a class="list-link" href="<c:url value='/levelups/${item.lvlNum}' />">
                        <span>${item.lvlTitle}</span>
                        <em><i class="ri-user-line"></i> ${item.lvlUid}</em>
                    </a>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </article>
</section>
<section class="two-column">
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-question-answer-line"></i> 최근 QnA</h2>
            <a href="<c:url value='/qna' />">전체보기</a>
        </div>
        <c:forEach var="item" items="${questions}">
            <a class="list-link" href="<c:url value='/qna/${item.QNum}' />">
                <span>${item.QTitle}</span>
                <em>${item.QUid}</em>
            </a>
        </c:forEach>
    </article>
    <article class="panel">
        <div class="section-head">
            <h2><i class="ri-star-smile-line"></i> 최근 후기</h2>
            <a href="<c:url value='/reviews' />">전체보기</a>
        </div>
        <c:forEach var="item" items="${reviews}">
            <a class="list-link" href="<c:url value='/reviews/${item.RNum}' />">
                <span>${item.RTitle}</span>
                <em>${item.RUid}</em>
            </a>
        </c:forEach>
    </article>
</section>
<section class="panel admin-board-panel">
    <div class="section-head">
        <div>
            <h2><i class="ri-folder-settings-line"></i> 게시판 통합 관리</h2>
            <p class="section-subtitle">게시판별 필터와 검색으로 글을 찾고, 상세 보기 또는 관리자 삭제를 바로 수행할 수 있습니다.</p>
        </div>
    </div>
    <form method="get" action="<c:url value='/admin' />" class="search-bar admin-search-bar">
        <label class="search-label" for="boardType"><i class="ri-filter-2-line"></i> 게시판</label>
        <select id="boardType" name="boardType">
            <option value="all" ${activeBoardType eq 'all' ? 'selected' : ''}>전체</option>
            <option value="class" ${activeBoardType eq 'class' ? 'selected' : ''}>클래스</option>
            <option value="notice" ${activeBoardType eq 'notice' ? 'selected' : ''}>공지사항</option>
            <option value="qna" ${activeBoardType eq 'qna' ? 'selected' : ''}>QnA</option>
            <option value="request" ${activeBoardType eq 'request' ? 'selected' : ''}>요청게시판</option>
            <option value="review" ${activeBoardType eq 'review' ? 'selected' : ''}>후기</option>
            <option value="levelup" ${activeBoardType eq 'levelup' ? 'selected' : ''}>등업신청</option>
        </select>
        <input type="text" name="keyword" value="${keyword}" placeholder="제목 또는 작성자 검색" />
        <button type="submit"><i class="ri-search-line"></i> 조회</button>
        <a class="btn secondary" href="<c:url value='/admin' />"><i class="ri-refresh-line"></i> 초기화</a>
    </form>
    <table class="table admin-board-table">
        <thead>
        <tr>
            <th>게시판</th>
            <th>제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>상태</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty boardItems}">
                <tr>
                    <td colspan="6" class="muted" style="text-align:center; padding:32px;">조건에 맞는 게시글이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${boardItems}">
                    <tr>
                        <td><span class="board-badge">${item.boardLabel}</span></td>
                        <td>
                            <a href="<c:url value='${item.detailUrl}' />"><strong>${item.title}</strong></a>
                        </td>
                        <td>${item.authorId}</td>
                        <td class="muted">${item.createdAt}</td>
                        <td>
                            <span class="status-badge ${item.statusLabel eq '삭제됨' ? 'is-danger' : item.statusLabel eq '대기' or item.statusLabel eq '승인대기' ? 'is-warn' : 'is-ok'}">${item.statusLabel}</span>
                        </td>
                        <td>
                            <div class="actions">
                                <a class="btn secondary" href="<c:url value='${item.detailUrl}' />">상세</a>
                                <c:if test="${item.deletable}">
                                    <form method="post" action="<c:url value='/admin/boards/${item.boardType}/${item.postId}/delete' />" class="inline-form">
                                        <input type="hidden" name="boardType" value="${activeBoardType}" />
                                        <input type="hidden" name="keyword" value="${keyword}" />
                                        <button type="submit" class="danger" onclick="return confirm('이 글을 삭제하시겠습니까?');">삭제</button>
                                    </form>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>
<%@ include file="../include/footer.jspf" %>
