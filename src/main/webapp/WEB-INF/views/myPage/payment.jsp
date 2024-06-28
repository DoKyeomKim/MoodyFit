<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
main {
	padding-left: 200px;
}
</style>



</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>

	<%@include file="/WEB-INF/layouts/aside.jsp"%>

	<main style="margin-top: 30px; width: 90%;">

		<h2 style="text-align: left; margin-top: 30px; margin-left: 100px;">결제</h2>
		<hr>
		<h4 style="text-align: left; margin-top: 30px; margin-left: 100px;">주문목록</h4>

		<!-- 총 주문 금액을 저장할 변수를 선언 -->
		<c:set var="totalOrderPrice" value="0" scope="page" />
		<form action="/myPage/cartQuantity" method="post" id="quantituyForm">
		<c:forEach var="item" items="${cartList}">
			<input type="hidden" value="${item.cartIdx}" class="hiddenCartIdx">
			<c:set var="itemTotalPrice" value="${item.price * item.quantity}" />
			<c:set var="totalOrderPrice"
				value="${totalOrderPrice + itemTotalPrice}" />
			<c:set var="totalQuantity" value="${totalQuantity + item.quantity}" />
			<div class="box-container"
				style="border: 1px solid black; padding: 10px; margin: 5px; display: flex; justify-content: space-evenly;">
				<div>
					<img src="${item.filePath}" class="img-box"
						style="width: 150px; height: 150px; border: 1px solid #CDCDCD;">
				</div>
				<div
					style="display: flex; flex-direction: column; justify-content: space-evenly;">
					<div class="box">${item.title}</div>
					<div class="box">${item.name}</div>
					<div class="box">${item.price}</div>
				</div>
				<div
					style="display: flex; flex-direction: column; justify-content: space-evenly;">
					<div>수량 : ${item.quantity}</div>
					<div class="box">
						총 상품 가격: <span>${item.price * item.quantity}</span>원
					</div>
					<div>
						<button type="button" onclick="removeItem(this)">삭제</button>
					</div>
				</div>
			</div>
		</c:forEach>
		</form>
		<hr style="border: 1px solid black;">
		<h4 style="text-align: left; margin-top: 30px; margin-left: 100px;">배송지</h4>
		<div class="box-container"
			style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly;">

			<div
				style="display: flex; flex-direction: column; justify-content: space-evenly;">
				<div class="box">${deliveryDto.name}</div>
				<div class="box">${deliveryDto.postCode}</div>
				<div class="box">${deliveryDto.address}</div>
				<div class="box">${deliveryDto.detailAddress}</div>
				<div class="box">${deliveryDto.content}</div>
			</div>
			<div></div>
			<div></div>
			<div></div>
			<div></div>
			<div></div>
			<div></div>
			<div
				style="display: flex; flex-direction: column; justify-content: space-evenly;">
				<div class="box"
					style="border: 1px solid black; border-radius: 80px; text-align: center;">
					${deliveryDto.deliveryName}</div>
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
			<div
				style="display: flex; flex-direction: column; justify-content: space-evenly;">
				<form action="/myPage/orderMake" method="post" id="purchaseForm">
					<div class="box" style="text-align: left;">
						<h4>주문예상금액</h4>
					</div>
					<div
						style="display: flex; flex-direction: column; justify-content: space-evenly;">
						<input type="hidden" name="test" value="시험용">
						<input type="hidden" name="deliveryIdx"	value="${deliveryDto.deliveryIdx}">
						<input type="hidden" name="personIdx" value="${deliveryDto.personIdx}">
						<div style="text-align: right;">총 상품 금액: 
							<input type="text" name="price" value="${totalOrderPrice}" readonly> 원</div>
						<div style="text-align: right;">총 수량: 
							<input type="text" name="quantity" value="${totalQuantity}"	readonly> 개</div>
						<div style="text-align: right;">배송비: 
							<input type="text" name="deliveryPrice" value="1000" readonly> 원</div>
						<hr style="border: 1px solid black;">
						<div style="text-align: right;">결제할 금액: 
							<input type="text" value="${totalOrderPrice + 1000}" id="finalPrice" readonly> 원</div>
					</div>
					<button type="button" id="addToCartButton" class="btn btn-primary"
				style="margin: 20px;">결제하기</button>
				</form>
			</div>
		</div>

