<%-- 회원 가입 화면 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2>회원가입</h2>
        <p>원데이클래스 이용에 필요한 기본 정보부터 차근차근 입력해 주세요. 안내 보기를 누르면 입력 규칙을 바로 확인할 수 있습니다.</p>
    </div>
    <c:if test="${not empty validationErrors}">
        <div class="alert alert-error">
            <c:forEach var="error" items="${validationErrors}">
                <p>${error}</p>
            </c:forEach>
        </div>
    </c:if>
    <form method="post" action="<c:url value='/members/join' />" id="joinForm" novalidate>
        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>기본 정보</h3>
                    <p class="section-copy">로그인과 본인 확인에 필요한 항목입니다.</p>
                </div>
                <div class="section-actions">
                    <span class="required-guide"><span class="required-mark">*</span> 필수 입력</span>
                    <button type="button" class="guide-toggle" data-target="joinBasicGuide">안내 보기</button>
                </div>
            </div>
            <div class="guide-box" id="joinBasicGuide" hidden>
                <p>아이디는 영문/숫자 4~20자, 이름은 한글/영문 2~20자입니다.</p>
                <p>비밀번호는 영문, 숫자, 특수문자를 각각 1개 이상 포함한 8~20자여야 합니다.</p>
            </div>
            <div class="field-grid two-column-grid">
                <label class="field-block">
                    <span class="field-label">아이디 <span class="required-mark">*</span></span>
                    <input type="text" name="uId" value="${memberDto.UId}" required minlength="4" maxlength="20" pattern="^[a-zA-Z0-9]{4,20}$" title="아이디는 영문과 숫자 4~20자입니다." autocomplete="username">
                </label>
                <label class="field-block">
                    <span class="field-label">이름 <span class="required-mark">*</span></span>
                    <input type="text" name="uName" value="${memberDto.UName}" required minlength="2" maxlength="20" pattern="^[가-힣a-zA-Z]{2,20}$" title="이름은 한글 또는 영문 2~20자입니다." autocomplete="name">
                </label>
                <label class="field-block">
                    <span class="field-label">비밀번호 <span class="required-mark">*</span></span>
                    <input type="password" id="joinPassword" name="uPw" required minlength="8" maxlength="20" pattern="^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-={}\[\]:;,.?/]).{8,20}$" title="비밀번호는 영문, 숫자, 특수문자를 포함한 8~20자입니다." autocomplete="new-password">
                </label>
                <label class="field-block">
                    <span class="field-label">비밀번호 확인 <span class="required-mark">*</span></span>
                    <input type="password" id="joinPasswordConfirm" required minlength="8" maxlength="20" autocomplete="new-password">
                </label>
            </div>
        </section>

        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>회원 유형</h3>
                    <p class="section-copy">수강생은 클래스 수강, 선생님은 클래스 등록이 가능합니다.</p>
                </div>
                <button type="button" class="guide-toggle" data-target="joinRoleGuide">안내 보기</button>
            </div>
            <div class="guide-box" id="joinRoleGuide" hidden>
                <p>관리자 권한은 가입 단계에서 선택할 수 없습니다.</p>
                <p>선생님 가입 시 활동명과 SNS 주소를 함께 입력할 수 있습니다.</p>
            </div>
            <div class="role-choice">
                <label class="role-option">
                    <input type="radio" name="uLevel" value="1" ${empty memberDto.ULevel or memberDto.ULevel eq '1' ? 'checked' : ''}>
                    <span class="role-card">
                        <strong>수강생</strong>
                        <em>클래스 신청과 결제 중심</em>
                    </span>
                </label>
                <label class="role-option">
                    <input type="radio" name="uLevel" value="2" ${memberDto.ULevel eq '2' ? 'checked' : ''}>
                    <span class="role-card">
                        <strong>선생님</strong>
                        <em>클래스 등록과 운영 가능</em>
                    </span>
                </label>
            </div>
            <div class="field-grid two-column-grid teacher-only is-hidden" id="teacherFields" hidden>
                <label class="field-block">
                    <span class="field-label">강사 활동명</span>
                    <input type="text" id="sName" name="sName" value="${memberDto.SName}" minlength="2" maxlength="50" pattern="^[가-힣a-zA-Z0-9\s.,()_-]{2,50}$" title="강사 활동명은 한글, 영문, 숫자와 일부 기호를 포함해 2~50자까지 입력할 수 있습니다." placeholder="예: 원데이 클래스 by 민지">
                </label>
                <label class="field-block">
                    <span class="field-label">강사 SNS 주소</span>
                    <input type="url" id="sSns" name="sSns" value="${memberDto.SSns}" maxlength="255" placeholder="https://">
                </label>
            </div>
        </section>

        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>연락처 및 주소</h3>
                    <p class="section-copy">알림 수신과 배송, 연락에 사용되는 정보입니다.</p>
                </div>
                <button type="button" class="guide-toggle" data-target="joinContactGuide">안내 보기</button>
            </div>
            <div class="guide-box" id="joinContactGuide" hidden>
                <p>휴대폰 번호는 `010-1234-5678` 또는 숫자만 입력할 수 있습니다.</p>
                <p>주소는 우편번호 검색 후 기본주소를 자동 입력하고 상세주소만 직접 작성하면 됩니다.</p>
            </div>
            <div class="field-grid two-column-grid">
                <label class="field-block">
                    <span class="field-label">휴대폰 번호</span>
                    <input type="text" name="uPhone" value="${memberDto.UPhone}" maxlength="13" pattern="^01[0-9]-?\d{3,4}-?\d{4}$" title="휴대폰 번호 형식이 올바르지 않습니다." placeholder="010-1234-5678" autocomplete="tel">
                </label>
                <label class="field-block">
                    <span class="field-label">이메일</span>
                    <input type="email" name="uEmail" value="${memberDto.UEmail}" maxlength="100" placeholder="name@example.com" autocomplete="email">
                </label>
            </div>
            <div class="field-block">
                <span class="field-label">주소</span>
                <div class="zip-field">
                    <input type="text" id="uZip" name="uZip" value="${memberDto.UZip}" maxlength="10" placeholder="우편번호" readonly>
                    <button type="button" class="btn secondary" onclick="openPostcode('uZip', 'uAddr1', 'uAddr2')">주소찾기</button>
                </div>
                <div class="field-grid address-grid">
                    <input type="text" id="uAddr1" name="uAddr1" value="${memberDto.UAddr1}" maxlength="120" placeholder="기본주소" readonly>
                    <input type="text" id="uAddr2" name="uAddr2" value="${memberDto.UAddr2}" maxlength="120" placeholder="상세주소">
                </div>
            </div>
        </section>

        <p class="form-error" id="joinFormError" hidden></p>
        <button type="submit" class="member-submit">가입하기</button>
    </form>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function openPostcode(zipId, addr1Id, addr2Id) {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById(zipId).value = data.zonecode;
                document.getElementById(addr1Id).value = data.roadAddress || data.jibunAddress;
                document.getElementById(addr2Id).focus();
            }
        }).open();
    }

    function toggleTeacherFields() {
        var selected = document.querySelector('input[name="uLevel"]:checked');
        var teacherFields = document.getElementById('teacherFields');
        var isTeacher = selected && selected.value === '2';
        var teacherName = document.getElementById('sName');
        var teacherSns = document.getElementById('sSns');

        teacherFields.hidden = !isTeacher;
        teacherFields.classList.toggle('is-hidden', !isTeacher);
        teacherName.toggleAttribute('required', isTeacher);

        if (!isTeacher) {
            teacherName.value = '';
            teacherSns.value = '';
        }
    }

    function bindGuideToggle(button) {
        button.addEventListener('click', function() {
            var target = document.getElementById(button.dataset.target);
            var expanded = button.getAttribute('aria-expanded') === 'true';
            button.setAttribute('aria-expanded', expanded ? 'false' : 'true');
            button.textContent = expanded ? '안내 보기' : '안내 닫기';
            target.hidden = expanded;
        });
    }

    function validatePasswordMatch(formId, passwordId, confirmId, errorId) {
        var form = document.getElementById(formId);
        var password = document.getElementById(passwordId);
        var confirm = document.getElementById(confirmId);
        var errorBox = document.getElementById(errorId);

        function syncPasswordValidity() {
            var hasConfirmValue = confirm.value.length > 0;
            var isMatch = password.value === confirm.value;

            confirm.setCustomValidity(hasConfirmValue && !isMatch
                ? '비밀번호와 비밀번호 확인이 일치하지 않습니다.'
                : '');

            errorBox.hidden = true;
            errorBox.textContent = '';
        }

        password.addEventListener('input', syncPasswordValidity);
        confirm.addEventListener('input', syncPasswordValidity);

        form.addEventListener('submit', function(event) {
            syncPasswordValidity();

            if (!form.checkValidity()) {
                event.preventDefault();
                if (confirm.validationMessage) {
                    errorBox.textContent = confirm.validationMessage;
                    errorBox.hidden = false;
                }
                form.reportValidity();
                return;
            }
        });
    }

    document.querySelectorAll('input[name="uLevel"]').forEach(function(input) {
        input.addEventListener('change', toggleTeacherFields);
    });
    document.querySelectorAll('.guide-toggle').forEach(bindGuideToggle);

    toggleTeacherFields();
    validatePasswordMatch('joinForm', 'joinPassword', 'joinPasswordConfirm', 'joinFormError');
</script>
<%@ include file="../include/footer.jspf" %>
