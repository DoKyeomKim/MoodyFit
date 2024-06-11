<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


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
.btn-update {
  background-color: #f4f4f4;
    color: #333;
}

/* 반려 버튼 스타일 */
.btn-delete {
  background-color: #111111;
    color: #fff;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
   <div class="col-sidebar">
                <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
            </div>

<main>

<input type="hidden" value="{store_idx}" id="storeIdx">
<h3 class="mt-3 text-center">가맹점 관리</h3>
<hr class="mb-3">
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>번호</th>
                        <th>가맹점 이름</th>
                        <th>매니저 이름</th>
                        <th>사업자 번호</th>
                        <th>이메일</th>
                        <th >전화번호</th>
                        <th >주소</th>
                        <th >상세주소</th>
                  
                        <th >작업</th>
                    </tr>
                </thead>
                <tbody>
      
                    <c:forEach var="store" items="${storeList}">
                        <tr>
                            <td>${store.storeIdx}</td>
                            <td>${store.storeName}</td>
                            <td>${store.managerName}</td>
                            <td>${store.businessNumber}</td>
                            <td>${store.email}</td>
                            <td>${store.phone}</td>
                            <td>${store.address}</td>
                            <td>${store.detailAddress}</td>
                    
                                <td>
                               
                                <button class="btn btn-delete" onclick="updateStatus(${company.id}, 'rejected')">탈퇴</button>
                            </td>
                        </tr>
                        <tr>
                       
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</main>


<script>
</script> 

</body>
</html>