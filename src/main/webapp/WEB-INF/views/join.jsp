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
	<form action="/joinProcess" method="post" name="joinForm">
		<input type="text" name="id" id="username">
		 <input type="text" name="pw" id="password">
		<button type="submit">회원가입</button>
	</form>
</body>
</html>