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
	margin-top :60px;
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
				<li><a href="/personUpdateForm">정보 수정</a></li>
				<li><a href="/myPage/Order">주문 정보</a></li>
				<li><a href="/myPage/delivery">배송지 관리</a></li>
				<li><a href="#">관심상품</a></li>
				<li><a href="/myPage/cart">장바구니</a></li>
				<li><a href="/accountDeleteForm">회원탈퇴</a></li>
			</ul>
		</nav>
	</aside>
</body>
</html>