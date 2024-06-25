<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역 관리</title>

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
    border: none;
    padding: 5px 10px;
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
<h3 class="mt-3 text-center">주문내역 관리</h3>
<hr class="mb-3">
<form action="${pageContext.request.contextPath}/admin/userManagement6" method="get" class="search-container">
    <div class="form-group mb-2">
        <label for="searchId" class="sr-only"></label>
        <input type="text" name="searchId" id="searchId" class="form-control" placeholder="아이디를 입력하세요">
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
                  <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                        <th>번호</th>
                        <th>아이디</th>
                        <th>상품명</th>
                        <th>주문수량</th>
                        <th>상품가격</th>
                        <th>배송비</th>
                        <th>총가격</th>
                        <th>주문일자</th>
<!--                         <th>상태</th> -->
                    </tr>
                </thead>
                <tbody>
           
                    <c:forEach var="order" items="${adminOrderList}" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                            <td>${order.orderIdx}</td>
                            <td>${order.id}</td>
                            <td>${order.name}</td>
                            <td>${order.amount}</td>
                            <td>${order.price}</td>
                            <td>${order.deliveryPrice}</td>
                            <td>${order.totalPrice}</td>
                            <td>${order.orderDate}</td>
<!--                             <td> -->
<%--                                 <button class="btn btn-update" onclick="updateStatus(${company.id}, 'approved')">수정</button> --%>
<%--                                 <button class="btn btn-delete" onclick="updateStatus(${company.id}, 'rejected')">삭제</button> --%>
<!--                             </td> -->
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