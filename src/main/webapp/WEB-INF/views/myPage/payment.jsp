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

	<h2 style="text-align:left; margin-top:30px; margin-left : 100px;">결제</h2>
		<hr>
		<h4 style="text-align:left; margin-top:30px; margin-left : 100px;">주문목록</h4>	
		<form action="/purchase" method="post" id="purchaseForm">
			<c:forEach var="item" items="${cartList}">
				<div class="box-container"
					style="border: 1px solid black; padding: 10px; margin: 5px; display: flex; justify-content: space-evenly;">
					<div>
						<img src="${item.filePath}" class="img-box"
							style="width: 150px; height: 150px; border : 1px solid #CDCDCD;">
					</div>
					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div class="box" name="title">${item.title}</div>
						<div class="box" name="name">${item.name}</div>
						<div class="box" name="price">${item.price}</div>
					</div>
					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div>수량 : ${item.quantity}</div>
						<div>
							<button type="button" onclick="removeItem(this)">삭제</button>
						</div>
					</div>
				</div>
			</c:forEach>
			<hr style="border: 1px solid black;">
			<h4 style="text-align:left; margin-top:30px; margin-left : 100px;">배송지</h4>
			<div class="box-container"
				style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly;">
				<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
					<div class="box" name="name">${deliveryDto.name}</div>
					<div class="box" name="postCode">${deliveryDto.postCode}</div>
					<div class="box" name="address">${deliveryDto.address}</div>
					<div class="box" name="detailAddress">${deliveryDto.detailAddress}</div>
					<div class="box" name="content">${deliveryDto.content}</div>
				</div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
				<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
					<div class="box" name="deliveryName"
						style="border: 1px solid black; border-radius: 80px; text-align: center;">
						${deliveryDto.deliveryName}
					</div>
					<div></div>
					<div></div>
					<div></div>
					<div></div>
					<div></div>
					<div>
						<button type="button" onclick="showDeliveryModal()">배송지 변경</button>
					</div>
				</div>
			</div>
			<hr style="border: 3px solid black;">
			<div class="box-container"
				style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly; flex-direction: column;">
				<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
					<div class="box" name="name" style="text-align: left;">
						<h4>주문예상금액</h4>
					</div>
					<div style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<div style="text-align: right;" name="totalPrice">총 상품 금액: <span id="totalPrice">0</span> 원</div>
						<div style="text-align: right;" name="quantity">총 수량: <span id="totalQuantity">0</span> </div>
						<div style="text-align: right;" name="deliveryPrice">배송비: 1,000 원</div>
						<hr style="border: 1px solid black;">
						<div style="text-align: right;">결제할 금액: <span id="finalPrice">0</span> 원</div>
					</div>
				</div>
			</div>
		</form>
		<div style="text-align: right;">
			<input type="button" onclick="mypayment()" class="btn btn-primary" style="margin:20px;" value="결제하기">
		</div>

		  <!-- 배송지 변경 모달 -->
		<div class="modal fade" id="addressModal" tabindex="-1" role="dialog" aria-labelledby="addressModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addressModalLabel">배송지 선택</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- 자신의 배송지 목록을 보여주기 -->
						<c:forEach var="de" items="${deliveryList}">
							<div style="border: 1px solid #000; padding: 10px; margin: 10px;">
								<p>${de.deliveryName}</p>
								<p>${de.address}</p>
								<p>${de.detailAddress}</p>
								<button type="button" class="btn btn-primary" onclick="selectAddress('${de.deliveryName}', '${de.address}', '${de.detailAddress}', '${de.name}', '${de.postCode}', '${de.content}')">선택</button>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
    
	
	<script src="/js/bootstrap.bundle.min.js"></script>
	<script>
	// 주문 목록의 총 상품 금액을 계산하는 함수
	function calculateTotalPrice() {
	    let totalPrice = 0;
	    let totalQuantity = 0;

	    // 각 .box-container 요소를 순회하며 상품 가격과 수량을 가져와 계산
	    document.querySelectorAll('.box-container').forEach(function(container) {
	        const priceElement = container.querySelector('.box[name="price"]');
	        const quantityElement = container.querySelector('.box[name="quantity"]');
			console.log(priceElement);
	        // priceElement와 quantityElement가 모두 존재하는지 확인 후 계산
	        if (priceElement && quantityElement) {
	            const priceText = priceElement.textContent; // 텍스트 내용에서 앞뒤 공백 제거
	            const price = parseFloat(priceText);
	            const quantityText = quantityElement.textContent.replace('수량 : ', '').trim(); // 텍스트 내용에서 '수량 : ' 문자열 제거하고 앞뒤 공백 제거
	            const quantity = parseFloat(quantityText);
	            console.log(priceText);
	            console.log(price);
	            console.log(quantity);
	            if (!isNaN(price) && !isNaN(quantity)) {
	                totalPrice += price * quantity;
	                totalQuantity += quantity;
	            }
	        }
	    });

	    // 총 상품 금액과 수량을 화면에 업데이트
	    document.getElementById('totalPrice').textContent = totalPrice.toLocaleString();
	    document.getElementById('totalQuantity').textContent = totalQuantity.toLocaleString();
	    document.getElementById('finalPrice').textContent = (totalPrice + 1000).toLocaleString(); // 배송비 추가
	}

	// 페이지 로드 시 총 상품 금액 계산
	document.addEventListener('DOMContentLoaded', function() {
	    calculateTotalPrice();
	});

	// 배송지 변경 모달 표시
	function showAddressModal() {
		$('#addressModal').modal('show');
	}

	// 배송지 선택
	function selectAddress(deliveryName, address, detailAddress, name, postCode, content) {
		document.querySelector('.box[name="name"]').textContent = name;
		document.querySelector('.box[name="postCode"]').textContent = postCode;
		document.querySelector('.box[name="address"]').textContent = address;
		document.querySelector('.box[name="detailAddress"]').textContent = detailAddress;
		document.querySelector('.box[name="content"]').textContent = content;
		document.querySelector('.box[name="deliveryName"]').textContent = deliveryName;
		$('#addressModal').modal('hide');
	}
	
      async function mypayment() {
    	    const myAmount = Number(document.getElementById("finalPrice").value);

    	    const IMP = window.IMP; // 생략 가능
    	    IMP.init("imp68777271"); // Example: imp68777271
    	    IMP.request_pay(
    	      {
    	        // paramW
    	        pg: "tosspayments",
    	        pay_method: "card",
    	        name: "에어포스",
    	        amount: myAmount,
    	        merchant_uid: "00000010",
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
    	                alert("결제가 완료되었습니다!");
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