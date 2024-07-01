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
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style>
html, body {
    height: 100%;
    margin: 0;
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

.flex-container {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    width: 100%;
}
.flex-item {
    width: 100%;
    margin-bottom: 20px;
}

.remember-find-container{
	display: flex;
    justify-content: space-between;
    align-items: center;
    width: 70%;
    margin-bottom:15px;
}
.find-id{
	text-decoration-line: none;
	color: black;
    font-size: 0.75rem;
}
.find-id:hover{
	text-decoration-line: underline;
	color: blue;
}

.join-container{
	font-weight : bold;
	text-decoration-line: none;
	color : black;
}

.join-container:hover{
	text-decoration-line: underline;
	color: blue;
}
</style>
</head>
<body>
<div class="modal fade" id="findIdModal" tabindex="-1" role="dialog" aria-labelledby="findIdModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="findIdModalLabel">아이디 찾기</h5>
            </div>
            <div class="modal-body">
                <div id="findIdContent">
                    <%@ include file="/WEB-INF/views/login/findId.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="container">
    <div class="login-box vertical-align">
        <div class="headerImg">
            <a href="/">
                <img alt="Logo" src="/images/logo.png" style="width:70%; height:70%;">
            </a>
        </div>
        
        <div class="container-fluid" style="width:400px;">
            <div class="IdPwForm" style="margin-bottom:10px;">
                <form id="loginForm" action="/loginProcess" method="post">
                    <div class="flex-container">
                        <div class="id-pw-write flex-item" style="margin-right:20px;">
                            <div class="form-group mb-3">
                                <input type="text" name="id" id="username" placeholder="아이디" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <input type="password" name="pw" id="password" placeholder="비밀번호" class="form-control" autocomplete="off" required>
                            </div>
                        </div>
                        <div class="login-btn-box flex-item">
                            <button type="submit" id="btnLogin" class="btn btn-primary" style="height:90px;">로그인</button>
                        </div>
                    </div>
                    <div class="remember-find-container">
						<div class="form-group">
						    <input type="checkbox" id="remember" name="remember_id">
						    <label for="remember">아이디 기억하기</label>
						</div>
		                <small class="form-group" >
		                    <a href="#" data-toggle="modal" data-target="#findIdModal" class="find-id">아이디 찾기</a>
		                </small>
		            </div>
                </form>
                <div class="center-align" style="margin-left:12%;">
                    <a href="/totalJoin" class="join-container">회원 가입 하시겠습니까?</a>
                </div>
            </div>
        </div>
        
        <hr style="width: 80%;">
        <div style="margin-bottom : 20px;">소셜 로그인</div>
        <div class="container" style="text-align:center;">
            <a href="/oauth2/authorization/naver"><img src="/images/naver.png" style="height:50px; width:50px; margin-right: 5px;"></a>
            <a href="/oauth2/authorization/google"><img src="/images/google.png" style="height:50px; width:50px; margin-left: 5px;"></a>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var savedId = getCookie("rememberedId");
        if (savedId) {
            document.getElementById("username").value = savedId;
            document.getElementById("remember").checked = true;
        }

        document.getElementById("loginForm").addEventListener("submit", function() {
            if (document.getElementById("remember").checked) {
                setCookie("rememberedId", document.getElementById("username").value, 30);
            } else {
                deleteCookie("rememberedId");
            }
        });
    });

    function setCookie(name, value, days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "expires=" + date.toUTCString();
        document.cookie = name + "=" + value + ";" + expires + ";path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    function deleteCookie(name) {
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
    }
</script>

</body>
</html>