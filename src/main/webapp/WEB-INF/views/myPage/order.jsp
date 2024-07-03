<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<style>
    body {
        font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
        background-color: #F6F4EE;
        margin: 0;
        padding: 0;
    }

    main {
        width: 80%;
        margin: 70px auto;
        
        
        
    }

    h3 {
        text-align: left;
        margin-left: 30px;
    }

    hr {
        border: none;
        border-top: 1px solid #ddd;
    }

    .order-container {
        padding: 20px;
        margin: 20px 10px;
        border-top: 1px solid #ddd; /* 상단 구분선 추가 */
        border-bottom: 1px solid #ddd; /* 하단 구분선 추가 */
        border-radius: 8px;
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .order-header div {
        font-size: medium;
    }

    .order-item {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        border-top: 1px solid #ddd;
    }

    .order-item img {
        width: 120px;
        height: 120px;
        object-fit: cover;
        border: 1px solid #CDCDCD;
    }

    .order-details {
        display: flex;
        flex-direction: column;
        justify-content: center;
        margin-left: 20px;
        flex: 2;
    }

    .order-details div {
        margin-bottom: 5px;
        font-size: 15px;
    }

    .order-status {
        display: flex;
        flex-direction: column;
        justify-content: center;
        text-align: right;
        margin-right:50px;
    }

    .order-status div {
        font-size: 15px;
        margin-bottom: 5px;
    }

    .order-actions {
        display: flex;
        flex-direction: column;
        justify-content: center;
        border-left: 1px solid #ddd;
        padding-left: 20px;
    }

    .order-actions button {
        margin-bottom: 10px;
        width: 150px;
        align-self: center;
         background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    border-radius: 10px !important;
    border: none;
    }

    .price {
        font-weight: bold;
    }

    .highlight {
        color: green;
        font-weight: bold;
    }

    .bold {
        font-weight: bold;
    }

    .text-blue {
        color: blue;
    }
  
</style>
</head>
<body style="background-color:#F6F4EE !important;">

    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>

    <main>
        <h3 style="font-weight:bold;">주문내역조회</h3>
   

        <c:forEach var="item" items="${orderList}">
            <div class="order-container">
                <div class="order-header">
                    <div>주문날짜: ${fn:substring(item.orderDate, 0, 10)}</div>
                    <div>주문번호: ${item.merchantUid}</div>
                </div>
                <div class="order-item" >
                    <img src="${item.filePath}" alt="상품 이미지">
                    <div class="order-details">
                        <div>${item.title}</div>
                        <div>${item.name}</div>
                        <div>QTY: ${item.quantity} 개</div>
                    </div>
                    <div class="order-status">
         
                        <div>${item.state}</div>
                        <div>KRW <span class="price">${item.price * item.quantity}</span> </div>
                    </div>
                    <div class="order-actions">
                        <button type="button" class="btn btn-secondary">배송조회</button>
                        <button type="button" class="btn btn-secondary">교환,반품신청</button>
                        <button type="button" class="btn btn-secondary">구매후기</button>
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
