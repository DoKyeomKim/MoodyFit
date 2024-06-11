<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<style>
html, body {
    height: 100%;
    margin: 0;
    background-color: #f7f7f7;
    display: flex;
    justify-content: center;
    align-items: center;
}

.headerImg {
    text-align: center;
    padding-top: 1em;
    padding-bottom: 0.7em;
}


.login-box {
    background-color: rgba(255, 255, 255, 1);
    border-radius: 10px;
    padding: 40px 30px;
    border: 1px solid #0e0e0e;
    width: 350px;
    filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .5));
}

.vertical-align {
    display: flex;
    flex-direction: column;
    align-items: center;
}

#login-btn-box {
    display: flex;
    justify-content: center;
    margin-top: 15px;
}

.form-group label {
    font-size: 0.75rem;
    margin: 5px 10px;
}

/* 새로운 스타일 추가 */
.flex-container {
    display: flex;
    flex-direction: row; /* 자식 요소들을 수평으로 정렬하기 위해 row로 설정 */
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    width: 100%; /* 부모 요소를 꽉 채우도록 설정 */
}

.flex-item {
    width: 100%;
    margin-bottom: 20px;
}
</style>
</head>
<body>
<div id="container">
    <!-- login Box -->
    <div class="login-box vertical-align">
        <div class="headerImg">
            <a href="/">
                <img alt="Logo" src="/images/logo.png" style="width:70%; height:70%;">
            </a>
        </div>
        
        <div class="container-fluid" style="width:400px;">
            <div class="IdPwForm" style="margin-bottom:10px;">
                <form action="/loginProcess" method="post" name="loginForm">
                    <!-- 새로운 부모 요소 추가 -->
                    <div class="flex-container">
                        <div class="id-pw-write flex-item" style="margin-right:20px;">
                            <div class="form-group mb-3">
                                <input type="text" name="id" id="username" placeholder="아이디" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <input type="text" name="pw" id="password" placeholder="비밀번호" class="form-control" autocomplete="off" required>
                            </div>
                        </div>
                        <!-- login-btn-box도 새로운 flex-item으로 감싸줌 -->
                        <div class="login-btn-box flex-item">
                            <button type="submit" id="btnLogin" class="btn btn-primary" style="height:90px;">로그인</button>
                        </div>
                    </div>
                </form>
                <div class="center-align" style="margin-left:100px;">
                    <a href="/totalJoin">회원가입</a>
                </div>
            </div>
        </div>
                <hr style="width: 80%;">
			<a href="/oauth2/authorization/naver">네이버로그인</a>
        

    </div>
</div>

</body>
</html>