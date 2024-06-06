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
	<form action="/loginProcess" method="post" name="loginForm">
		<input type="text" name="username" id="username">
		 <input type="text" name="password" id="password">
		<button type="submit">로그인버튼</button>
	</form>
	<div>
	<a href="/join">회원가입</a></div>
</body>
</html>