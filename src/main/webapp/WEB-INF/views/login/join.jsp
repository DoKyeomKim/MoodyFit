<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 회원가입</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
  <style>
    body {
        background-color: #f8f9fa;
    }
    main {
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h4 {
        margin-bottom: 30px;
        font-weight: bold;
    }
    .required-table-header {
        background-color: #007bff;
        color: #fff;
        padding: 10px;
        border-radius: 8px 8px 0 0;
    }
    .options-table-header {
        background-color: #ccc;
        color: #4d4d4d ;
        padding: 10px;
        border-radius: 8px 8px 0 0;
    }
    .required-table, .options-table {
        margin-bottom: 30px;
    }
    .required-table table, .options-table table {
        width: 100%;
    }
    th {
        width: 20%;
        padding: 10px;
        text-align: left;
        background-color: #f1f1f1;
    }
    td {
        padding: 10px;
    }
    .form-control {
        width: 100%;
    }
    .form-inline .form-control {
        width: auto;
    }
    .btn {
        margin-top: 10px;
    }
    .btn-outline-secondary {
        margin-left: 10px;
    }
    .flex-container {
        display: flex;
        align-items: center;
    }
    .flex-container input, .flex-container button {
        margin-right: 10px;
    }
    #btnIdCheck{
    	margin-top: -1px;
        height : 36px;
    }
    #btnNickNameCheck{
        margin-top: -1px;
        height : 36px;
    }
    #btnPostCode{
        margin-top: -1px;
        height : 36px;
    }
    #btnEmailCheck{
        margin-top: -1px;
        height : 36px;
    }
    th.required::after {
    content: " *";
    color: red;
	}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<main>
<form action="/joinProcess" method="post" name="joinForm">
<h4 class="text-center">개인 회원가입</h4>
<div class="required-table">
    <div class="required-table-header">필수입력</div>
    <table class="table table-bordered">
        <tr>
            <th class="required">아이디</th>
            <td>
                <div class="form-inline flex-container">
                    <input type="text" name="id" id="username" class="form-control" placeholder="아이디를 입력해주세요.">
                    <input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnIdCheck"/>
                </div>
                <span id="output"></span>
            </td>
        </tr>
        <tr>
            <th class="required">비밀번호</th>
            <td><input type="password" name="pw" id="password" oninput="pwCheck()" class="form-control" placeholder="비밀번호를 입력해주세요" required></td>
        </tr>
        <tr>
            <th class="required">비밀번호 확인</th>
            <td>
                <input type="password" id="password2" oninput="pwCheck()" class="form-control" placeholder="비밀번호를 다시 한번 입력해주세요" required>
                <span id="pwConfirm" style="display: block;"></span>
            </td>
        </tr>
        <tr>
            <th class="required">이름</th>
            <td><input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력해주세요"></td>
        </tr>
        <tr>
            <th class="required">닉네임</th>
            <td>
                <div class="form-inline flex-container">
                    <input type="text" name="nickName" id="nickName" class="form-control" placeholder="닉네임을 입력해주세요">
                    <input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnNickNameCheck"/>
                </div>
                <span id="output2"></span>
            </td>
        </tr>
        <tr>
            <th class="required">우편번호</th>
            <td>
                <div class="form-inline flex-container">
                    <input type="text" name="postCode" id="sample6_postcode" class="form-control" placeholder="우편번호">
                    <input type="button" class="btn btn-sm btn-secondary" onclick="sample6_execDaumPostcode()" id="btnPostCode" value="우편번호 찾기">
                </div>
            </td>
        </tr>
        <tr>
            <th class="required">주소</th>
            <td><input type="text" name="address" id="sample6_address" class="form-control" placeholder="주소"></td>
        </tr>
        <tr>
            <th class="required">상세주소</th>
            <td><input type="text" name="detailAddress" id="sample6_detailAddress" class="form-control" placeholder="상세주소를 입력해주세요"></td>
        </tr>
        <tr>
            <th class="required">전화번호</th>
            <td><input type="text" name="phone" id="phone" class="form-control" placeholder="-를 제외한 번호만 입력해주세요"></td>
        </tr>
        <tr>
            <th class="required">이메일</th>
            <td>
            	<div class="form-inline flex-container">
            		<input type="email" name="email" id="email" class="form-control" placeholder="@를 포함한 이메일을 입력해주세요" style="width:50%">
            		<input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnEmailCheck"/>
            	</div>
            	<span id="output3"></span>
            </td>
        </tr>
    </table>
