<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="" crossorigin="anonymous"></script>
 
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
  
    .item-link {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 부모 요소의 색상 상속 */
}

.item-link:hover .item {
	transform: scale(1.05); /* hover 시 확대 효과 추가 */
}

.item-link .item {
	color: #000; /* 글자 색상을 검정으로 설정 */
	transition: transform 0.2s;
}

.tracking-status-item {
	margin : 15px;
	font-size: medium;
}
.modal-header {
        cursor: move; /* 마우스 커서를 이동 모양으로 설정 */
        user-select: none; /* 텍스트 선택 금지 */
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
                    <div><a href="/postingDetail?postingIdx=${item.postingIdx}" class="item-link">
                    주문날짜: ${fn:substring(item.orderDate, 0, 10)}</a></div>
                    <div><a href="/postingDetail?postingIdx=${item.postingIdx}" class="item-link">
                    주문번호: ${item.merchantUid}</a></div>
                </div>
                <div class="order-item" >
                    <img src="${item.filePath}" alt="상품 이미지">
                    <div class="order-details">
                        <div><a href="/postingDetail?postingIdx=${item.postingIdx}" class="item-link">${item.title}</a></div>
                        <div><a href="/postingDetail?postingIdx=${item.postingIdx}" class="item-link">${item.name}</a></div>
                        <div><a href="/postingDetail?postingIdx=${item.postingIdx}" class="item-link">QTY: ${item.quantity} 개</a></div>
                    </div>
                    <div class="order-status">
         
                        <div>${item.state}</div>
                        <div>KRW <span class="price">${item.price * item.quantity}</span> </div>
                    </div>
                    <div class="order-actions">
                        <button type="button" class="btn btn-secondary" onclick="checkDelivery()">배송조회</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href=`/postingDetail?postingIdx=${item.postingIdx}`">교환,반품신청</button>
                        <button type="button" class="btn btn-secondary" onclick="location.href=`/postingDetail?postingIdx=${item.postingIdx}`">구매후기</button>
                    </div>
                </div>
               
            </div>
        </c:forEach>

        <div style="margin: 0 auto; display: flex; justify-content: center;">
            <%@include file="/WEB-INF/layouts/orderPaging.jsp"%>
        </div>
    </main>
        <%@include file="/WEB-INF/layouts/footer.jsp"%>
        
        
  <!-- 모달창 -->
  <div id="deliveryModal" class="modal" tabindex="-1" role="dialog" style="width:600px;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <!-- 모달 헤더 -->
            <div class="modal-header" style="display:flex; justify-content: space-between;">
            	<div></div>
                <div><h4 class="modal-title" style="text-align: center;">배송 조회</h4></div>
                <div><button type="button" class="close" onclick="closeModal()" aria-label="Close" style="text-align: right;">
                        <span aria-hidden="true">&times;</span>
                    </button></div>
            </div>
				<div class="header-area" style="text-align: center; font-size: large; font-weight: bold; margin-top:25x; margin-botton:10px;">
				스마트택배 배송조회</div>
				<div class="title-border"></div>
				<div class="title-content" style="background-color: #03A9F4; color:white; padding: 15px 0px 15px 15px; font-size:large;">
					<div class="title-notice" style="display: inline-block; padding: 5px 10px; border: 1px solid white; border-radius: 15px;
					text-align: center;">운송장 번호</div>
					<div class="title-invoice">1234567890</div>
					<div class="title-company">CJ대한통운</div>
				</div>
				<div class="col-xs-12 info-area no-padding" >
  <div class="info-back-line" style="display:flex; justify-content: space-between; padding: 15px 15px;">
    <div class="col-xs-15 text-center">
      <img src="/images/ic_sky_delivery_step1_off.png" class="parcel-img" style="width:70px; height:70px;">
      <div style="text-align: center;">상품인수</div>
    </div>
    <div class="col-xs-15 text-center">
      <img src="/images/ic_sky_delivery_step2_off.png" class="parcel-img" style="width:70px; height:70px;">
      <div style="text-align: center;">상품이동중</div>
    </div>

    <div class="col-xs-15 text-center">
      <img src="/images/ic_sky_delivery_step3_off.png" class="parcel-img" style="width:70px; height:70px;">
      <div style="text-align: center;">배송지도착</div>
    </div>
    <div class="col-xs-15 text-center">
      <img src="/images/ic_sky_delivery_step4_off.png" class="parcel-img" style="width:70px; height:70px;">
      <div style="text-align: center;">배송출발</div>
    </div>

    <div class="col-xs-15 text-center" style="display: inline-block; padding: 5px 10px; border: 1px solid black; border-radius: 15px;">
      <img src="/images/ic_sky_delivery_step5_off.png" class="parcel-img" style="width:70px; height:70px;">
      <div style="text-align: center;">배송완료</div>
    </div>
  </div>
</div>
<div style="border:10px solid #F0F0F0;"></div>
				<div class="modal-body">
                    <div class="col-xs-12 tracking-status-item-list" style="padding : 30px;">
  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/on1.png" class="parcel-img" style="width:20px; height:20px;"></div>
      <div>
	    <span class="location-text" style="font-weight:bold;">서울 남대문</span> | <span class="status-text" style="font-weight:bold;">배송완료</span>
	    <div class="time-text">2024-07-05 11:11:11</div>
	    <div class="vertical-line"></div>
	  </div>
  </div>

  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/off1.png" class="parcel-img" style="width:20px; height:20px;"></div>
      <div>
	    <span class="location-text">서울 남대문</span> | <span class="status-text">배송출발</span>
	    <div class="time-text">2024-07-04 11:11:11</div>
	    <div class="vertical-line" style="top:110px"></div>
	  </div>
  </div>

  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/off1.png" class="parcel-img" style="width:20px; height:20px;"></div>
	  <div>
	    <span class="location-text">남서울터미널</span> | <span class="status-text">배달전</span>
	    <div class="time-text">2024-07-04 11:11:11</div>
	    <div class="vertical-line" style="top:185px"></div>
	   </div>
  </div>
  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/off1.png" class="parcel-img" style="width:20px; height:20px;"></div>
	  <div>
	    <span class="location-text">대전HUB</span> | <span class="status-text">간선상차</span>
	    <div class="time-text">2024-07-03 11:11:11</div>
	    <div class="vertical-line" style="top:260px"></div>
	  </div>
  </div>
  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/off1.png" class="parcel-img" style="width:20px; height:20px;"></div>
	  <div>
	    <span class="location-text">성북직영</span> | <span class="status-text">집하처리</span>
	    <div class="time-text">2024-07-03 11:11:11</div>
	    <div class="vertical-line" style="top:335px"></div>
	  </div>
  </div>
  <div class="tracking-status-item" style="display:flex;">
    <div class="list-circle" style="margin-right:10px;"><img src="/images/off1.png" class="parcel-img" style="width:20px; height:20px;"></div>
	  <div>
	    <span class="location-text">고객</span> | <span class="status-text">인수자등록</span>
	    <div class="time-text">2024-07-02 11:11:11</div>
	    <div class="vertical-line"></div>
	  </div>
  </div>
</div>
            </div>
<div style="border:5px solid #F0F0F0;"> </div>
                            <button type="button" class="btn btn-secondary" onclick="closeModal()" style="padding: 10px 0px;">닫기</button>
        </div>
    </div>

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
    
    var modal = document.getElementById("deliveryModal");

    function checkDelivery() {
        modal.style.display = "block";
    }

    function closeModal() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
 // JavaScript로 모달 드래그 기능 구현
    dragElement(document.getElementById("deliveryModal"));

    function dragElement(elmnt) {
        var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
        if (document.getElementById(elmnt.id + "header")) {
            // 만약 헤더가 있다면, 헤더를 드래그할 수 있도록 설정
            document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
        } else {
            // 그렇지 않다면, 요소 자체를 드래그할 수 있도록 설정
            elmnt.onmousedown = dragMouseDown;
        }

        function dragMouseDown(e) {
            e = e || window.event;
            e.preventDefault();
            // 마우스 클릭 시 초기 커서 위치를 기록
            pos3 = e.clientX;
            pos4 = e.clientY;
            document.onmouseup = closeDragElement;
            // 마우스 이동 시 요소를 드래그
            document.onmousemove = elementDrag;
        }

        function elementDrag(e) {
            e = e || window.event;
            e.preventDefault();
            // 새로운 커서 위치를 계산
            pos1 = pos3 - e.clientX;
            pos2 = pos4 - e.clientY;
            pos3 = e.clientX;
            pos4 = e.clientY;
            // 요소를 새로운 위치로 이동
            elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
            elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
        }

        function closeDragElement() {
            // 드래그 종료 시, 마우스 이벤트 리셋
            document.onmouseup = null;
            document.onmousemove = null;
        }
    }
    </script>
    <script src="/js/bootstrap.bundle.min.js"></script>
    

</body>
</html>
