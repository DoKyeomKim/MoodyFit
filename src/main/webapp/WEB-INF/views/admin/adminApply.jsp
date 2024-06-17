<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가맹점 공고 관리</title>
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
    font-size : 15px;
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
    margin-top:30px;
}
/* 승인 버튼 스타일 */
.btn-success {
    background-color: #f4f4f4;
    color: #333;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}
/* 반려 버튼 스타일 */
.btn-danger {
    background-color: #111111;
    color: #fff;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}
</style>
<script>
function confirmAction(form, message) {
    if (confirm(message)) {
        form.submit();
    }
}
</script>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<main>
    <h3>가맹점 공고 관리</h3>
    <hr class="mb-3">
    <div class="container mt-3">
        <div class="row">
            <div class="col-main">
                <table class="table table-bordered">
                    <thead class="table-secondary">
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일</th>
                            <th>상태</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="apply" items="${adminApplyList}">
                            <tr>
                                <td>${apply.postingIdx}</td>
                                <td>${apply.title}</td>
                                <td>${apply.updateDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${apply.state==1}">승인</c:when>
                                        <c:when test="${apply.state==2}">반려</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/updateStatus" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${apply.postingIdx}">
                                        <input type="hidden" name="state" value="1">
                                        <button class="btn btn-success" type="button" onclick="confirmAction(this.form, '승인하시겠습니까?')">승인</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/updateStatus" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${apply.postingIdx}">
                                        <input type="hidden" name="state" value="2">
                                        <button class="btn btn-danger" type="button" onclick="confirmAction(this.form, '반려하시겠습니까?')">반려</button>
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
</body>
</html>
