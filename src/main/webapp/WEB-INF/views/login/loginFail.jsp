<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실패</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
    body {
        background-color: #f8f9fa;
    }

    .container {
        max-width: 400px;
        margin: 100px auto;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
        font-size: 2.5rem;
        text-align: center;
        margin-bottom: 20px;
    }

    p {
        font-size: 1.2rem;
        text-align: center;
        margin-bottom: 20px;
    }

    a {
        display: block;
        width: 100%;
        text-align: center;
        font-size: 1.2rem;
    }
</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<div class="container">
    <h1>로그인 실패</h1>
    <p>아이디 또는 비밀번호가 맞지 않습니다. 다시 시도해 주세요.</p>
    <a href="/login" class="btn btn-primary mt-3">로그인 페이지로 돌아가기</a>
</div>

</html>