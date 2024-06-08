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
</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
    <h1>Login Failed</h1>
    <p>아이디 또는 비밀번호가 맞지 않습니다. 다시 시도해 주세요.</p>
    <a href="/login">로그인 페이지로 돌아가기</a>
<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>