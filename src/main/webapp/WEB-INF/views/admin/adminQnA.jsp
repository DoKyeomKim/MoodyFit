<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 관리</title>
<script src="${pageContext.request.contextPath}/scripts.js"></script>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
<style>
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
}
main {
    width: 90%;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    font-size: 15px;
}
.table td {
    padding: 30px; /* 셀 내부 여백 조정 */
    margin: 30px; /* 셀 외부 여백 조정 */
}
.container {
    display: flex;
    flex-wrap: wrap;
}

.container > * {
    flex: 1;
    margin-right: 30px; /* Adjust as needed */
}

.container > *:last-child {
    margin-right: 0;
}

/* Adjust column widths as needed */
.col-main {
    flex: 3; /* Main content width */
}

.col-sidebar {
    flex: 1; /* Sidebar content width */
    margin-top: 30px;
}

.btn-update {
    background-color: #f4f4f4;
    color: #333;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%>
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<main>
<h3 class="mt-3 text-center">Q&A 관리</h3>
<hr class="mb-3">
<form action="${pageContext.request.contextPath}/admin/userManagement4" method="get" class="search-container">
    <div class="form-group mb-2">
        <label for="searchId" class="sr-only"></label>
        <input type="text" name="searchId" id="searchId" class="form-control" placeholder="제목을 입력하세요">
    </div>
    <button class="header-search-btn" type="submit">
        <i class="fa-solid fa-magnifying-glass"></i>
    </button>
</form>
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>수정일</th>
                        <th>상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="qna" items="${AdminqnaList}" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                            <td>${qna.questionIdx}</td>
                            <td>${qna.id}</td>
                            <td>${qna.title}</td>
                            <td>${qna.createDate}</td>
                            <td>${qna.updateDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${qna.state == 1}">답변대기</c:when>
                                    <c:when test="${qna.state == 2}">답변완료</c:when>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-delete" onclick="location.href='/qnaDetail?questionIdx=${qna.questionIdx}'">답변</button>
                                <form action="${pageContext.request.contextPath}/admin/qna1" method="post" style="display: inline;">
                                    <input type="hidden" name="questionIdx" value="${qna.questionIdx}">
                                    <button type="submit" class="btn btn-delete" onclick="confirmComplit(event, this.form)">완료</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</main>
<script>
function confirmComplit(event, form) {
    event.preventDefault(); // 폼 제출 방지
    if (confirm("정말로 완료하시겠습니까?")) {
        form.submit(); // 확인 버튼 클릭 시 폼 제출
    }
}
</script>
</body>
</html>
