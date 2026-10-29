<%--@elvariable id="loginMember" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%--@elvariable id="message" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnedayClass - 취향을 발견하는 원데이 클래스 플랫폼</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css">
    <link rel="stylesheet" href="<c:url value='/css/app.css' />">
</head>
<body>
<header class="site-header">
    <div class="inner">
        <div class="header-primary">
            <a class="brand" href="<c:url value='/' />">
                <span class="brand-logo-mark"><i class="ri-sparkling-2-fill"></i></span>
                <span>Oneday<span class="brand-accent">Class</span></span>
            </a>
        </div>
        <div class="header-nav-wrap">
            <nav class="nav">
                <a href="<c:url value='/classes' />"><i class="ri-compass-3-line"></i>클래스</a>
                <a href="<c:url value='/reviews' />"><i class="ri-star-smile-line"></i>수강후기</a>
                <a href="<c:url value='/qna' />"><i class="ri-question-answer-line"></i>QnA</a>
                <a href="<c:url value='/notices' />"><i class="ri-megaphone-line"></i>공지사항</a>
                <a href="<c:url value='/requests' />"><i class="ri-lightbulb-flash-line"></i>요청게시판</a>
                <c:if test="${loginMember != null and (loginMember.ULevel eq '1')}">
                    <a href="<c:url value='/payments/cart' />"><i class="ri-shopping-bag-3-line"></i>장바구니</a>
                </c:if>
                <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
                    <a class="admin-nav-link" href="<c:url value='/admin' />"><i class="ri-dashboard-3-line"></i>관리자 센터</a>
                </c:if>
            </nav>
            <div class="auth">
                <c:choose>
                    <c:when test="${loginMember != null}">
                        <span class="user-pill">
                            <span class="user-avatar"><i class="ri-user-smile-line"></i></span>
                            <c:choose>
                                <c:when test="${loginMember.ULevel eq '1'}">${loginMember.UName} <span class="role-tag">수강생</span></c:when>
                                <c:when test="${loginMember.ULevel eq '2'}">${loginMember.UName} <span class="role-tag">선생님</span></c:when>
                                <c:when test="${loginMember.ULevel eq '3'}">${loginMember.UName} <span class="role-tag">관리자</span></c:when>
                                <c:when test="${loginMember.ULevel eq '4'}">${loginMember.UName} <span class="role-tag">운영자</span></c:when>
                                <c:otherwise>${loginMember.UName}님</c:otherwise>
                            </c:choose>
                        </span>
                        <a href="<c:url value='/members/mypage' />"><i class="ri-user-settings-line"></i>마이페이지</a>
                        <a href="<c:url value='/members/logout' />"><i class="ri-logout-box-r-line"></i>로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/members/login' />" data-auth-open="login"><i class="ri-login-box-line"></i>로그인</a>
                        <a class="auth-btn-primary" href="<c:url value='/members/join' />" data-auth-open="join">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>
<main class="page">
    <c:if test="${not empty message}">
        <div class="flash">
            <i class="ri-Notification-badge-line"></i>
            <span>${message}</span>
        </div>
    </c:if>
