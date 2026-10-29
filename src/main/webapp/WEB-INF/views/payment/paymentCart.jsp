<%-- 장바구니 화면 --%>
<%--@elvariable id="cartItems" type="java.util.List"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="panel">
    <div class="section-head">
        <div>
            <h2><i class="ri-shopping-bag-3-line"></i> 장바구니</h2>
            <p class="section-subtitle">담아둔 클래스를 확인하고 한 번에 결제를 진행하세요.</p>
        </div>
        <c:if test="${not empty cartItems}">
            <a class="btn" href="<c:url value='/payments/checkout' />"><i class="ri-bank-card-line"></i> 결제하기</a>
        </c:if>
    </div>
    <c:choose>
        <c:when test="${empty cartItems}">
            <div style="text-align:center; padding:48px 20px;">
                <i class="ri-shopping-cart-2-line" style="font-size:48px; color:var(--text-light);"></i>
                <p class="muted" style="margin:12px 0 20px;">장바구니에 담긴 클래스가 없습니다.</p>
                <a class="btn secondary" href="<c:url value='/classes' />"><i class="ri-compass-3-line"></i> 클래스 둘러보기</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table">
                <thead>
                <tr>
                    <th>클래스명</th>
                    <th>수강료</th>
                    <th>배송비</th>
                    <th style="width:120px; text-align:right;">관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td><strong><a href="<c:url value='/classes/${item.CNum}' />">${item.CTitle}</a></strong></td>
                        <td><fmt:formatNumber value="${item.CPrice}" />원</td>
                        <td><fmt:formatNumber value="${item.CDelivery}" />원</td>
                        <td style="text-align:right;">
                            <form method="post" action="<c:url value='/payments/cart/${item.CNum}/delete' />" class="inline-form" style="justify-content:flex-end;">
                                <button type="submit" class="danger"><i class="ri-delete-bin-line"></i> 삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</section>
<%@ include file="../include/footer.jspf" %>