<!-- 
		<div style="text-align: right;">
			<input type="button" onclick="mypayment()" class="btn btn-primary"
				style="margin: 20px;" value="결제하기">
		</div>  -->

		<!-- 배송지 변경 모달 -->
		<div class="modal fade" id="addressModal" tabindex="-1" role="dialog"
			aria-labelledby="addressModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addressModalLabel">배송지 선택</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- 자신의 배송지 목록을 보여주기 -->
						<c:forEach var="de" items="${deliveryList}">
							<div style="border: 1px solid #000; padding: 10px; margin: 10px;">
								<input type="hidden" value="${de.deliveryIdx}"
									name="deliveryIdx">
								<p>${de.deliveryName}</p>
								<p>${de.address}</p>
								<p>${de.detailAddress}</p>
								<button type="button" class="btn btn-primary"
									onclick="selectAddress('${de.deliveryName}', '${de.address}', '${de.detailAddress}', '${de.name}', '${de.postCode}', '${de.content}')">선택</button>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>


		<script src="/js/bootstrap.bundle.min.js"></script>
		<script>
		document.getElementById("addToCartButton").addEventListener("click", async (event) => {
		    event.preventDefault();

		    // cartIdx 값들을 담을 배열 초기화
		    let cartIdxArray = [];
		    document.querySelectorAll('.hiddenCartIdx').forEach(hidden => {
		        cartIdxArray.push(parseInt(hidden.value));
		    });

		    const basketData1 = {
		        cartIdxArray: cartIdxArray,
		        price: parseInt(document.querySelector("input[name='price']").value),
		        quantity: parseInt(document.querySelector("input[name='quantity']").value),
		        deliveryPrice: parseInt(document.querySelector("input[name='deliveryPrice']").value),
		        deliveryIdx: parseInt(document.querySelector("input[name='deliveryIdx']").value),
		        personIdx: parseInt(document.querySelector("input[name='personIdx']").value)
		    };

		    const basketData2 = {
		        price: parseInt(document.querySelector("input[name='price']").value),
		        quantity: parseInt(document.querySelector("input[name='quantity']").value),
		        deliveryPrice: parseInt(document.querySelector("input[name='deliveryPrice']").value),
		        deliveryIdx: parseInt(document.querySelector("input[name='deliveryIdx']").value),
		        personIdx: parseInt(document.querySelector("input[name='personIdx']").value)
		    };

		    try {
		        const response1 = await fetch('/myPage/cartQuantity', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/json'
		            },
		            body: JSON.stringify(basketData1)
		        });

		        const data1 = await response1.json();

		        if (data1.status === 'success') {
		            const response2 = await fetch('/myPage/orderMake', {
		                method: 'POST',
		                headers: {
		                    'Content-Type': 'application/json'
		                },
		                body: JSON.stringify(basketData1)
		            });

		            const data2 = await response2.json();

		            if (data2.status === 'success') {
		                alert('주문내역 생성!');
		                window.location.href = '/myPage/payPay';
		            } else {
		                alert('주문내역 생성실패!');
		                window.location.href = '/myPage/payment';
		            }
		        } else {
		            alert('장바구니 업데이트 실패!');
		            window.location.href = '/myPage/cartQuantity';
		        }
		    } catch (error) {
		        console.error('Error:', error);
		        alert('그냥 실패!');
		        window.location.href = '/myPage/payment';
		    }
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
    	    const myMerchantUid = document.getElementById("merchantUid").value;

    	    const IMP = window.IMP; // 생략 가능
    	    IMP.init("imp68777271"); // Example: imp68777271
    	    IMP.request_pay(
    	      {
    	        // paramW
    	        pg: "tosspayments",
    	        pay_method: "card",
    	        name: "에어포스",
    	        amount: myAmount,
    	        merchant_uid: myMerchantUid,
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