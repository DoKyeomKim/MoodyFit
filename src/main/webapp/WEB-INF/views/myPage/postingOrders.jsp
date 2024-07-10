<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매글 관리 리스트</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic,
		sans-serif;
	background-color: #F6F4EE;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

main {
	flex: 1;
	width: 80%;
	margin: 70px auto;
}

.main-container {
	margin-left: 160px;
	padding: 16px;
}

.table-container {
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 20px;
	margin: 10px 0;
	align-items: center;
	background-color: #fff;
	font-size: 14px;
}

.table {
	width: 100%;
	border-collapse: collapse;
	padding: 20px;
}

.table th, .table td {
	border: 1px solid #ddd;
	text-align: center;
}

.table th {
	background-color: #f4f4f4;
	color: #333;
}

.table td img {
	width: 50px;
	height: 50px;
	object-fit: cover;
}

.table tbody tr:nth-child(odd) {
	background-color: #f9f9f9;
}

.table tbody tr:nth-child(even) {
	background-color: #fff;
}

.button-container {
	text-align: center;
	margin-top: 10px;
	display: inline-block;
	vertical-align: top;
	margin-left: 10px;
}

.table-container a {
	text-decoration: none;
	color: inherit;
}

.table-container a:hover {
	text-decoration: none;
}

.table-container a:hover .table {
	border: 2px solid lightgrey;
	background-color: #f0f8ff;
}

h3 {
	text-align: left;
	margin-left: 30px;
	display: inline-block;
}

.paging { 
	margin: 10px; 
	text-align: center; 
}
.paging a { 
	margin: 0 5px; 
	cursor: pointer; 
	text-decoration: none; 
}
.paging a.active { 
	font-weight: bold; 
	color: red; 
}
.table tbody tr:hover td {
    background-color: #f0f8ff;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body style="background-color: #F6F4EE !important;">

	<%@ include file="/WEB-INF/layouts/mypageheader.jsp"%>
	<%@ include file="/WEB-INF/layouts/storeAside.jsp"%>

	<main>
		<div style="display: flex; align-items: center;">
			<h3 style="font-weight: bold;">내 주문 현황</h3>
		</div>

		<div id="postingList" class="tab-content">
			<div class="table-container">
			<c:choose>
			<c:when test="${not empty postingOrders }">
				<table class="table ordersTable">
					<thead>
						<tr>
							<th>No</th>
							<th>공고제목</th>
							<th>가격</th>
							<th>주문 수량</th>
							<th>주문금액</th>
							<th>판매일</th>
						</tr>
					</thead>
					<tbody id="postingListBody">
						<c:forEach var="postingOrders" items="${postingOrders}">
							<tr>
								<td>${postingOrders.ROW_NUM}</td>
								<td><a href="/postingDetail?postingIdx=${postingOrders.POSTING_IDX }">${postingOrders.TITLE}</a></td>
								<td class="new-price">${postingOrders.PRICE}</td>
								<td>${postingOrders.QUANTITY}</td>
								<td class="new-price">${postingOrders.TOTAL_PRICE}</td>
								<td class="order-date">${postingOrders.ORDER_DATE}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<div class="paging"></div>
			</c:when>
			<c:otherwise>
				<div style="text-align:center; margin : 50px 0;">
					<h3> 주문 내역이 없습니다!</h3>
				</div>
			</c:otherwise>
			</c:choose>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/layouts/footer.jsp"%>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			// 모든 new-price 클래스를 가진 요소를 선택합니다.
			var priceElements = document.querySelectorAll('.new-price');

			// 각 요소에 대해 숫자를 포맷팅합니다.
			priceElements
					.forEach(function(element) {
						var priceText = element.textContent.trim();
						// 숫자만 추출합니다.
						var priceNumber = parseInt(priceText.replace(/[^0-9]/g,
								''), 10);
						if (!isNaN(priceNumber)) {
							// 숫자를 1,000 단위로 쉼표를 추가하여 포맷팅합니다.
							element.textContent = priceNumber
									.toLocaleString('ko-KR')
									+ ' 원';
						}
					});

			$(document).ready(function() {
			    var rowsPerPage = 15;
			    var rows = $('.ordersTable tbody tr'); // 클래스 선택자를 사용하여 수정
			    var rowsCount = rows.length;
			    var pageCount = Math.ceil(rowsCount / rowsPerPage);
			    var numbers = $('.paging');

			    for (var i = 1; i <= pageCount; i++) {
			        numbers.append('<a href="#">' + i + '</a>');
			    }

			    rows.hide();
			    rows.slice(0, rowsPerPage).show();
			    numbers.find('a:first').addClass('active');

			    numbers.find('a').click(function(e) {
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
		});
	</script>
</body>
</html>
