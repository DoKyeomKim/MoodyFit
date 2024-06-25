<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인회원 관리</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
<script src="${pageContext.request.contextPath}/scripts.js"></script>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<style>



</style>
<script>
function confirmDelete(event, form) {
    event.preventDefault();
    if (confirm('정말로 추방하시겠습니까?')) {
        form.submit();
    }
}

window.addEventListener('scroll', function() {
    var header = document.querySelector('.fixed-header');
    var logo = document.getElementById('logo');
    if (window.scrollY > 50) {
        header.classList.add('scrolled');
        logo.src = '/images/white_logo.png'; 
    } else {
        header.classList.remove('scrolled');
        logo.src = '/images/logo.png'; 
    }
});
</script>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<main>
<input type="hidden" value="{user_idx}" id="userIdx">
<h3 class="mt-3 text-center">개인회원 관리</h3>
<hr class="mb-3">
<form action="${pageContext.request.contextPath}/admin/userManagement" method="get" class="search-container">
    <div>
        <label for="searchId" class="sr-only"></label>
        <input type="text" name="searchId" id="searchId" class="form-control" placeholder="아이디를 입력하세요">
        <button class="header-search-btn" type="submit">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </div>
</form>
<div class="table-container">
    <table class="table table-bordered">
        <thead class="table-secondary">
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>이름</th>    
                <th>닉네임</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>주소</th>
                <th>상세주소</th>
                <th>상태</th>
                <th>작업</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="person" items="${personList}" varStatus="status">
                <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                    <td>${person.personIdx}</td>
                    <td>${person.id}</td>
                    <td>${person.name}</td>
                    <td>${person.nickName}</td>
                    <td>${person.phone}</td>
                    <td>${person.email}</td>
                    <td>${person.address}</td>
                    <td>${person.detailAddress}</td>
                    <td>
                        <c:choose>
                            <c:when test="${person.state==1}">회원</c:when>
                            <c:when test="${person.state==2}">탈퇴회원</c:when>
                            <c:when test="${person.state==3}">추방회원</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/dropId2?userIdx=${person.userIdx}" method="post">
                            <input type="hidden" name="userIdx" value="${person.userIdx}">
                            <button type="button" class="btn btn-delete" onclick="confirmDelete(event, this.form)">추방</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</main>
</body>
</html>
