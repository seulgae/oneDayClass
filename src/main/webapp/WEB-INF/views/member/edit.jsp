<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/header.jsp" />
<section class="form-panel member-form-panel">
    <div class="member-form-hero">
        <h2>회원정보 수정</h2>
        <p>계정 정보와 연락처를 구분해서 정리했습니다. 필요한 안내만 펼쳐서 확인할 수 있습니다.</p>
    </div>
    <form method="post" action="/members/edit" id="editForm" novalidate>
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
                    <input type="password" id="editPassword" name="uPw" required pattern="^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-={}\[\]:;,.?/]).{8,20}$" title="비밀번호는 영문, 숫자, 특수문자를 포함한 8~20자입니다." autocomplete="new-password">
                </label>
                <label class="field-block">
                    <span class="field-label">비밀번호 확인 <span class="required-mark">*</span></span>
                    <input type="password" id="editPasswordConfirm" required autocomplete="new-password">
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
                    <input type="text" name="uPhone" value="${memberDto.UPhone}" pattern="^01[0-9]-?\d{3,4}-?\d{4}$" title="휴대폰 번호 형식이 올바르지 않습니다." placeholder="010-1234-5678" autocomplete="tel">
                </label>
                <label class="field-block">
                    <span class="field-label">이메일</span>
                    <input type="email" name="uEmail" value="${memberDto.UEmail}" placeholder="name@example.com" autocomplete="email">
                </label>
            </div>
            <div class="field-block">
                <span class="field-label">주소</span>
                <div class="zip-field">
                    <input type="text" id="uZip" name="uZip" value="${memberDto.UZip}" placeholder="우편번호" readonly>
                    <button type="button" class="btn secondary" onclick="openPostcode('uZip', 'uAddr1', 'uAddr2')">주소찾기</button>
                </div>
                <div class="field-grid address-grid">
                    <input type="text" id="uAddr1" name="uAddr1" value="${memberDto.UAddr1}" placeholder="기본주소" readonly>
                    <input type="text" id="uAddr2" name="uAddr2" value="${memberDto.UAddr2}" placeholder="상세주소">
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

    (function() {
        var form = document.getElementById('editForm');
        var password = document.getElementById('editPassword');
        var confirm = document.getElementById('editPasswordConfirm');
        var errorBox = document.getElementById('editFormError');

        form.addEventListener('submit', function(event) {
            errorBox.hidden = true;
            errorBox.textContent = '';

            if (!form.checkValidity()) {
                event.preventDefault();
                form.reportValidity();
                return;
            }

            if (password.value !== confirm.value) {
                event.preventDefault();
                errorBox.textContent = '비밀번호와 비밀번호 확인이 일치하지 않습니다.';
                errorBox.hidden = false;
                confirm.focus();
            }
        });
    })();

    document.querySelectorAll('.guide-toggle').forEach(bindGuideToggle);
</script>
<jsp:include page="../include/footer.jsp" />
