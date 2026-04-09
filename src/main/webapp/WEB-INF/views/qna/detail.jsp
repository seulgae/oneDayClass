<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${question.QTitle}</h2>
        <a class="btn secondary" href="/qna">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${question.QUid}</dd></dl>
    <dl><dt>문의번호</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>작성일</dt><dd>${question.QRegDate}</dd></dl>
    <dl><dt>내용</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <a class="btn secondary" href="/qna/${question.QNum}/reply">댓글 작성</a>
        </c:if>
        <form method="post" action="/qna/${question.QNum}/delete" class="inline-form">
            <button type="submit">문의 삭제</button>
        </form>
    </div>
</section>

<section class="panel">
    <div class="section-head">
        <h2>댓글</h2>
        <span class="muted">${replies.size()}개</span>
    </div>
    <c:if test="${empty replies}">
        <p class="muted">아직 등록된 댓글이 없습니다.</p>
    </c:if>
    <div class="qna-reply-list">
        <c:forEach var="reply" items="${replies}">
            <article class="qna-reply qna-depth-${reply.QDepth}">
                <div class="qna-reply-head">
                    <strong>${reply.QUid}</strong>
                    <span class="muted">${reply.QRegDate}</span>
                </div>
                <h3>${reply.QTitle}</h3>
                <p>${reply.QContent}</p>
                <c:if test="${loginMember != null and reply.QDepth lt 2}">
                    <form method="post" action="/qna/${reply.QNum}/reply" class="qna-inline-reply-form">
                        <input type="text" name="qTitle" placeholder="대댓글 제목" required>
                        <textarea name="qContent" placeholder="대댓글 내용을 입력하세요" rows="3" required></textarea>
                        <button type="submit">대댓글 등록</button>
                    </form>
                </c:if>
            </article>
        </c:forEach>
    </div>
</section>

<c:if test="${loginMember != null}">
    <section class="form-panel">
        <h2>댓글 작성</h2>
        <form method="post" action="/qna/${question.QNum}/reply">
            <input type="text" name="qTitle" placeholder="댓글 제목" required>
            <textarea name="qContent" placeholder="댓글 내용을 입력하세요" rows="5" required></textarea>
            <button type="submit">댓글 등록</button>
        </form>
    </section>
</c:if>
<%@ include file="../include/footer.jsp" %>
