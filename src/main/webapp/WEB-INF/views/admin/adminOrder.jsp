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
    font-size: 15px;
}
.table td {
    padding: 10px;
    margin: 10px;
}
.container {
    display: flex;
    flex-wrap: wrap;
}
.container > * {
    flex: 1;
    margin-right: 30px;
}
.container > *:last-child {
    margin-right: 0;
}
.col-main {
    flex: 3;
}
.col-sidebar {
    flex: 1;
    margin-top: 30px;
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
.hidden { display: none; }
.paging { margin: 10px; text-align: center; }
.paging a { margin: 0 5px; cursor: pointer; text-decoration: none; }
.paging a.active { font-weight: bold; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    var rowsPerPage = 10;
    var rows = $('#orderTable tbody tr');
    var rowsCount = rows.length;
    var pageCount = Math.ceil(rowsCount / rowsPerPage);
    var numbers = $('.paging');

    for (var i = 1; i <= pageCount; i++) {
        numbers.append('<a href="#" class="page-link">' + i + '</a>');
    }

    rows.hide();
    rows.slice(0, rowsPerPage).show();
    numbers.find('a:first').addClass('active');

    numbers.on('click', 'a', function(e) {
        e.preventDefault();
        numbers.find('a').removeClass('active');
        $(this).addClass('active');

        var page = $(this).text();
        var start = (page - 1) * rowsPerPage;
        var end = start + rowsPerPage;

        rows.hide();
        rows.slice(start, end).show();
    });
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
<h3 class="mt-3 text-center">주문내역 관리</h3>
<hr class="mb-3">
<form action="${pageContext.request.contextPath}/userManagement6" method="get" class="search-container">
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
            <table id="orderTable" class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>상품명</th>
                        <th>주문수량</th>
                        <th>상품가격</th>
                        <th>배송비</th>
                        <th>총가격</th>
                        <th>주문일자</th>
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
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="paging"></div>
        </div>
    </div>
</div>
</main>
</body>
</html>
