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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
main{
	padding-left:200px;
}
</style>



</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>
		
	<%@include file="/WEB-INF/layouts/aside.jsp"%>

	<main style="margin-top:30px; width:90%; ">

	<h2 style="text-align:left; margin-top:30px; margin-left : 100px;"> 결제</h2>
	<hr>
	<h4 style="text-align:left; margin-top:30px; margin-left : 100px;">주문목록</h4>	
     <form action="/purchase" method="post">
         <c:forEach var="item" items="${orderList}">

                <div class="box-container"
                    style="border: 1px solid black; padding: 10px; margin: 5px; display: flex; justify-content: space-evenly;">
                    <div>
                        <img src="${ item.filePath }" class="img-box"
                             style="width: 150px; height: 150px;border : 1px solid #CDCDCD;">
                    </div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="title">${item.title}</div>
                        <div class="box" name="name">${item.name}</div>
                        <div class="box" name="price">${item.price}</div>
                    </div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div name="quantity">수량 : ${item.quantity}</div>
                        <div>
                            <button type="button" onclick="removeItem(this)">삭제</button>
                        </div>
                    </div>
                </div>

            </c:forEach>
            <hr style="border: 1px solid black;">
            <h4 style="text-align:left; margin-top:30px; margin-left : 100px;">배송지</h4>
           <c:forEach var="de" items="${deliveryList}">
                <div class="box-container" 
                    style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly;">
                    <div style="display: flex;">
                        <input type="checkbox" name="selectedItems" value="${item.cartIdx}" class="itemCheckbox" onchange="updateBuyButton()">
                    </div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="name">${de.name}</div>
                        <div class="box" name="postCode">${de.postCode}</div>
                        <div class="box" name="address">${de.address}</div>
                        <div class="box" name="detailAddress">${de.detailAddress}</div>
                        <div class="box" name="content">${de.content}</div>
                    </div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="deliveryName" 
                        style="border: 1px solid black; border-radius: 80px; text-align: center;">${de.deliveryName}</div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div>
                            <button type="button" onclick="">배송지 변경</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <hr style="border: 3px solid black;">
            <div class="box-container" 
                    style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex;
                     justify-content: space-evenly; flex-direction: column;">
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="name" style="text-align: left;"><h4>주문예상금액</h4></div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div style="text-align: right;">총 상품 금액 : 100,000 원</div>
                        <div style="text-align: right;">    배송비   :   1,000 원</div>
                        <hr style="border: 1px solid black;">
                        <div style="text-align: right;">결제할 금액  : <input type="text" id="amount1" value="100100" readonly/>원</div>
                    </div>
                </div>
        	</div>
    </form>
        <div style="text-align : right;">
        <input type="button" onclick="mypayment()" class="btn btn-primary" style="margin:20px;" value="결제하기"></div>
    
	
	<script src="/js/bootstrap.bundle.min.js"></script>
	<script>
	
      async function mypayment() {
    	    const myAmount = Number(document.getElementById("amount1").value);

    	    const IMP = window.IMP; // 생략 가능
    	    IMP.init("imp68777271"); // Example: imp68777271
    	    IMP.request_pay(
    	      {
    	        // paramW
    	        pg: "tosspayments",
    	        pay_method: "card",
    	        name: "에어포스",
    	        amount: myAmount,
    	        merchant_uid: "00000007",
    	        buyer_email: "hase9708@naver.com",
    	        buyer_name: "하세연",
    	        buyer_tel: "010-8552-7537",
    	        buyer_addr: "부산광역시 북구 화명동",
    	        buyer_postcode: "46534"
    	      },
    	      (response) => {
    	            fetch(`/api/postToken?impUid=${response.imp_uid}`, {
    	                method: "POST",
    	                headers: { "Content-Type": "application/json" },
    	                body: JSON.stringify({
    	                    impUid: response.imp_uid
    	                }),
    	            })
    	            .then(res => res.ok ? res.text() : Promise.reject(res.statusText))
    	            .then(data => {
    	                console.log('Success:', data);
    	                window.location.href = "/myPage";
    	            })
    	            .catch(error => {
    	                console.error('Error:', error);
    	                alert("결제 실패!");
    	                window.location.href = "/myPage/payment";
    	            });
    	        });
    	    }
    	    	  
    
</script>
</body>
</html>