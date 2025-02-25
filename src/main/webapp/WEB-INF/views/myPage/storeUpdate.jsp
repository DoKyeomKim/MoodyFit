<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편집샵 정보수정</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
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
    th.required::after {
        content: " *";
        color: red;
    }
  </style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<main>
<form action="/storeUpdate" method="post" name="updateForm">
<h4 class="text-center">편집샵 정보수정</h4>
<div class="required-table">
    <div class="required-table-header">필수입력</div>
    <table class="table table-bordered">
        <input type="hidden" value="${result.STORE_IDX}" name="storeIdx">
        <tr>
          <th>아이디</th>
          <td style="padding-left:21px;">${result.ID}</td>
        </tr>
        <tr>
          <th>비밀번호</th>
          <td><input type="password" class="form-control" name="pw" id="password" oninput="pwCheck()" placeholder="변경을 원하실 경우 입력해주세요."></td>
        </tr>
        <tr>
          <th>비밀번호 확인</th>
          <td><input type="password" class="form-control" id="password2" oninput="pwCheck()" placeholder="비밀번호를 다시 한번 입력해주세요">
          <span id="pwConfirm" style="display: block;"></span>
          </td>
        </tr>
        <tr>
          <th>편집샵명</th>
          <td><input type="text" class="form-control" name="storeName" id="name" value="${result.STORE_NAME}"></td>
        </tr>
        <tr>
          <th>담당자명</th>
          <td><input type="text" class="form-control" name="managerName" id="nickName" value="${result.MANAGER_NAME}"></td>
        </tr>
        <tr>
          <th>사업자 등록번호</th>
          <td style="padding-left:21px;">${result.BUSINESS_NUMBER}</td>
        </tr>
        <tr>
          <th>우편번호</th>
          <td>
          <div class="form-inline flex-container">
            <input type="text" name="postCode" class="form-control" id="sample6_postcode" value="${result.POST_CODE}" placeholder="우편번호">
            <input type="button" class="btn btn-sm btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
          </div>
          </td>
        </tr>
        <tr>
          <th>주소</th>
          <td><input type="text" name="address" class="form-control" id="sample6_address" value="${result.ADDRESS}" placeholder="주소"></td>
        </tr>
        <tr>
          <th>상세주소</th>
          <td><input type="text" name="detailAddress" class="form-control" id="sample6_detailAddress" value="${result.DETAIL_ADDRESS}" placeholder="상세주소를 입력해주세요"></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input type="text" name="phone" class="form-control" id="phone" value="${result.PHONE}"></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="email" name="email" class="form-control" id="email" value="${result.EMAIL}"></td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <button type="submit" id="submitBtn" class="btn btn-primary">정보 수정</button>
            <a href="/storeMyPage" class="btn btn-secondary">취소하기</a>
          </td>
        </tr>
    </table>
</div>
</form>
</main>

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
</body>
</html>