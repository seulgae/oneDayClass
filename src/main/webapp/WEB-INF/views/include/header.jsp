<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>oneDayClass</title>
    <link rel="stylesheet" href="/css/app.css">
</head>
<body>
<header class="site-header">
    <div class="inner">
        <a class="brand" href="/">oneDayClass</a>
        <nav class="nav">
            <a href="/classes">Classes</a>
            <a href="/reviews">Reviews</a>
            <a href="/qna">QnA</a>
            <a href="/payments/cart">Cart</a>
            <a href="/levelups">Level Up</a>
            <c:if test="${loginMember != null and loginMember.ULevel eq '3'}">
                <a href="/admin">Admin</a>
            </c:if>
        </nav>
        <div class="auth">
            <c:choose>
                <c:when test="${loginMember != null}">
                    <span>${loginMember.UName} (${loginMember.UId})</span>
                    <a href="/members/mypage">My Page</a>
                    <a href="/members/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/members/login">Login</a>
                    <a href="/members/join">Join</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<main class="page">
    <c:if test="${not empty message}">
        <div class="flash">${message}</div>
    </c:if>
