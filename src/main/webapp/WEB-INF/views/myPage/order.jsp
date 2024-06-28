<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
main{
    width: 80%;
    padding-left:200px;
}
</style>

</head>
<body>

    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <hr>
    <h2 style="text-align:left; margin-top:30px; margin-left : 100px;"> 주문내역</h2>
    <hr>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>

	<main style="margin-top: 30px; width: 90%;">
		
		<c:forEach var="item" items="${orderList}">
			<div style="border: 2px solid black; padding: 20px; margin: 20px 10px;">
				<div style="display:flex; margin:10px;">
					<div class="box" style="font-size: medium; margin-right: 30px;">주문날짜 : ${fn:substring(item.orderDate, 0, 10)}</div>
					<div class="box" style="font-size: medium;">주문번호 : ${item.merchantUid}</div>
				</div>
				<div class="box-container"
					style="border: 1px solid black; padding: 10px; margin: 5px; display: flex; justify-content: space-evenly;">
					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<img src="${ item.filePath }" class="img-box"
							style="width: 170px; height: 170px; border: 1px solid #CDCDCD;">
					</div>
					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div class="box" name="title" style="font-size: large;">${item.title}</div>
						<div class="box" name="name" style="font-size: large;">${item.name}</div>
						<div class="box" name="price" style="font-size: large;">상품 단가: <span class="price">${item.price}</span> 원</div>

					</div>

					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div class="box" style="color: green; font-size: large; font-weight:bold;">내일
							도착 보장</div>
						<div style="font-size: large;"> </div>
						<div class="box" name="quantity" style="font-size: large;">상품 수량: ${item.quantity} 개</div>
					</div>

					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div class="box" style="font-size: x-large; color:blue;">${item.state}</div>
						<div style="font-size: large;"> </div>
						<div class="box" style="font-size: x-large; font-weight:bold;">가격:
							<span class="price">${item.price * item.quantity}</span> 원</div>
					</div>
					<div
						style="border-left: 1px solid black; display: flex; flex-direction: column; justify-content: space-evenly;">
						<div class="box" style="font-size: large; text-align: center;">
							<button type="button" class="btn btn-secondary" style="margin: 20px; width : 90%;">배송조회</button>
						</div>
						<div class="box" style="font-size: large; text-align: center;">
							<button type="button" class="btn btn-secondary" style="margin: 20px; width : 90%;">교환,반품신청</button>
						</div>
						<div class="box" style="font-size: large; text-align: center;">
							<button type="button" class="btn btn-secondary" style="margin: 20px; width : 90%;">리뷰 작성하기</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		<div style="margin: 0 auto; display: flex; justify-content: center;">
									<%@include file="/WEB-INF/layouts/orderPaging.jsp"%>
								</div>
	</main>
	<%@include file="/WEB-INF/layouts/footer.jsp"%>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // 모든 price 클래스 요소를 선택합니다.
        var prices = document.querySelectorAll('.price');

        // 각 요소에 대해 천 단위 쉼표를 추가합니다.
        prices.forEach(function(price) {
            var value = parseInt(price.textContent, 10);
            price.textContent = value.toLocaleString();
        });
    });

    </script>

    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>