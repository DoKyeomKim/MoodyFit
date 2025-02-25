<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 수정/삭제</title>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
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
    padding: 15px; /* 셀 내부 여백 조정 */
    margin: 15px; /* 셀 외부 여백 조정 */
}
.container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}
.container > * {
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
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}


.select-container {
    display: flex;
    align-items: center;
    margin-left: 1000px;
}

select {
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
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
<div class="container">
    <div class="mt-3">
        <h3 class="text-center">상위 카테고리 관리</h3>
    </div>
    <div class="select-container">  
       <select onchange="navigateToPage(this)">
           <option value="">카테고리 분류</option>
           <option value="/adminCategoryUpdate">상위 카테고리</option>
           <option value="/adminCategoryUpdate2">하위 카테고리</option>                      
       </select>
    </div>
</div>       
            
<hr class="mb-3">
<div class="table-container">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>번호</th>
                        <th>카테고리 한글명</th>
                        <th>카테고리 영문명</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categoryList}" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                            <td>${category.categoryIdx }</td>
                            <td>${category.korName}</td>
                            <td>${category.engName}</td>
                            <td>
                                <button class="btn btn-delete" onclick="openUpdateModal(${category.categoryIdx}, '${category.korName}', '${category.engName}')">수정</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 수정 모달 -->
<div id="updateModal">
  <h2>카테고리 수정</h2>
    <form id="updateForm" method="post" action="/updateCategory">
        <input type="hidden" name="categoryIdx" id="categoryIdx">
    <label for="korName">카테고리 한글명:</label>
        <input type="text" name="korName" id="korName">
        <label for="engName">카테고리 영문명:</label>
        <input type="text" name="engName" id="engName">
        <div class="btn-group">
            <button type="submit" class="btn-update">수정</button>
            <button type="button" class="btn-cancel" onclick="closeUpdateModal()">취소</button>
        </div>
    </form>
</div>

<script>
function navigateToPage(selectElement) {
    var selectedPage = selectElement.value;
    if (selectedPage) {
        window.location.href = selectedPage;
    }
}

function openUpdateModal(categoryIdx, korName, engName) {
    document.getElementById('categoryIdx').value = categoryIdx;
    document.getElementById('korName').value = korName;
    document.getElementById('engName').value = engName;
    document.getElementById('updateModal').style.display = 'block';
}

function closeUpdateModal() {
    document.getElementById('updateModal').style.display = 'none';
}

function deleteCategory(categoryIdx) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        window.location.href = '/deleteCategory?categoryIdx=' + categoryIdx;
    }
}
</script>

</main>
</body>
</html>
