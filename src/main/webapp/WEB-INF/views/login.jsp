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
html, body {
    height: 100%;
    margin: 0;
    background-color: #f7f7f7;
}

.headerImg {
    text-align: center;
    padding-top: 1em;
    padding-bottom: 0.7em;
}

input[type="button"] {
    font-size: 0.75rem;
    padding: 5px 10px;
}

.login-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: rgba(255, 255, 255, 1);
    border-radius: 10px;
    padding: 40px 30px;
    border: 1px solid #0e0e0e;
    width: 350px;
    filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .5));
}

.form-group label {
    font-size: 0.75rem;
    margin: 5px 10px;
}

#login-btn-box {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 15px;
}
</style>
</head>
<body>
<div id="container">
    <!-- login Box -->
    <div class="login-box">
        <div class="headerImg">
            <a href="/">
                <img alt="Logo" src="/images/logo.png" style="width:70%; height:70%;">
            </a>
        </div>

        <div class="IdPwForm" style="margin-bottom:30px;">
            <form action="/loginProcess" method="post" name="loginForm">
                <div class="form-group mb-3">
                    <label class="fs-5">아이디</label>
                    <input type="text" name="id" id="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="fs-5">비밀번호</label>
                    <input type="text" name="pw" id="password" class="form-control" value="" autocomplete="off" required>
                </div>
                <div id="login-btn-box" style="text-align:center; margin-bottom:20px;">
                    <button type="submit" id="btnLogin" class="btn btn-primary">로그인버튼</button>
                </div>
            </form>
        </div>
        <div style="text-align: center; margin-bottom: 30px;">
            <a href="/totalJoin">회원가입</a>
        </div>
    </div>
</div>

</body>
</html>