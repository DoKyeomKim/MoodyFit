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

  
    table {
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

<main>
<form action="/joinProcess" method="post" name="joinForm">
<h4  style="text-align:center; margin:20px 0;">회원가입</h4>
<div class="required-table">
	<div class="table-header">
	<span>필수입력</span>
	</div>
  <table>
	    <tr>
	      <th>아이디</th>
	      <td><input type="text" name="id" id="username" style="width: 25%;" placeholder="아이디를 입력해주세요.">&nbsp;&nbsp;<input type="button" class="btn btn-sm btn-outline-secondary" style="" value="중복확인" id="btnIdCheck"/><br>
	      	  <span class="col-6" id="output"></span>
	      </td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td><input type="password" name="pw" id="password" oninput="pwCheck()" style="width: 30%;"placeholder="비밀번호를 입력해주세요" required></td>
	    </tr>
	    <tr>
	      <th>비밀번호 확인</th>
	      <td><input type="password" id="password2" oninput="pwCheck()" style="width: 30%;" placeholder="비밀번호를 다시 한번 입력해주세요" required>
	      <span id="pwConfirm" style="display: block;"></span>
	      </td>
	    </tr>
	    <tr>
	      <th>이름</th>
	      <td><input type="text" name="name" id="name" style="width: 30%;" placeholder="이름을 입력해주세요"></td>
	    </tr>
	    <tr>
	      <th>닉네임</th>
	      <td><input type="text" name="nickName" id="nickName" style="width: 30%;" placeholder="닉네임을 입력해주세요">&nbsp;&nbsp;<input type="button" class="btn btn-sm btn-outline-secondary" value="중복확인" id="btnNickNameCheck"/><br>
	      	  <span class="col-6" id="output2"></span>
	      </td>
	    </tr>
	    <tr>
	      <th>우편번호</th>
	      <td><input type="text" name="postCode" id="sample6_postcode" placeholder="우편번호" style="margin-right: 30px; width: 20%;"><input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
	    </tr>
	    <tr>
	      <th>주소</th>
	      <td><input type="text" name="address" id="sample6_address" style="width: 60%;" placeholder="주소"></td>
	    </tr>
	    <tr>
	      <th>상세주소</th>
	      <td><input type="text" name="detailAddress" id="sample6_detailAddress" style="width: 60%;" placeholder="상세주소를 입력해주세요"></td>
	    </tr>

    
	    <tr>
	      <th>전화번호</th>
	      <td>
	        <input type="text" name="phone" id="phone" style="width: 35%;"  placeholder=" -를 제외한 번호만 입력해주세요">
	      </td>
	    </tr>
	    <tr>
	      <th>이메일</th>
	      <td><input type="email" name="email" id="email" style="width: 35%;"placeholder="@를 포함한 이메일을 입력해주세요"></td>
	    </tr>
  </table>
</div>
<div class="options-table">
	<div class="table-header">
	<span>선택 입력</span>
	</div>
  <table>
	    <tr>
	      <th>성별</th>
	      <td><input type='radio' name='gender' value='1' checked/>남성 &nbsp;&nbsp;<input type='radio' name='gender' value='2' />여성</td>
	    </tr>
	    <tr>
	      <th>키</th>
	      <td><input type="password" name="height" id="height" style="width: 20%;">cm</td>
	    </tr>
	    <tr>
	      <th>체중</th>
	      <td><input type="text" name="weight" id="weight" style="width: 20%;">kg</td>
	    </tr>
	    <tr>
	      <th>신발 사이즈</th>
	      <td><input type="text" name="foot" id="foot" style="width: 20%;"></td>
	    </tr>
	    <tr>
	      <th>상의</th>
	      <td><input type="text" name="top" id="top" style="width: 20%;"></td>
	    </tr>
	    <tr>
	      <th>하의</th>
	      <td><input type="text" name="bottom" id="bottom" style="width: 20%;" ></td>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align: center;  border-left:none; border-bottom:none;">
	        <button type="submit" id="submitBtn" class="btn btn-primary" style="margin-top: 20px;">회원가입</button>
	      </td>
	    </tr>
  </table>
  </div>
</form>
</main>
<!-- 아이디 중복확인 -->
<script>
    const btnIdCheckEl = document.querySelector('#btnIdCheck');
    var submitBtnEl = document.querySelector('#submitBtn');
    const outputEl = document.querySelector('#output');
    const idInputEl = document.querySelector('[name=id]');
    

    btnIdCheckEl.onclick = function(e) {
        if (!idInputEl.value.trim()) { // 입력 필드가 비어 있는지 확인
            outputEl.innerHTML = "<small style='color:red'>아이디를 입력해주세요.</small>";
            return; // 입력 필드가 비어 있으면 더 이상 진행하지 않음
        }
        fetch('/IdCheck?id=' + encodeURIComponent(idInputEl.value))
            .then(response => response.text())
            .then((data) => {
                console.log(data);
                outputEl.innerHTML = data;

                if (data.includes('사용가능한 아이디입니다')) {
                    submitBtnEl.disabled = false; // 제출 버튼 활성화
                } else {
                    submitBtnEl.disabled = true;  // 제출 버튼 비활성화
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // 초기에는 제출 버튼을 비활성화
    submitBtnEl.disabled = true;

    // 아이디 입력 필드가 변경될 때마다 제출 버튼 비활성화
    idInputEl.oninput = function() {
        submitBtnEl.disabled = true;
        outputEl.innerHTML = '';
    }
</script>
<script>
    function pwCheck() {
        var pw1 = document.getElementById("password").value;
        var pw2 = document.getElementById("password2").value;
        var pwConfirm = document.getElementById("pwConfirm");
        var submitBtnEl = document.querySelector('#submitBtn');

        if (pw1 != pw2) {
            pwConfirm.innerHTML = "<small style='color: red;'>비밀번호가 일치하지 않습니다.</small>";
            submitBtnEl.disabled = true; // 비밀번호 불일치 시 제출 버튼 비활성화
        } else {
            pwConfirm.innerHTML = "<small style='color: green;'>비밀번호가 일치합니다.</small>";
            submitBtnEl.disabled = false; // 비밀번호 일치 시 제출 버튼 활성화
        }
    }
</script>
<!-- 닉네임 중복확인 -->
<script>
    const btnNicknameCheckEl = document.querySelector('#btnNickNameCheck');
    var submitBtnEl = document.querySelector('#submitBtn');
    const output2El = document.querySelector('#output2');
    const nickNameInputEl = document.querySelector('[name=nickName]');

    btnNicknameCheckEl.onclick = function(e) {
        if (!nickNameInputEl.value.trim()) { // 입력 필드가 비어 있는지 확인
            output2El.innerHTML = "<small style='color:red'>닉네임을 입력해주세요.</small>";
            return; // 입력 필드가 비어 있으면 더 이상 진행하지 않음
        }
        fetch('/nickNameCheck?nickName=' + encodeURIComponent(nickNameInputEl.value))
            .then(response => response.text())
            .then((data) => {
                console.log(data);
                output2El.innerHTML = data;

                if (data.includes('사용가능한 닉네임입니다')) {
                    submitBtnEl.disabled = false; // 제출 버튼 활성화
                } else {
                    submitBtnEl.disabled = true;  // 제출 버튼 비활성화
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // 초기에는 제출 버튼을 비활성화
    submitBtnEl.disabled = true;

    // 아이디 입력 필드가 변경될 때마다 제출 버튼 비활성화
    NicknameInputEl.oninput = function() {
        submitBtnEl.disabled = true;
        output2El.innerHTML = '';
    }
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

</body>
</html>