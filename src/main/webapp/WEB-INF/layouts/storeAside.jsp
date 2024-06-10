<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#sidebar {
	float: left;
	width: 200px;
	height: auto;
	border: 1px solid gray;
}
#sidebar nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    margin-top:30px;
    text-align:center;
}

#sidebar nav ul li {
    margin-bottom: 10px;
}
</style>
</head>
<body>
	<aside id="sidebar">
		<nav>
			<ul>
				<li><a href="/storeUpdateForm">정보 수정</a></li>
				<li><a href="#">공고 관리</a></li>
				<li><a href="#">물품 관리</a></li>
				<li><a href="#">주문 내역</a></li>
				<li><a href="/accountDeleteForm">회원탈퇴</a></li>
			</ul>
		</nav>
	</aside>
</body>
</html>