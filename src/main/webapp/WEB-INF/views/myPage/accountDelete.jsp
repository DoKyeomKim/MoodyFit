<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
</style>

</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>
	<section id="section">

		<div class="delete-info mt-5 mb-5" style="text-align: center;">
			<h2 class="mb-5">정말 회원탈퇴 하시겠습니까?</h2>
			<h4>회원탈퇴 후 작성하신 글의 수정,삭제가 불가능하며 복구가 어려울 수 있습니다.</h4>
			<a class="mt-5 mb-5" href="javascript:history.back()"
				style="text-decoration: none;">회원을 유지하겠습니다.</a>
		</div>

		<div class="delete-btn mt-5" style="text-align: center;">
			<form id="deleteForm" action="/accountDelete" method="post">
				<button type="button" class="btn btn-outline-danger"
					onclick="confirmDelete()">회원탈퇴</button>
			</form>
		</div>

	</section>
	<script src="/js/bootstrap.bundle.min.js"></script>
<script>
	function confirmDelete() {
	    const userInput = prompt("정말로 삭제하시겠습니까? '회원탈퇴'라고 입력해 주세요.");
	    if (userInput === null) { // 사용자가 취소를 누른 경우
	        alert("회원탈퇴가 취소되었습니다.");
	        return false;
	    }
	    if (userInput === '회원탈퇴') {
	    	alert("회원탈퇴가 완료 되었습니다.")
	        document.getElementById("deleteForm").submit();
	    } else {
	        alert("아이디가 일치하지 않습니다. 회원탈퇴가 취소되었습니다.");
	    }
	}
</script>
</body>
</html>