</div>
<div class="options-table">
    <div class="options-table-header">선택 입력</div>
    <table class="table table-bordered">
        <tr>
            <th>성별</th>
            <td>
                <div class="form-check form-check-inline">
                    <input type="radio" name="gender" value="1" class="form-check-input" checked/>
                    <label class="form-check-label">남성</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="gender" value="2" class="form-check-input"/>
                    <label class="form-check-label">여성</label>
                </div>
            </td>
        </tr>
        <tr>
            <th>키</th>
            <td>
                <div class="form-inline flex-container">
                    <input type="text" name="height" id="height" class="form-control" style="width: 30%;" placeholder="숫자만 입력해주세요">
                    <span>cm</span>
                </div>
            </td>
        </tr>
        <tr>
            <th>체중</th>
            <td>
                <div class="form-inline flex-container">
                    <input type="text" name="weight" id="weight" class="form-control" style="width: 30%;" placeholder="숫자만 입력해주세요">
                    <span>kg</span>
                </div>
            </td>
        </tr>
        <tr>
            <th>신발 사이즈</th>
            <td><input type="text" name="foot" id="foot" class="form-control" placeholder="숫자만 입력해주세요"></td>
        </tr>
        <tr>
            <th>상의</th>
            <td><input type="text" name="top" id="top" class="form-control"></td>
        </tr>
        <tr>
            <th>하의</th>
            <td><input type="text" name="bottom" id="bottom" class="form-control"></td>
        </tr>
        <tr>
            <td colspan="2" class="text-center">
                <button type="submit" id="submitBtn" class="btn btn-primary">회원가입</button>
            </td>
        </tr>
    </table>
</div>
</form>
</main>
<script>
    const btnIdCheckEl = document.querySelector('#btnIdCheck');
    const btnNicknameCheckEl = document.querySelector('#btnNickNameCheck');
    const btnEmailCheckEl = document.querySelector('#btnEmailCheck');
    var submitBtnEl = document.querySelector('#submitBtn');
    const outputEl = document.querySelector('#output');
    const output2El = document.querySelector('#output2');
    const output3El = document.querySelector('#output3');
    const idInputEl = document.querySelector('[name=id]');
    const nickNameInputEl = document.querySelector('[name=nickName]');
    const emailInputEl = document.querySelector('[name=email]');
    const pw1InputEl = document.getElementById("password");
    const pw2InputEl = document.getElementById("password2");
    const pwConfirmEl = document.getElementById("pwConfirm");

    let idCheckPassed = false;
    let nickNameCheckPassed = false;
    let pwCheckPassed = false;
    let emailCheckPassed = false;

    function checkFormValidity() {
        if (idCheckPassed && nickNameCheckPassed && pwCheckPassed && emailCheckPassed) {
            submitBtnEl.disabled = false;
        } else {
            submitBtnEl.disabled = true;
        }
    }

    btnIdCheckEl.onclick = function(e) {
        if (!idInputEl.value.trim()) {
            outputEl.innerHTML = "<small style='color:red'>아이디를 입력해주세요.</small>";
            idCheckPassed = false;
            checkFormValidity();
            return;
        }
        fetch('/idCheck?id=' + encodeURIComponent(idInputEl.value))
            .then(response => response.text())
            .then((data) => {
                console.log(data);
                outputEl.innerHTML = data;

                if (data.includes('사용가능한 아이디입니다')) {
                    idCheckPassed = true;
                } else {
                    idCheckPassed = false;
                }
                checkFormValidity();
            })
            .catch(error => {
                console.error('Error:', error);
                idCheckPassed = false;
                checkFormValidity();
            });
    }

    btnNicknameCheckEl.onclick = function(e) {
        if (!nickNameInputEl.value.trim()) {
            output2El.innerHTML = "<small style='color:red'>닉네임을 입력해주세요.</small>";
            nickNameCheckPassed = false;
            checkFormValidity();
            return;
        }
        fetch('/nickNameCheck?nickName=' + encodeURIComponent(nickNameInputEl.value))
            .then(response => response.text())
            .then((data) => {
                console.log(data);
                output2El.innerHTML = data;

                if (data.includes('사용가능한 닉네임입니다')) {
                    nickNameCheckPassed = true;
                } else {
                    nickNameCheckPassed = false;
                }
                checkFormValidity();
            })
            .catch(error => {
                console.error('Error:', error);
                nickNameCheckPassed = false;
                checkFormValidity();
            });
    }
    
    btnEmailCheckEl.onclick = function(e){
    	if(!emailInputEl.value.trim()){
    		output3El.innerHTML = "<small style='color:red'>이메일을 입력해주세요.</small>";
    		emailCheckPassed = false;
    		checkFormValidity();
    		return;
    	}
    	
    	fetch('emailCheck?email='+ encodeURIComponent(emailInputEl.value))
    	.then(response => response.text())
    	.then((data) => {
            console.log(data);
            output3El.innerHTML = data;

            if (data.includes('사용가능한 이메일입니다')) {
                emailCheckPassed = true;
            } else {
                emailCheckPassed = false;
            }
            checkFormValidity();
        })
        .catch(error => {
            console.error('Error:', error);
            emailCheckPassed = false;
            checkFormValidity();
        });
    }

    function pwCheck() {
        if (pw1InputEl.value !== pw2InputEl.value) {
            pwConfirmEl.innerHTML = "<small style='color: red;'>비밀번호가 일치하지 않습니다.</small>";
            pwCheckPassed = false;
        } else {
            pwConfirmEl.innerHTML = "<small style='color: green;'>비밀번호가 일치합니다.</small>";
            pwCheckPassed = true;
        }
        checkFormValidity();
    }

    // 초기에는 제출 버튼을 비활성화
    submitBtnEl.disabled = true;

    // 입력 필드가 변경될 때마다 제출 버튼 비활성화 및 상태 초기화
    idInputEl.oninput = function() {
        idCheckPassed = false;
        outputEl.innerHTML = '';
        checkFormValidity();
    }

    nickNameInputEl.oninput = function() {
        nickNameCheckPassed = false;
        output2El.innerHTML = '';
        checkFormValidity();
    }
    emailInputEl.oninput = function() {
        emailCheckPassed = false;
        output3El.innerHTML = '';
        checkFormValidity();
    }

    pw1InputEl.oninput = pw2InputEl.oninput = pwCheck;
