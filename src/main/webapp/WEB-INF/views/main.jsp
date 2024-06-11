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
<h2><security:authentication property="name"/></h2>
<script src="/js/bootstrap.bundle.min.js"></script>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</body>
</html>