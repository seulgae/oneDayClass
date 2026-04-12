<%-- 요청 게시판 상세 화면 --%>
<%--@elvariable id="requestItem" type="com.example.onedayclass.requestboard.dto.RequestBoardDto"--%>
<%--@elvariable id="replies" type="java.util.List"--%>
<%--@elvariable id="loginMember" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="../include/header.jsp" %>
<section class="panel detail">
    <div class="section-head">
        <h2>${requestItem.reqTitle}</h2>
        <a class="btn secondary" href="<c:url value='/requests' />">목록으로</a>
    </div>
    <dl><dt>작성자</dt><dd>${requestItem.reqUid}</dd></dl>
    <dl><dt>요청번호</dt><dd>${requestItem.reqRef}</dd></dl>
    <dl><dt>작성일</dt><dd>${fn:substring(requestItem.reqRegDate, 0, 10)}</dd></dl>
    <dl><dt>내용</dt><dd>${requestItem.reqContent}</dd></dl>
    <div class="actions">
        <c:if test="${loginMember != null}">
            <button type="button" class="btn secondary reply-toggle" data-target="requestMainReplyForm" data-label-default="답변 작성" data-label-active="작성 중" aria-expanded="false">답변 작성</button>
        </c:if>
        <form method="post" action="<c:url value='/requests/${requestItem.reqNum}/delete' />" class="inline-form">
            <button type="submit">요청 삭제</button>
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
            <article class="qna-reply qna-depth-${reply.reqDepth}">
                <div class="qna-reply-head">
                    <div class="qna-reply-meta">
                        <span class="reply-depth-badge">${reply.reqDepth eq 1 ? '답변' : '대댓글'}</span>
                        <strong>${reply.reqUid}</strong>
                    </div>
                    <span class="muted">${fn:substring(reply.reqRegDate, 0, 10)}</span>
                </div>
                <div class="qna-reply-body">
                    <h3>${reply.reqTitle}</h3>
                    <p>${reply.reqContent}</p>
                </div>
                <c:if test="${loginMember != null and reply.reqDepth lt 2}">
                    <div class="qna-reply-actions">
                        <button type="button" class="btn secondary reply-toggle" data-target="requestReplyForm-${reply.reqNum}" data-label-default="대댓글 작성" data-label-active="작성 중" aria-expanded="false">대댓글 작성</button>
                    </div>
                    <form method="post" action="<c:url value='/requests/${reply.reqNum}/reply' />" class="qna-inline-reply-form" id="requestReplyForm-${reply.reqNum}" hidden>
                        <p class="reply-form-copy">같은 주제의 요청은 한 줄 요약과 함께 남기면 읽기 편합니다.</p>
                        <input type="text" name="reqTitle" placeholder="대댓글 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
                        <textarea name="reqContent" placeholder="대댓글 내용을 입력해 주세요." rows="3" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
                        <div class="qna-inline-reply-actions">
                            <button type="submit">답변 등록</button>
                            <button type="button" class="btn secondary reply-toggle-cancel" data-target="requestReplyForm-${reply.reqNum}">닫기</button>
                        </div>
                    </form>
                </c:if>
            </article>
        </c:forEach>
    </div>
</section>

<c:if test="${loginMember != null}">
    <section class="form-panel" id="requestMainReplyForm" hidden>
        <h2>답변 작성</h2>
        <form method="post" action="<c:url value='/requests/${requestItem.reqNum}/reply' />">
            <p class="reply-form-copy">요청 의도를 먼저 정리하고 가능 여부나 다음 단계를 적으면 더 친절하게 보입니다.</p>
            <input type="text" name="reqTitle" placeholder="답변 제목" required minlength="4" maxlength="80" pattern="^.{4,80}$" title="제목은 4~80자 이내로 입력해 주세요.">
            <textarea name="reqContent" placeholder="답변 내용을 입력해 주세요." rows="5" required minlength="10" maxlength="3000" title="답변 내용은 10자 이상 입력해 주세요."></textarea>
            <div class="qna-inline-reply-actions">
                <button type="submit">답변 등록</button>
                <button type="button" class="btn secondary reply-toggle-cancel" data-target="requestMainReplyForm">닫기</button>
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

