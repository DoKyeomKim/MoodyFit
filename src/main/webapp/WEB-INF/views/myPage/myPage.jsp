<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
main{
	padding-left:200px;
}
</style>

</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>
		<h2 style="text-align:center; margin-top:30px;"> my page</h2>
		<hr>
	<%@include file="/WEB-INF/layouts/aside.jsp"%>

	<main style="margin-top:70px;">
		<div class="hello-users" style="margin-left:30px;">
			<h5>${person.nickName} 님 반갑습니다.</h5>
		</div>
	</main>
	<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>