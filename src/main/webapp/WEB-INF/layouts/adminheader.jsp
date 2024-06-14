<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<style>
    #gnb {
        border-bottom: 2px solid #c0c0c0;
        padding-bottom: 10px; /* Optional: to provide some spacing */
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .text-right {
        text-align: right;
    }
    .logo {
        height: 50px; /* Adjust this value based on your logo's size */
    }
 
</style>
</head>
<body>
<div id="gnb">
    <a href="/admin">
        <img src="/images/logo.png" alt="Logo" class="logo">
    </a>
    <div class="text-right">
        <span id="login_log" style="border-bottom: 1px solid white;">관리자 페이지입니다.</span>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="/logout" id="logout_btn">로그아웃</a>
        <input type="hidden" value="${login.id}" id="login_userid">
    </div>
</div>
</body>
</html>