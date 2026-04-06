<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnedayClass</title>
    <link rel="stylesheet" href="/css/app.css">
</head>
<body>
<header class="site-header">
    <div class="inner">
        <a class="brand" href="/">OnedayClass</a>
        <nav class="nav">
            <a href="/classes">클래스</a>
            <a href="/reviews">후기</a>
            <a href="/qna">QnA</a>
            <a href="/payments/cart">장바구니</a>
            <a href="/levelups">등업신청</a>
            <c:if test="${loginMember != null and loginMember.ULevel eq '3'}">
                <a href="/admin">관리자</a>
            </c:if>
        </nav>
        <div class="auth">
            <c:choose>
                <c:when test="${loginMember != null}">
                    <span>${loginMember.UName} (${loginMember.UId})</span>
                    <a href="/members/mypage">마이페이지</a>
                    <a href="/members/logout">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/members/login">로그인</a>
                    <a href="/members/join">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<main class="page">
    <c:if test="${not empty message}">
        <div class="flash">${message}</div>
    </c:if>
