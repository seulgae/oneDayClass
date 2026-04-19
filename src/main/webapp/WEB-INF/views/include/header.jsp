<%--@elvariable id="loginMember" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%--@elvariable id="message" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnedayClass</title>
    <link rel="stylesheet" href="<c:url value='/css/app.css' />">
</head>
<body>
<header class="site-header">
    <div class="inner">
        <div class="header-primary">
            <a class="brand" href="<c:url value='/' />">OnedayClass</a>
        </div>
        <div class="header-nav-wrap">
            <nav class="nav">
                <a href="<c:url value='/classes' />">클래스</a>
                <a href="<c:url value='/reviews' />">후기</a>
                <a href="<c:url value='/qna' />">QnA</a>
                <c:if test="${loginMember != null and (loginMember.ULevel eq '1')}">
                <a href="<c:url value='/payments/cart' />">장바구니</a>
                </c:if>
                <a href="<c:url value='/notices' />">공지사항</a>
                <a href="<c:url value='/requests' />">요청게시판</a>
                <c:if test="${loginMember != null and (loginMember.ULevel eq '3' or loginMember.ULevel eq '4')}">
                    <a href="<c:url value='/admin' />">관리자</a>
                </c:if>
            </nav>
            <div class="auth">
                <c:choose>
                    <c:when test="${loginMember != null}">
                        <span>
                            <c:choose>
                                <c:when test="${loginMember.ULevel eq '1'}">${loginMember.UName} 수강생님</c:when>
                                <c:when test="${loginMember.ULevel eq '2'}">${loginMember.UName} 선생님</c:when>
                                <c:when test="${loginMember.ULevel eq '3'}">${loginMember.UName} 관리자님</c:when>
                                <c:when test="${loginMember.ULevel eq '4'}">${loginMember.UName} 운영자님</c:when>
                                <c:otherwise>${loginMember.UName}님</c:otherwise>
                            </c:choose>
                        </span>
                        <a href="<c:url value='/members/mypage' />">마이페이지</a>
                        <a href="<c:url value='/members/logout' />">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/members/login' />">로그인</a>
                        <a href="<c:url value='/members/join' />">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>
<main class="page">
    <c:if test="${not empty message}">
        <div class="flash">${message}</div>
    </c:if>

