<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제중</title>
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

    <main style="margin-top:30px; width:90%;">
        <h2 style="text-align:left; margin-top:30px; margin-left:100px;">결제진행중</h2>
        <hr>
        
        <div style="text-align: right;">
            <input type="hidden" id="finalPrice" value="${orderList.totalPrice}">
            <input type="hidden" id="merchantUid" value="${orderList.merchantUid}">
            <input type="hidden" id="myName" value="${orderList.name}">
            <input type="hidden" id="myEmail" value="${orderList.email}">
            <input type="hidden" id="myRealName" value="${orderList.dename}">
            <input type="hidden" id="myTel" value="${orderList.phone}">
            <input type="hidden" id="myAddr" value="${orderList.address}">
            <input type="hidden" id="myPostCode" value="${orderList.postcode}">
        </div>

        <script src="/js/bootstrap.bundle.min.js"></script>
        <script>
            // 페이지가 로드될 때 mypayment 함수 호출
            window.onload = mypayment;
            
            async function mypayment() {
                const finalPriceElement = document.getElementById("finalPrice");
                const merchantUidElement = document.getElementById("merchantUid");
                const nameElement = document.getElementById("myName");
                const emailElement = document.getElementById("myEmail");
                const realNameElement = document.getElementById("myRealName");
                const telElement = document.getElementById("myTel");
                const addrElement = document.getElementById("myAddr");
                const postCodeElement = document.getElementById("myPostCode");
                
                if (!finalPriceElement || !merchantUidElement || !nameElement || !emailElement || !realNameElement || !telElement || !addrElement || !postCodeElement) {
                    console.error('Required element not found.');
                    return;
                }
                
                const myAmount = Number(finalPriceElement.value);
                const myMerchantUid = merchantUidElement.value;
                const myName = nameElement.value;
                const myEmail = emailElement.value;
                const myRealName = realNameElement.value;
                const myTel = telElement.value;
                const myAddr = addrElement.value;
                const myPostCode = postCodeElement.value;

                const IMP = window.IMP; // 생략 가능
                IMP.init("imp68777271"); // Example: imp68777271
                IMP.request_pay(
                    {
                        pg: "tosspayments",
                        pay_method: "card",
                        name: myName,
                        amount: myAmount,
                        merchant_uid: myMerchantUid,
                        buyer_email: myEmail,
                        buyer_name: myRealName,
                        buyer_tel: myTel,
                        buyer_addr: myAddr,
                        buyer_postcode: myPostCode
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
                            window.location.href = "/myPage/order";
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert("결제 실패!");
                            window.location.href = "/myPage/payment";
                        });
                    });
            }
        </script>
    </main>
</body>
</html>
