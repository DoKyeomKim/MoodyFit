<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<style>
    .hidden {
        display: none;
    }
</style>
</head>
<body>
	<c:choose>
		<c:when test="${not empty id }">
			<h2>회원님의 아이디는 ${id} 입니다.</h2>
		</c:when>
		<c:when test="${empty id }">
			<h2>회원 정보가 없습니다.</h2>
		</c:when>
	</c:choose>
</body>
</html>