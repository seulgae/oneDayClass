<%-- 결제 내역 화면 --%>
<%--@elvariable id="studentPayments" type="java.util.List"--%>
<%--@elvariable id="teacherPayments" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="two-column" style="margin-top:0;">
    <article class="panel">
        <div class="section-head">
            <div>
                <h2><i class="ri-receipt-line"></i> 내 결제 내역</h2>
                <p class="section-subtitle">신청하고 결제한 원데이 클래스 주문 목록입니다.</p>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty studentPayments}">
                <p class="muted">아직 결제한 내역이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="stack-list">
                    <c:forEach var="item" items="${studentPayments}">
                        <a class="list-link" href="<c:url value='/payments/history/${item.PNum}' />">
                            <span><i class="ri-checkbox-circle-line" style="color:var(--success); margin-right:6px;"></i>${item.CTitle}</span>
                            <em>${fn:substring(item.payDate, 0, 10)} &middot; <strong><fmt:formatNumber value="${item.CPrice}" />원</strong></em>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </article>
    <article class="panel">
        <div class="section-head">
            <div>
                <h2><i class="ri-store-3-line"></i> 클래스 판매 내역</h2>
                <p class="section-subtitle">내가 개설한 클래스를 수강 신청한 내역입니다.</p>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty teacherPayments}">
                <p class="muted">아직 판매된 내역이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="stack-list">
                    <c:forEach var="item" items="${teacherPayments}">
                        <a class="list-link" href="<c:url value='/payments/history/${item.PNum}' />">
                            <span><i class="ri-user-follow-line" style="color:var(--indigo); margin-right:6px;"></i>${item.CTitle}</span>
                            <em>${item.UId} / ${item.REmail}</em>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </article>
</section>
<%@ include file="../include/footer.jspf" %>
