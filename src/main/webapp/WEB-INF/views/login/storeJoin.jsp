<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가맹점 회원가입</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
  	
  	.content-main{
  	  display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
  	}
  
    table {
      margin-top: 100px;
      margin-bottom:100px;
      width: 60%;
      border-collapse: collapse;
    }
    th{
      width: 7%;
      padding: 10px;
      text-align: left;
      border: 1px solid #ddd;
      border-left:none;
      background-color: #FBFAFA;
    }
    td {
      width: 50%;
      padding: 10px;
      text-align: left;
      border: 1px solid #ddd;
      border-right:none;
    }

    
  </style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<main class="content-main">
  <table>
  	<form action="/storeJoinProcess" method="post" name="joinForm">
	    <tr>
	      <th>아이디</th>
	      <td><input type="text" name="id" id="username" style="width: 25%;" placeholder="아이디를 입력해주세요.">&nbsp;&nbsp;<input type="button" class="btn btn-sm btn-outline-secondary" style="margin-bottom:5px;" value="중복확인" id="btnIdCheck"/><br>
	      	  <span class="col-6" id="output"></span></td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td><input type="password" name="pw" id="password" oninput="pwCheck()" style="width: 50%;" placeholder="비밀번호를 입력해주세요" required></td>
	    </tr>
	    <tr>
	      <th>비밀번호 확인</th>
	      <td><input type="password" id="password2" oninput="pwCheck()" style="width: 50%;" placeholder="비밀번호를 다시 한번 입력해주세요" required>
	      <span id="pwConfirm" style="display: block;"></span>
	      </td>
	    </tr>
	    <tr>
	      <th>상호명</th>
	      <td><input type="text" name="storeName" id="name" style="width: 30%;" placeholder="상호명을 입력해주세요.">&nbsp;&nbsp;<input type="button" class="btn btn-sm btn-outline-secondary" style="margin-bottom:5px;" value="중복확인" id="btnStoreNameCheck"/><br>
	      	  <small class="col-6" id="output2"></small></td>
	    </tr>
	    <tr>
	      <th>담당자명</th>
	      <td><input type="text" name="managerName" id="nickName" style="width: 30%;" placeholder="담당자 실명을 입력해주세요."></td>
	    </tr>
		    <tr>
		      <th>사업자 등록번호</th>
		      <td><input type="text" name="businessNumber"  id="corp_reg" style="width: 30%;" placeholder="사업자등록번호 10자리를 입력해주세요">&nbsp;&nbsp;
		      <input type="button" class="btn btn-sm btn-outline-secondary" style="margin-bottom:5px;" name="corp_button" id="corp_button" value="확 인" onclick="corp_chk();"><br>
		      <small class="col-6" id="output3"></small></td>
		    </tr>
	    <tr>
	      <th>우편번호</th>
	      <td><input type="text" name="postCode" id="sample6_postcode" placeholder="우편번호" style="margin-right: 30px; width: 20%;"><input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
	    </tr>
	    <tr>
	      <th>주소</th>
	      <td><input type="text" name="address" id="sample6_address" style="width: 40%;" placeholder="주소"></td>
	    </tr>
	    <tr>
	      <th>상세주소</th>
	      <td><input type="text" name="detailAddress" id="sample6_detailAddress" style="width: 50%;" placeholder="상세주소를 입력해주세요"></td>
	    </tr>

    
	    <tr>
	      <th>전화번호</th>
	      <td>
	        <input type="text" name="phone" id="phone" style="width: 30%;"  placeholder="전화번호를 입력해주세요">
	      </td>
	    </tr>
	    <tr>
	      <th>이메일</th>
	      <td><input type="email" name="email" id="email" style="width: 30%;"  placeholder="이메일을 입력해주세요"></td>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align: center;  border-left:none; border-bottom:none;">
	        <button type="submit" id="submitBtn" class="btn btn-primary" style="margin-top: 20px;">회원가입</button>
	      </td>
	    </tr>
    </form>
  </table>
</main>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 아이디 중복확인 -->
<script>
    const btnIdCheckEl = document.querySelector('#btnIdCheck');
    const btnStoreNameCheckEl = document.querySelector('#btnStoreNameCheck');
    const submitBtnEl = document.querySelector('#submitBtn');
    const idInputEl = document.querySelector('[name=id]');
    const storeNameInputEl = document.querySelector('[name=storeName]');
    const outputEl = document.querySelector('#output');
    const output2El = document.querySelector('#output2');
    const output3El = document.querySelector('#output3');
    const pwConfirm = document.getElementById("pwConfirm");

    let idCheckPassed = false;
    let storeNameCheckPassed = false;
    let pwCheckPassed = false;
    let corpCheckPassed = false;

    function updateSubmitButtonState() {
        submitBtnEl.disabled = !(idCheckPassed && storeNameCheckPassed && pwCheckPassed && corpCheckPassed);
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
            }
        }).open();
    }
</script>

<script>
document.querySelector('form[name="joinForm"]').onsubmit = function(event) {
    // Prevent form submission
    event.preventDefault();

    // Initialize flag to track if the form is valid
    let formIsValid = true;

    // Helper function to show alert and focus the corresponding input
    function showAlert(message, inputElement) {
        alert(message);
        inputElement.focus();
        formIsValid = false;
    }

    // Validate each required field
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
</body>
</html>