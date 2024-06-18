<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
    .find-modal-id {
        max-width: 400px; /* 폼의 최대 너비 설정 */
        margin: auto; /* 중앙 정렬 */
        margin-top: 20px; /* 상단 여백 */
    }
    .find-id-group {
        margin-bottom: 5px; /* 폼 그룹 간격 조정 */
    }
    /* 버튼 가운데 정렬을 위한 스타일 */
    .center-btn {
        display: flex;
        justify-content: center;
    }
    #findIdResult{
    text-align:center;
    margin-top:10px;
    }
</style>
</head>
<body>
<div class="container find-modal-id">
    <form id="findIdForm" action="/findId" method="post">
        <div class="form-group d-flex find-id-group" style="margin-left:50px;">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="findIdMethod" value="phone" onclick="toggleInput('phone')" checked>
                <label class="form-check-label">휴대폰 번호로 찾기</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="findIdMethod" value="email" onclick="toggleInput('email')">
                <label class="form-check-label">이메일로 찾기</label>
            </div>
        </div>

        <div id="phoneInput" class="form-group find-id-group">
            <label for="phoneInput">휴대폰 번호:</label>
            <input type="text" class="form-control" id="phoneInputValue" name="phone">
        </div>

        <div id="emailInput" class="form-group find-id-group" style="display: none;">
            <label for="emailInput">이메일:</label>
            <input type="text" class="form-control" id="emailInputValue" name="email">
        </div>
        
		<div style="text-align:center; margin-top:10px;">
        	<button type="button" class="btn btn-primary btn-block" onclick="findId()">아이디 찾기</button>
        </div>
    </form>

    <!-- 결과를 표시할 div 추가 -->
    <div id="findIdResult" ></div>
</div>


	<script>
    function toggleInput(method) {
        var phoneInput = document.getElementById('phoneInput');
        var emailInput = document.getElementById('emailInput');
        
        if (method === 'phone') {
            phoneInput.style.display = 'block';
            emailInput.style.display = 'none';
        } else if (method === 'email') {
            phoneInput.style.display = 'none';
            emailInput.style.display = 'block';
        }
    }
    
    function findId() {
        var method = document.querySelector('input[name="findIdMethod"]:checked').value;
        var phone = document.getElementById('phoneInputValue').value;
        var email = document.getElementById('emailInputValue').value;
        
        fetch('/findId', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                findIdMethod: method,
                phone: phone,
                email: email
            })
        })
        .then(response => response.text())
        .then(data => {
            document.getElementById('findIdResult').innerHTML = data;
            $('#findIdModal').modal('show');
        })
        .catch(error => {
            console.error('아이디 찾기에 실패했습니다.', error);
            alert('아이디 찾기에 실패했습니다.');
        });
    }
    </script>
</body>
</html>