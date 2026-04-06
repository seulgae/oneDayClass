<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>QnA 게시판</h2><a class="btn" href="/qna/new">문의하기</a></div>
    <table class="table">
        <thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>상태</th><th>작성일</th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${questions}">
            <tr>
                <td>${item.QNum}</td>
                <td><a href="/qna/${item.QNum}">${item.QTitle}</a></td>
                <td>${item.QUid}</td>
                <td>${item.QStatus}</td>
                <td>${item.QRegDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<jsp:include page="../include/footer.jsp" />
