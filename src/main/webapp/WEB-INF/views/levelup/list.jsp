<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../include/header.jsp" />
<section class="panel">
    <div class="section-head"><h2>등업 신청 게시판</h2><a class="btn" href="/levelups/new">신청하기</a></div>
    <table class="table">
        <thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>상태</th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${requests}">
            <tr>
                <td>${item.lvlNum}</td>
                <td><a href="/levelups/${item.lvlNum}">${item.lvlTitle}</a></td>
                <td>${item.lvlUid}</td>
                <td>${item.lvlStatus}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<jsp:include page="../include/footer.jsp" />
