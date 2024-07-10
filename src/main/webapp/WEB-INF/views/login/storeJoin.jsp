<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편집샵 회원가입</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    .required-table{
        margin-bottom: 30px;
    }
    .required-table table{
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
    #btnStoreNameCheck{
        margin-top: -1px;
        height : 36px;
    }
    #btnPostCode{
        margin-top: -1px;
        height : 36px;
    }
    
    #corp_button{
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
<form action="/storeJoinProcess" method="post" name="joinForm">
<h4 class="text-center">편집샵 회원가입</h4>
<div class="required-table">
    <div class="required-table-header">필수입력</div>
    <table class="table table-bordered">  	
	    <tr>
	      <th class="required">아이디</th>
	      <td>
	      	<div class="form-inline flex-container">
		      <input type="text" name="id" class="form-control" id="username" placeholder="아이디를 입력해주세요.">
		      <input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnIdCheck"/>
	      	</div>
		    <span id="output"></span>
	      </td>
	    </tr>
	    <tr>
	      <th class="required">비밀번호</th>
	      <td><input type="password" class="form-control" name="pw" id="password" oninput="pwCheck()"  placeholder="비밀번호를 입력해주세요" required></td>
	    </tr>
	    <tr>
	      <th class="required">비밀번호 확인</th>
	      <td><input type="password" class="form-control" id="password2" oninput="pwCheck()" placeholder="비밀번호를 다시 한번 입력해주세요" required>
	      <span id="pwConfirm" style="display: block;"></span>
	      </td>
	    </tr>
	    <tr>
	      <th class="required">상호명</th>
	      <td>
		      <div class="form-inline flex-container">
			      <input type="text" class="form-control" name="storeName" id="name" placeholder="상호명을 입력해주세요.">
			      <input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnStoreNameCheck"/>
		      </div>
		      <small id="output2"></small>
		  </td>
	    </tr>
	    <tr>
	      <th class="required">담당자명</th>
	      <td><input type="text" class="form-control" name="managerName" id="nickName"  placeholder="담당자 실명을 입력해주세요."></td>
	    </tr>
		    <tr>
		      <th class="required">사업자 등록번호</th>
		      <td>
		      <div class="form-inline flex-container">
			      <input type="text" class="form-control" name="businessNumber"  id="corp_reg" placeholder="10자리를 입력해주세요">
			      <input type="button" class="btn btn-sm btn-outline-secondary" name="corp_button" id="corp_button" value="인증하기" onclick="corp_chk();">
		      </div>
		      <small id="output3"></small></td>
		    </tr>
	    <tr>
	      <th class="required">우편번호</th>
	      <td>
	      <div class="form-inline flex-container">
	      	<input type="text" name="postCode" class="form-control" id="sample6_postcode" placeholder="우편번호">
	      	<input type="button" class="btn btn-sm btn-secondary" onclick="sample6_execDaumPostcode()" id="btnPostCode" value="우편번호 찾기">
	      </div>
	      </td>
	    </tr>
	    <tr>
	      <th class="required">주소</th>
	      <td><input type="text" name="address" class="form-control" id="sample6_address"  placeholder="주소"></td>
	    </tr>
	    <tr>
	      <th class="required">상세주소</th>
	      <td><input type="text" name="detailAddress" class="form-control" id="sample6_detailAddress" placeholder="상세주소를 입력해주세요"></td>
	    </tr>

    
	    <tr>
	      <th class="required">전화번호</th>
	      <td>
	        <input type="text" name="phone" class="form-control" id="phone"  placeholder="전화번호를 입력해주세요">
	      </td>
	    </tr>
	    <tr>
	      <th class="required">이메일</th>
	      <td>
           	<div class="form-inline flex-container">
           		<input type="email" name="email" id="email" class="form-control" placeholder="@를 포함한 이메일을 입력해주세요" style="width:50%">
           		<input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnEmailCheck"/>
           	</div>
           	<span id="output4"></span>
	      </td>
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 아이디 중복확인 -->
<script>
    const btnIdCheckEl = document.querySelector('#btnIdCheck');
    const btnStoreNameCheckEl = document.querySelector('#btnStoreNameCheck');
    const btnEmailCheckEl = document.querySelector('#btnEmailCheck');
    const submitBtnEl = document.querySelector('#submitBtn');
    const idInputEl = document.querySelector('[name=id]');
    const storeNameInputEl = document.querySelector('[name=storeName]');
    const emailInputEl = document.querySelector('[name=email]');
    const outputEl = document.querySelector('#output');
    const output2El = document.querySelector('#output2');
    const output3El = document.querySelector('#output3');
    const output4El = document.querySelector('#output4');
    const pwConfirm = document.getElementById("pwConfirm");

    let idCheckPassed = false;
    let storeNameCheckPassed = false;
    let pwCheckPassed = false;
    let corpCheckPassed = false;
    let emailCheckPassed = false;

    function updateSubmitButtonState() {
        submitBtnEl.disabled = !(idCheckPassed && storeNameCheckPassed && pwCheckPassed && corpCheckPassed && emailCheckPassed);
    }

    btnIdCheckEl.onclick = function(e) {
        if (!idInputEl.value.trim()) {
            outputEl.innerHTML = "<small style='color:red'>아이디를 입력해주세요.</small>";
            idCheckPassed = false;
            updateSubmitButtonState();
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
                updateSubmitButtonState();
            })
            .catch(error => {
                console.error('Error:', error);
                idCheckPassed = false;
                updateSubmitButtonState();
            });
    }

    idInputEl.oninput = function() {
        idCheckPassed = false;
        outputEl.innerHTML = '';
        updateSubmitButtonState();
    }

    btnStoreNameCheckEl.onclick = function(e) {
        if (!storeNameInputEl.value.trim()) {
            output2El.innerHTML = "<small style='color:red'>상호명을 입력해주세요.</small>";
            storeNameCheckPassed = false;
            updateSubmitButtonState();
            return;
        }
        fetch('/storeNameCheck?storeName=' + encodeURIComponent(storeNameInputEl.value))
            .then(response => response.text())
            .then((data) => {
                console.log(data);
                output2El.innerHTML = data;
                if (data.includes('사용가능한 상호명입니다')) {
                    storeNameCheckPassed = true;
                } else {
                    storeNameCheckPassed = false;
                }
                updateSubmitButtonState();
            })
            .catch(error => {
                console.error('Error:', error);
                storeNameCheckPassed = false;
                updateSubmitButtonState();
            });
    }

    storeNameInputEl.oninput = function() {
        storeNameCheckPassed = false;
        output2El.innerHTML = '';
        updateSubmitButtonState();
    }
    
    btnEmailCheckEl.onclick = function(e){
    	if(!emailInputEl.value.trim()){
    		output4El.innerHTML = "<small style='color:red'>이메일을 입력해주세요.</small>";
    		emailCheckPassed = false;
    		updateSubmitButtonState();
    		return;
    	}
    	
    	fetch('emailCheck?email='+ encodeURIComponent(emailInputEl.value))
    	.then(response => response.text())
    	.then((data) => {
            console.log(data);
            output4El.innerHTML = data;

            if (data.includes('사용가능한 이메일입니다')) {
                emailCheckPassed = true;
            } else {
                emailCheckPassed = false;
            }
            updateSubmitButtonState();
        })
        .catch(error => {
            console.error('Error:', error);
            emailCheckPassed = false;
            updateSubmitButtonState();
        });
    }

    function pwCheck() {
        var pw1 = document.getElementById("password").value;
        var pw2 = document.getElementById("password2").value;

        if (pw1 != pw2) {
            pwConfirm.innerHTML = "<small style='color: red;'>비밀번호가 일치하지 않습니다.</small>";
            pwCheckPassed = false;
        } else {
            pwConfirm.innerHTML = "<small style='color: green;'>비밀번호가 일치합니다.</small>";
            pwCheckPassed = true;
        }
        updateSubmitButtonState();
    }

    function corp_chk() {
        $("#corp_reg").val($("#corp_reg").val().replace(/[^0-9]/g, ""));
        var reg_num = $("#corp_reg").val();

        if (!reg_num) {
            alert("사업자등록번호를 입력해주세요.");
            corpCheckPassed = false;
            updateSubmitButtonState();
            return false;
        }

        var data = {
            "b_no": [reg_num]
        };

        $.ajax({
            url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=ZzjiXsO54frnYeOeOREWD4%2FCrXJX4iLuAq%2FgwplyBHzruLAJkM9y8flbcDw8nlwRXZQdn3cBJja4ORISGfFd7Q%3D%3D",  // serviceKey 값을 xxxxxx에 입력
            type: "POST",
            data: JSON.stringify(data),
            dataType: "JSON",
            traditional: true,
            contentType: "application/json; charset:UTF-8",
            accept: "application/json",
            success: function(result) {
                console.log(result);
                if (result.match_cnt == "1") {
                    console.log("success");
                    output3El.innerHTML = '<small style="color: green;">인증 완료되었습니다.</small>';
                    corpCheckPassed = true;
                } else {
                    console.log("fail");
                    alert(result.data[0]["tax_type"]);
                    output3El.innerHTML = '<small style="color: red;">등록되지 않은 번호입니다.</small>';
                    corpCheckPassed = false;
                }
                updateSubmitButtonState();
            },
            error: function(result) {
                console.log("error");
                console.log(result.responseText);
                output3El.innerHTML = '<small style="color: red;">등록되지 않은 번호입니다.</small>';
                corpCheckPassed = false;
                updateSubmitButtonState();
            }
        });
    }

    // Initialize
    submitBtnEl.disabled = true;

    // Ensure the password check function is run on password input changes
    document.getElementById("password").oninput = pwCheck;
    document.getElementById("password2").oninput = pwCheck;
</script>


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
                updateSubmitButtonState();
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

    const storeNameInput = document.getElementById("name");
    if (!storeNameInput.value.trim()) {
        showAlert("상호명을 입력해주세요.", storeNameInput);
        return;
    }

    const managerNameInput = document.getElementById("nickName");
    if (!managerNameInput.value.trim()) {
        showAlert("담당자 실명을 입력해주세요.", managerNameInput);
        return;
    }

    const businessNumberInput = document.getElementById("corp_reg");
    if (!businessNumberInput.value.trim()) {
        showAlert("사업자등록번호를 입력해주세요.", businessNumberInput);
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

</body>
</html>