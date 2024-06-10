<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 - ${categoryEngName}</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
.cateDefault {
	text-align: center;
}

.subCateDefault {
	text-align: center;
}

.subCateDefault a {
	text-decoration: none;
	margin: 20px;
	color: black;
}

.subCateDefault a:hover {
	color: grey;
}

</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<br><br>
<div class="cateDefault"><h3>${categoryEngName}</h3></div>
	<div class="subCateDefault">
		<c:forEach var="subCategory" items="${subCategories}">
	   	<a href="/category/${categoryEngName}/${subCategory.engName}">
		    <c:choose>
			  	<c:when test="${subCategory.korName == '전체'}">All</c:when>
				  <c:otherwise>${subCategory.korName}</c:otherwise>
		    </c:choose>
	   	</a>
		</c:forEach>
	</div>

<h3>${defaultSubCategory.korName}</h3>
<br><br>
total""items.

<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
