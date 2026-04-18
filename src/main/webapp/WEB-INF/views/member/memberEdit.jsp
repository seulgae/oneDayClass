<%-- 회원 정보 수정 화면 --%>
<%--@elvariable id="memberDto" type="com.example.onedayclass.member.dto.MemberDto"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2>회원정보 수정</h2>
        <p>계정 정보와 연락처를 구분해서 정리했습니다. 필요한 안내만 펼쳐서 확인할 수 있습니다.</p>
    </div>
    <form method="post" action="<c:url value='/members/edit' />" id="editForm" novalidate>
        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>계정 정보</h3>
                    <p class="section-copy">아이디와 이름은 읽기 전용이며 비밀번호만 변경 가능합니다.</p>
                </div>
                <div class="section-actions">
                    <span class="required-guide"><span class="required-mark">*</span> 필수 입력</span>
                    <button type="button" class="guide-toggle" data-target="editAccountGuide">안내 보기</button>
                </div>
            </div>
            <div class="guide-box" id="editAccountGuide" hidden>
                <p>비밀번호는 영문, 숫자, 특수문자를 각각 1개 이상 포함한 8~20자여야 합니다.</p>
                <p>비밀번호 확인 입력값까지 일치해야 저장됩니다.</p>
            </div>
            <div class="field-grid two-column-grid">
                <label class="field-block field-readonly">
                    <span class="field-label">아이디</span>
                    <input type="text" value="${memberDto.UId}" readonly>
                </label>
                <label class="field-block field-readonly">
                    <span class="field-label">이름</span>
                    <input type="text" value="${memberDto.UName}" readonly>
                </label>
                <label class="field-block">
                    <span class="field-label">비밀번호 <span class="required-mark">*</span></span>
                    <input type="password" id="editPassword" name="uPw" value="${memberDto.UPw}" required minlength="8" maxlength="20" pattern="^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-={}\[\]:;,.?/]).{8,20}$" title="비밀번호는 영문, 숫자, 특수문자를 포함한 8~20자입니다." autocomplete="new-password">
                </label>
                <label class="field-block">
                    <span class="field-label">비밀번호 확인 <span class="required-mark">*</span></span>
                    <input type="password" id="editPasswordConfirm" required minlength="8" maxlength="20" autocomplete="new-password">
                </label>
            </div>
        </section>

        <section class="form-section">
            <div class="section-headline">
                <div>
                    <h3>연락처 및 주소</h3>
                    <p class="section-copy">변경이 잦은 정보만 따로 정리했습니다.</p>
                </div>
                <button type="button" class="guide-toggle" data-target="editContactGuide">안내 보기</button>
            </div>
            <div class="guide-box" id="editContactGuide" hidden>
                <p>휴대폰 번호는 `010-1234-5678` 형식 또는 숫자만 허용합니다.</p>
                <p>주소찾기 버튼으로 우편번호와 기본주소를 다시 선택할 수 있습니다.</p>
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

        <p class="form-error" id="editFormError" hidden></p>
        <button type="submit" class="member-submit">저장하기</button>
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

    function bindGuideToggle(button) {
        button.addEventListener('click', function() {
            var target = document.getElementById(button.dataset.target);
            var expanded = button.getAttribute('aria-expanded') === 'true';
            button.setAttribute('aria-expanded', expanded ? 'false' : 'true');
            button.textContent = expanded ? '안내 보기' : '안내 닫기';
            target.hidden = expanded;
        });
    }

    function formatPhoneNumber(value) {
        var digits = value.replace(/\D/g, '').slice(0, 11);

        if (digits.length < 4) {
            return digits;
        }

        if (digits.length < 8) {
            return digits.slice(0, 3) + '-' + digits.slice(3);
        }

        if (digits.length < 11) {
            return digits.slice(0, 3) + '-' + digits.slice(3, 6) + '-' + digits.slice(6);
        }

        return digits.slice(0, 3) + '-' + digits.slice(3, 7) + '-' + digits.slice(7);
    }

    function bindPhoneFormatter(selector) {
        var phoneInput = document.querySelector(selector);
        if (!phoneInput) {
            return;
        }

        function applyPhoneFormat() {
            phoneInput.value = formatPhoneNumber(phoneInput.value);
        }

        phoneInput.addEventListener('input', applyPhoneFormat);
        phoneInput.addEventListener('blur', applyPhoneFormat);
        applyPhoneFormat();
    }

    (function() {
        var form = document.getElementById('editForm');
        var password = document.getElementById('editPassword');
        var confirm = document.getElementById('editPasswordConfirm');
        var errorBox = document.getElementById('editFormError');

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
    })();

    document.querySelectorAll('.guide-toggle').forEach(bindGuideToggle);
    bindPhoneFormatter('input[name="uPhone"]');
</script>
<%@ include file="../include/footer.jspf" %>