</script>


<!-- 전화번호 입력시 - 자동생성 -->
<script>
document.getElementById('phone').addEventListener('input', function (e) {
    // 현재 입력된 값에서 숫자만 추출
    let numbers = e.target.value.replace(/\D/g, '');
    
    // 하이픈(-)을 추가한 전화번호 포맷 생성
    let formattedNumber = '';
    if (numbers.length <= 3) {
        formattedNumber = numbers;
    } else if (numbers.length <= 7) {
        formattedNumber = numbers.slice(0, 3) + '-' + numbers.slice(3);
    } else {
        formattedNumber = numbers.slice(0, 3) + '-' + numbers.slice(3, 7) + '-' + numbers.slice(7, 11);
    }

    // 포맷된 번호를 입력 필드에 설정
    e.target.value = formattedNumber;
});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
    document.querySelector('form[name="joinForm"]').onsubmit = function(event) {
        event.preventDefault();

        let formIsValid = true;

        function showAlert(message, inputElement) {
            alert(message);
            inputElement.focus();
            formIsValid = false;
        }

        const idInput = document.getElementById("username");
        if (!idInput.value.trim()) {
            showAlert("아이디를 입력해주세요.", idInput);
            return;
        }

        const passwordInput = document.getElementById("password");
        if (!passwordInput.value.trim()) {
            showAlert("비밀번호를 입력해주세요.", passwordInput);
            return;
        }

        const passwordConfirmInput = document.getElementById("password2");
        if (!passwordConfirmInput.value.trim()) {
            showAlert("비밀번호를 다시 한번 입력해주세요.", passwordConfirmInput);
            return;
        }

        const nameInput = document.getElementById("name");
        if (!nameInput.value.trim()) {
            showAlert("이름을 입력해주세요.", nameInput);
            return;
        }

        const nickNameInput = document.getElementById("nickName");
        if (!nickNameInput.value.trim()) {
            showAlert("닉네임을 입력해주세요.", nickNameInput);
            return;
        }

        const postCodeInput = document.getElementById("sample6_postcode");
        if (!postCodeInput.value.trim()) {
            showAlert("우편번호를 입력해주세요.", postCodeInput);
            return;
        }

        const addressInput = document.getElementById("sample6_address");
        if (!addressInput.value.trim()) {
            showAlert("주소를 입력해주세요.", addressInput);
            return;
        }

        const detailAddressInput = document.getElementById("sample6_detailAddress");
        if (!detailAddressInput.value.trim()) {
            showAlert("상세주소를 입력해주세요.", detailAddressInput);
            return;
        }

        const phoneInput = document.getElementById("phone");
        if (!phoneInput.value.trim()) {
            showAlert("전화번호를 입력해주세요.", phoneInput);
            return;
        }

        const emailInput = document.getElementById("email");
        if (!emailInput.value.trim()) {
            showAlert("이메일을 입력해주세요.", emailInput);
            return;
        }

        if (formIsValid) {
            this.submit();
        }
    }
</script>

</body>
</html>