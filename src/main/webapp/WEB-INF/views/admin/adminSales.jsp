<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <script src="${pageContext.request.contextPath}/scripts.js"></script>
    <script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">

<style>

</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
   <div class="col-sidebar">
                <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
            </div>

<main>

<input type="hidden" value="{user_idx}" id="userIdx">
<h3 >가맹점별 판매수익 관리</h3>
<hr class="mb-3">
   <form action="${pageContext.request.contextPath}/admin/userManagement9" method="get" class="search-container">
    <div class="form-group mb-2">
        <label for="searchId" class="sr-only"></label>
        <input type="text" name="searchId" id="searchId" class="form-control" placeholder="가맹점 이름 입력">
    </div>
<button class="header-search-btn" type="submit">
        <i class="fa-solid fa-magnifying-glass"></i>
    </button></form>
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>가맹점 이름</th>
                        <th>판매 건수</th>
                        <th>판매 수익</th>
                        <th >수수료</th>
                     
                    </tr>
                </thead>
                <tbody>
      
                    <c:forEach var="sales" items="${salesList}" varStatus="status">
                       <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                            <td>${sales.storeName}</td>
                            <td>${sales.orderCount}</td>
                            <td>${sales.totalPrice}</td>
                            <td>${sales.totalPrice*0.07}</td>
                           
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