<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 관리</title>
    <script src="${pageContext.request.contextPath}/scripts.js"></script>
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
.col-main {
    flex: 3; /* Main content width */
}
.col-sidebar {
    flex: 1; /* Sidebar content width */
    margin-top:30px;
}
.btn-update {
    background-color: #f4f4f4;
    color: #333;
}
.btn-delete {
    background-color: #111111;
    color: #fff;
}
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<main>
<input type="hidden" value="{user_idx}" id="userIdx">
<h3 class="mt-3 text-center">FAQ 관리</h3>
<hr class="mb-3">
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="faq" items="${faqList}" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                            <td>${faq.faqIdx}</td>
                            <td>${faq.title}</td>
                            <td>${faq.content}</td>
                            <td>
                                <button class="btn btn-update" onclick="openUpdateModal(${faq.faqIdx}, '${faq.title}', '${faq.content}')">수정</button>
                                <button class="btn btn-delete" onclick="deleteFAQ(${faq.faqIdx})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</main>

<!-- 수정 모달 -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeUpdateModal()">&times;</span>
        <h2>FAQ 수정</h2>
        <form action="/updateFaq" method="POST">
	        <input type="hidden" id="modalFaqIdx" name="faqIdx">
	        <label for="modalTitle">제목:</label>
	        <input type="text" id="modalTitle" name="title"><br><br>
	        <label for="modalContent" >내용:</label>
	        <textarea id="modalContent" rows="4" cols="50"name="content"></textarea><br><br>
	        <button type="submit">저장</button>
        </form>
    </div>
</div>

<script>
function openUpdateModal(faqIdx, title, content) {
    document.getElementById('modalFaqIdx').value = faqIdx;
    document.getElementById('modalTitle').value = title;
    document.getElementById('modalContent').value = content;
    document.getElementById('updateModal').style.display = 'block';
}

function closeUpdateModal() {
    document.getElementById('updateModal').style.display = 'none';
}



function deleteFAQ(faqIdx) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        window.location.href = '/deleteFaq?faqIdx=' + faqIdx;
    }
}
</script> 

</body>
</html>