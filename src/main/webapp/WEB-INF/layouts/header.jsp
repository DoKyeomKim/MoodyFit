<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<style>
.search-box {
	height:50px;
	width:340px;
	background: white;
	border-radius:40px;
	padding:10px;
	border:1px solid #ccc;
}

.search-txt{
	border:none;
	background:none;
	outline:none;
	float:left;
	padding:0px;
	padding-left:10px;
	color:#797979;
	font-size:16px;
	line-height:30px;
	width:260px;
}

.search-btn{
	color: black;
	float:right;
	width:40px;
	height:100%;
	border-radius:50%;
	background:white;
	border:none;
	font-size:16px;
	display:flex;
	justify-content: center;
	align-items:center;
}

#navbarNav{
	margin:0 50px;
}

</style>
</head>
<body>
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-md-8" style="margin-left :15px;">
            <div class="logo-img">
                <a href="/"><img src="/images/logo.png" style="height: 150px; width:auto;"></a>
            </div>
        </div>
        <div class="col-md-3">
                <form class="search-box" action="/search?keyword=${keyword}" method="GET">
                    <input class="search-txt" id="search-txt" type="keyword" name="keyword"placeholder="검색할 내용을 입력해주세요.">
                    <button class="search-btn" type="submit">
                    	<i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
        </div>
    </div>
</div>

	
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNav">
        <ul class="navbar-nav">
            <c:forEach var="category" items="${category}">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/${category.engName}">${category.korName}</a>
                </li>
            </c:forEach>
        </ul>
        
		<div class="d-flex">
		    <security:authorize access="isAuthenticated()">
		    <c:choose>
		        <c:when test="${sessionScope.role == 'ROLE_PERSON'}">
		            <div style="margin-right:20px;"><a href="/myPage">마이페이지</a></div>
		        </c:when> 
		        <c:when test="${sessionScope.role == 'ROLE_STORE'}">
		            <div style="margin-right:20px;"><a href="/storeMyPage">마이페이지</a></div>
		        </c:when>
		    </c:choose>
		            <a href="<c:url value='/logout' />">로그아웃</a>
		    </security:authorize>
		    <security:authorize access="!isAuthenticated()">
		        <a href="<c:url value='/login' />">로그인</a>
		    </security:authorize>
		</div>
    </div>
</nav>

    <script>
    document.querySelector('.search-box').addEventListener('submit', function(event) {
        var searchInput = document.getElementById('search-txt').value;
        if (!searchInput) {
            alert('검색할 내용을 입력해주세요!');
            event.preventDefault(); // 폼 제출을 막음
        }
    });
    </script>				
</body>
</html>