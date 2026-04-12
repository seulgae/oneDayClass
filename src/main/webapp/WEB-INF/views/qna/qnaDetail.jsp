<%-- QnA 상세 화면 --%>
<%--@elvariable id="question" type="com.example.onedayclass.qna.dto.QnaDto"--%>
<%--@elvariable id="replies" type="java.util.List"--%>
<%--@elvariable id="loginMember" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${question.QTitle}</h2>
        <a class="btn secondary" href="<c:url value='/qna' />">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${question.QUid}</dd></dl>
    <dl><dt>문의번호</dt><dd>${question.QRef}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(question.QRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${question.QContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <button type="button" class="btn secondary reply-toggle" data-target="qnaMainReplyForm" data-label-default="답변 작성" data-label-active="작성 중" aria-expanded="false">답변 작성</button>
        </c:if>
        <form method="post" action="<c:url value='/qna/${question.QNum}/delete' />" class="inline-form">
            <button type="submit">문의 삭제</button>
        </form>
    </div>
</section>

<section class="panel">
    <div class="section-head">
        <h2>답변</h2>
        <span class="muted">${replies.size()}개</span>
    </div>
    <c:if test="${empty replies}">
        <p class="muted">아직 등록된 답변이 없습니다.</p>
    </c:if>
    <div class="qna-reply-list">
        <c:forEach var="reply" items="${replies}">
            <article class="qna-reply qna-depth-${reply.QDepth}">
                <div class="qna-reply-head">
                    <div class="qna-reply-meta">
                        <span class="reply-depth-badge">${reply.QDepth eq 1 ? '답변' : '대댓글'}</span>
                        <strong>${reply.QUid}</strong>
                    </div>
                    <span class="muted">${fn:substring(reply.QRegDate, 0, 10)}</span>
                </div>
                <div class="qna-reply-body">
                    <h3>${reply.QTitle}</h3>
                    <p>${reply.QContent}</p>
                </div>
                <c:if test="${loginMember != null and reply.QDepth lt 2}">
                    <div class="qna-reply-actions">
                        <button type="button" class="btn secondary reply-toggle" data-target="qnaReplyForm-${reply.QNum}" data-label-default="대댓글 작성" data-label-active="작성 중" aria-expanded="false">대댓글 작성</button>
                    </div>
                    <form method="post" action="<c:url value='/qna/${reply.QNum}/reply' />" class="qna-inline-reply-form" id="qnaReplyForm-${reply.QNum}" hidden>
                        <p class="reply-form-copy">짧게 상황을 이어 쓰면 질문 흐름을 따라가기 쉽습니다.</p>
                        <input type="text" name="qTitle" placeholder="대댓글 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
                        <textarea name="qContent" placeholder="대댓글 내용을 입력해 주세요." rows="3" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
                        <div class="qna-inline-reply-actions">
                            <button type="submit">답변 등록</button>
                            <button type="button" class="btn secondary reply-toggle-cancel" data-target="qnaReplyForm-${reply.QNum}">닫기</button>
                        </div>
                    </form>
                </c:if>
            </article>
        </c:forEach>
    </div>
</section>

<c:if test="${loginMember != null}">
    <section class="form-panel" id="qnaMainReplyForm" hidden>
        <h2>답변 작성</h2>
        <form method="post" action="<c:url value='/qna/${question.QNum}/reply' />">
            <p class="reply-form-copy">질문 요지를 먼저 짚고 해결 방법을 덧붙이면 읽는 사람이 바로 이해하기 쉽습니다.</p>
            <input type="text" name="qTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
            <textarea name="qContent" placeholder="답변 내용을 입력해 주세요." rows="5" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
            <div class="qna-inline-reply-actions">
                <button type="submit">답변 등록</button>
                <button type="button" class="btn secondary reply-toggle-cancel" data-target="qnaMainReplyForm">닫기</button>
            </div>
        </form>
    </section>
</c:if>
<script>
    (function() {
        document.querySelectorAll('.qna-reply.qna-depth-1').forEach(function(replyCard) {
            var actions = replyCard.querySelector('.qna-reply-actions');
            var form = replyCard.querySelector('.qna-inline-reply-form');
            if (!actions || !form) {
                return;
            }

            var anchor = replyCard;
            var next = replyCard.nextElementSibling;
            while (next && next.classList.contains('qna-depth-2')) {
                anchor = next;
                next = next.nextElementSibling;
            }

            var compose = document.createElement('div');
            compose.className = 'qna-thread-compose';
            compose.appendChild(actions);
            compose.appendChild(form);
            anchor.insertAdjacentElement('afterend', compose);
        });

        function setReplyFormState(form, button, expanded) {
            form.hidden = !expanded;
            if (button) {
                button.setAttribute('aria-expanded', expanded ? 'true' : 'false');
                var defaultLabel = button.dataset.labelDefault || '열기';
                var activeLabel = button.dataset.labelActive || '작성 중';
                button.textContent = expanded ? activeLabel : defaultLabel;
            }
        }

        document.addEventListener('click', function(event) {
            var toggleButton = event.target.closest('.reply-toggle');
            if (toggleButton) {
                var toggleForm = document.getElementById(toggleButton.dataset.target);
                var expanded = toggleButton.getAttribute('aria-expanded') === 'true';
                setReplyFormState(toggleForm, toggleButton, !expanded);
                if (!expanded) {
                    var firstField = toggleForm.querySelector('input, textarea');
                    if (firstField) {
                        firstField.focus();
                    }
                }
                return;
            }

            var cancelButton = event.target.closest('.reply-toggle-cancel');
            if (cancelButton) {
                var cancelForm = document.getElementById(cancelButton.dataset.target);
                var toggle = document.querySelector('.reply-toggle[data-target="' + cancelButton.dataset.target + '"]');
                setReplyFormState(cancelForm, toggle, false);
            }
        });
    })();
</script>
<%@ include file="../include/footer.jspf" %>

