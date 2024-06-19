<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
.search-cols {
	display: flex;
	justify-content: center;
	align-items: center;
}
.header-search-box {
	height: 50px;
	width: 700px;
	background: white;
	border-radius: 40px;
	padding: 10px;
	border: 1px solid #ccc;
}

.header-search-txt {
	border: none;
	background: none;
	outline: none;
	float: left;
	padding: 0px;
	padding-left: 10px;
	color: #797979;
	font-size: 16px;
	line-height: 30px;
	width: 600px;
}

.header-search-btn {
	color: black;
	float: right;
	width: 40px;
	height: 100%;
	border-radius: 50%;
	background: white;
	border: none;
	font-size: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#navbarNav {
	display: flex;
	justify-content: center;
	
}
#header-category {
    font-weight: normal; 
    transition: text-shadow 0.3s ease;
}

#header-category:hover {
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5); /* 글씨가 약간 두꺼워지는 효과 */
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row align-items-center" style="text-align:center;">
			<div class="col">
				<div class="logo-img">
					<a href="/"><img src="/images/logo.png"
						style="height: 100px; width: auto;"></a>
				</div>
			</div>
			<div class="col-md-8 search-cols">
				<form class="search-box header-search-box" action="/search?keyword=${keyword}"
					method="GET">
					<input class="search-txt header-search-txt" id="search-txt" type="keyword"
						name="keyword" placeholder="검색할 내용을 입력해주세요.">
					<button class="search-btn header-search-btn" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
			<div class="col">
				<security:authorize access="isAuthenticated()">
					<c:choose>
						<c:when test="${sessionScope.role == 'ROLE_PERSON'}">
								<a href="/myPage" style="text-decoration-line: none;">마이페이지</a>
						</c:when>
						<c:when test="${sessionScope.role == 'ROLE_STORE'}">
								<a href="/storeMyPage" style="text-decoration-line: none;">마이페이지</a>
						</c:when>
					</c:choose>
					<a href="<c:url value='/logout' />" style="text-decoration-line: none;">로그아웃</a>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<a href="<c:url value='/login' />" style="text-decoration-line: none;">로그인</a>
				</security:authorize>
			</div>
		</div>
	</div>



	<nav class="navbar navbar-expand-lg navbar-light bg-white">
		<div class="collapse navbar-collapse"
			id="navbarNav">
			<ul class="navbar-nav">
				<c:forEach var="category" items="${category}">
					<li class="nav-item" style="margin-right:30px; font-size:18px;">
						<a id="header-category" class="nav-link active" aria-current="page" href="/category/${category.engName}">${category.korName}</a>
					</li>
				</c:forEach>
			</ul>

			<div class="d-flex"></div>
		</div>
	</nav>

<script>
document.querySelector('.search-box')
	.addEventListener(
	'submit',
	function(event) {
		var searchInput = document
				.getElementById('search-txt').value;
		if (!searchInput) {
			alert('검색할 내용을 입력해주세요!');
			event.preventDefault(); // 폼 제출을 막음
		}
	});
</script>
</body>
</html>