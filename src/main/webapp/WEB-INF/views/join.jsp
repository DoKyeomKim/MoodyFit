<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
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
  	<form action="/joinProcess" method="post" name="joinForm">
	    <tr>
	      <th>아이디</th>
	      <td><input type="text" name="id" id="username" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td><input type="password" name="pw" id="password" oninput="pwCheck()" style="width: 100%;" required></td>
	    </tr>
	    <tr>
	      <th>비밀번호 확인</th>
	      <td><input type="password" id="password2" oninput="pwCheck()" style="width: 100%;" required>
	      <span id="pwConfirm" style="display: block;"></span>
	      </td>
	    </tr>
	    <tr>
	      <th>이름</th>
	      <td><input type="text" name="name" id="name" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>닉네임</th>
	      <td><input type="text" name="nickName" id="nickName" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>우편번호</th>
	      <td><input type="text" name="postCode" id="postCode" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>주소</th>
	      <td><input type="text" name="address" id="address" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>상세주소</th>
	      <td><input type="text" name="detailAddress" id="detailAddress" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <th>전화번호</th>
	      <td>
	        <input type="text" name="phone" id="phone" style="width: 100%;">
	      </td>
	    </tr>
	    <tr>
	      <th>이메일</th>
	      <td><input type="email" name="email" id="email" style="width: 100%;"></td>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align: center;  border-left:none; border-bottom:none;">
	        <button type="submit" id="#submitBtn" class="btn btn-primary" style="margin-top: 20px;">회원가입</button>
	      </td>
	    </tr>
    </form>
  </table>
</main>


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