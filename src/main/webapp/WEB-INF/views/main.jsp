<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<style>
body {
    visibility: hidden;
    opacity: 0;
    transition: visibility 0s, opacity 1s ease;
    margin: 0;
}
body.loaded {
    visibility: visible;
    opacity: 1;
}
main {
    margin-top: -200px; /* Adjust based on the height of your header */
    padding-top: 100px; /* To ensure the content is not hidden under the header */
}
.image-container {
    position: relative;
    display: inline-block;
}
.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    margin-top : 40px;
    margin-bottom : 40px;
}
.container-best{
	width : 100%;
	display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    margin-top : 40px;
    margin-bottom : 40px;
}

.overlay {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    height: 100%;
    width: 100%;
    opacity: 0;
    transition: .5s ease;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
}
.image-container:hover .overlay {
    opacity: 1;
}
.info {
    text-align: center;
}
.swiper-container {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}
.swiper-slide {
    display: flex;
    justify-content: center;
    align-items: center;
}

.light-text {
    color: #6c757d;
}

.top-cards {
    background-color: white;
    position: relative;
    height: 100vh;
    overflow: hidden;
    z-index: 1;
}
#chat {
	position : fixed;
	bottom : 50px;
	right : 50px;
    border: none;
    background: none; 
    padding: 0;
    z-index: 9999;
}
.weekly-best-container {
    overflow: hidden;
    white-space: nowrap;
    width: 100%;
}

.weekly-best-wrapper {
    display: flex;
    animation: slide 10s linear infinite;
    animation-play-state: running; /* 애니메이션의 기본 상태를 재생 중으로 설정 */
    width: 100%;
}

.weekly-best-slide {
    display: inline-block;
    width: 20%;
    box-sizing: border-box;
    margin-right: 50px;
}

@keyframes slide {
    0% {
        transform: translateX(100%);
    }
    100% {
        transform: translateX(-100%);
    }
}

.image-container {
    position: relative;
    width: 100%;
}

.overlay {
    position: absolute;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    color: #fff;
    width: 100%;
    text-align: center;
}

.info {
    padding: 10px;
    font-size : 20px;
}
.recent-posting {
    text-align: left;
    margin: 20px;
    border: 0.5px solid #ccc;
    padding: 15px;
    border-radius: 5px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.recent-posting:hover {
    transform: scale(1.02);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
.recent-post-title {
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
}
.recent-post-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}
.recent-price {
    font-size: 17px;
    font-weight: bold;
}
.recent-store-name {
    opacity: 0.7;
}
.recent-post-image {
    height: 260px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    padding: 0;
}

.recent-post-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    margin: 0;
}

.items-wrapper {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.item {
	width: calc(20% - 10px);
	height: 400px;
	margin: 10px 5px;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s;
}


.item:hover {
	transform: scale(1.05);
}

</style>
</head>
<body>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<main id="main-content">

	<c:if test="${not empty sessionScope.userIdx }">
		<button id="chat">
			<svg width="50px" height="50px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M13.0867 21.3877L13.7321 21.7697L13.0867 21.3877ZM13.6288 20.4718L12.9833 20.0898L13.6288 20.4718ZM10.3712 20.4718L9.72579 20.8539H9.72579L10.3712 20.4718ZM10.9133 21.3877L11.5587 21.0057L10.9133 21.3877ZM2.3806 15.9134L3.07351 15.6264V15.6264L2.3806 15.9134ZM7.78958 18.9915L7.77666 19.7413L7.78958 18.9915ZM5.08658 18.6194L4.79957 19.3123H4.79957L5.08658 18.6194ZM21.6194 15.9134L22.3123 16.2004V16.2004L21.6194 15.9134ZM16.2104 18.9915L16.1975 18.2416L16.2104 18.9915ZM18.9134 18.6194L19.2004 19.3123H19.2004L18.9134 18.6194ZM19.6125 2.7368L19.2206 3.37628L19.6125 2.7368ZM21.2632 4.38751L21.9027 3.99563V3.99563L21.2632 4.38751ZM4.38751 2.7368L3.99563 2.09732V2.09732L4.38751 2.7368ZM2.7368 4.38751L2.09732 3.99563H2.09732L2.7368 4.38751ZM9.40279 19.2098L9.77986 18.5615L9.77986 18.5615L9.40279 19.2098ZM13.7321 21.7697L14.2742 20.8539L12.9833 20.0898L12.4412 21.0057L13.7321 21.7697ZM9.72579 20.8539L10.2679 21.7697L11.5587 21.0057L11.0166 20.0898L9.72579 20.8539ZM12.4412 21.0057C12.2485 21.3313 11.7515 21.3313 11.5587 21.0057L10.2679 21.7697C11.0415 23.0767 12.9585 23.0767 13.7321 21.7697L12.4412 21.0057ZM10.5 2.75H13.5V1.25H10.5V2.75ZM21.25 10.5V11.5H22.75V10.5H21.25ZM2.75 11.5V10.5H1.25V11.5H2.75ZM1.25 11.5C1.25 12.6546 1.24959 13.5581 1.29931 14.2868C1.3495 15.0223 1.45323 15.6344 1.68769 16.2004L3.07351 15.6264C2.92737 15.2736 2.84081 14.8438 2.79584 14.1847C2.75041 13.5189 2.75 12.6751 2.75 11.5H1.25ZM7.8025 18.2416C6.54706 18.2199 5.88923 18.1401 5.37359 17.9265L4.79957 19.3123C5.60454 19.6457 6.52138 19.7197 7.77666 19.7413L7.8025 18.2416ZM1.68769 16.2004C2.27128 17.6093 3.39066 18.7287 4.79957 19.3123L5.3736 17.9265C4.33223 17.4951 3.50486 16.6678 3.07351 15.6264L1.68769 16.2004ZM21.25 11.5C21.25 12.6751 21.2496 13.5189 21.2042 14.1847C21.1592 14.8438 21.0726 15.2736 20.9265 15.6264L22.3123 16.2004C22.5468 15.6344 22.6505 15.0223 22.7007 14.2868C22.7504 13.5581 22.75 12.6546 22.75 11.5H21.25ZM16.2233 19.7413C17.4786 19.7197 18.3955 19.6457 19.2004 19.3123L18.6264 17.9265C18.1108 18.1401 17.4529 18.2199 16.1975 18.2416L16.2233 19.7413ZM20.9265 15.6264C20.4951 16.6678 19.6678 17.4951 18.6264 17.9265L19.2004 19.3123C20.6093 18.7287 21.7287 17.6093 22.3123 16.2004L20.9265 15.6264ZM13.5 2.75C15.1512 2.75 16.337 2.75079 17.2619 2.83873C18.1757 2.92561 18.7571 3.09223 19.2206 3.37628L20.0044 2.09732C19.2655 1.64457 18.4274 1.44279 17.4039 1.34547C16.3915 1.24921 15.1222 1.25 13.5 1.25V2.75ZM22.75 10.5C22.75 8.87781 22.7508 7.6085 22.6545 6.59611C22.5572 5.57256 22.3554 4.73445 21.9027 3.99563L20.6237 4.77938C20.9078 5.24291 21.0744 5.82434 21.1613 6.73809C21.2492 7.663 21.25 8.84876 21.25 10.5H22.75ZM19.2206 3.37628C19.7925 3.72672 20.2733 4.20752 20.6237 4.77938L21.9027 3.99563C21.4286 3.22194 20.7781 2.57144 20.0044 2.09732L19.2206 3.37628ZM10.5 1.25C8.87781 1.25 7.6085 1.24921 6.59611 1.34547C5.57256 1.44279 4.73445 1.64457 3.99563 2.09732L4.77938 3.37628C5.24291 3.09223 5.82434 2.92561 6.73809 2.83873C7.663 2.75079 8.84876 2.75 10.5 2.75V1.25ZM2.75 10.5C2.75 8.84876 2.75079 7.663 2.83873 6.73809C2.92561 5.82434 3.09223 5.24291 3.37628 4.77938L2.09732 3.99563C1.64457 4.73445 1.44279 5.57256 1.34547 6.59611C1.24921 7.6085 1.25 8.87781 1.25 10.5H2.75ZM3.99563 2.09732C3.22194 2.57144 2.57144 3.22194 2.09732 3.99563L3.37628 4.77938C3.72672 4.20752 4.20752 3.72672 4.77938 3.37628L3.99563 2.09732ZM11.0166 20.0898C10.8136 19.7468 10.6354 19.4441 10.4621 19.2063C10.2795 18.9559 10.0702 18.7304 9.77986 18.5615L9.02572 19.8582C9.07313 19.8857 9.13772 19.936 9.24985 20.0898C9.37122 20.2564 9.50835 20.4865 9.72579 20.8539L11.0166 20.0898ZM7.77666 19.7413C8.21575 19.7489 8.49387 19.7545 8.70588 19.7779C8.90399 19.7999 8.98078 19.832 9.02572 19.8582L9.77986 18.5615C9.4871 18.3912 9.18246 18.3215 8.87097 18.287C8.57339 18.2541 8.21375 18.2487 7.8025 18.2416L7.77666 19.7413ZM14.2742 20.8539C14.4916 20.4865 14.6287 20.2564 14.7501 20.0898C14.8622 19.936 14.9268 19.8857 14.9742 19.8582L14.2201 18.5615C13.9298 18.7304 13.7204 18.9559 13.5379 19.2063C13.3646 19.4441 13.1864 19.7468 12.9833 20.0898L14.2742 20.8539ZM16.1975 18.2416C15.7862 18.2487 15.4266 18.2541 15.129 18.287C14.8175 18.3215 14.5129 18.3912 14.2201 18.5615L14.9742 19.8582C15.0192 19.832 15.096 19.7999 15.2941 19.7779C15.5061 19.7545 15.7842 19.7489 16.2233 19.7413L16.1975 18.2416Z" fill="#1C274C"/>
			<path opacity="0.5" d="M8 11H8.009M11.991 11H12M15.991 11H16" stroke="#1C274C" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
			</svg>
		</button>
		
		<div id="chatModal" class="modal">
		  <div class="modal-content">
		    <%@ include file="/WEB-INF/views/chat.jsp" %>
		  </div>
		</div>
	</c:if>

<div class="top-cards" id="editor-picks">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach var="edtiorPick" items="${edtiorPick}">
                <div class="swiper-slide">
                    <div style="text-align:center;">
                        <a href="/postingDetail?postingIdx=${edtiorPick.POSTING_IDX}">
                            <div class="image-container" data-posting-idx="${edtiorPick.POSTING_IDX}">
                                <img src="${edtiorPick.FILE_PATH}" class="img-fluid" alt="Image 1" style="width: 1920px; height:900px;">
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="swiper-pagination"></div>
    </div>
</div>

<c:choose>
<c:when test="${not empty sessionScope.userIdx }">
<div class="container">
    <h4 class="bold-text">Nearby Listings</h4>
    <c:forEach items="${p}" var="p">
    <div class="light-text">가까운 매장의 상품입니다
    <span>(현재 고객님의 주소는 ${p.address} ${p.detailAddress} 입니다)</span>
    </div>
    </c:forEach>
    <div class="item-wrapper" style="display:flex; flex-wrap: wrap; justify-content: flex-start;">
                <c:forEach items="${postingList}" var="pl">
                    <div class="item">
                        <div>
                            <img src="${pl.filePath}" alt="${pl.title}" style="width:100%; height:auto;">
                        </div>
                        <div style="padding: 10px; text-align: center; margin-top : 30px;">
                            <h4>${pl.title}</h4>
                            <p style="font-size:small;">${pl.storeName}</p>
                                <span class="address" style="font-size: medium;">주소 : ${pl.address} ${pl.detailAddress}</span>
                        </div>
                    </div>
                </c:forEach>
    </div>
</div>
</c:when>
<c:otherwise>
<div class="container" >
    <h4 class="bold-text">Nearby Listings</h4>
    <div class="light-text">지역별 매장의 상품입니다 </div>
    <div class="item-wrapper" style="display:flex; flex-wrap: wrap; justify-content: flex-start;">
                <c:forEach items="${pl}" var="pl">
                    <div class="item">
                        <div>
                            <img src="${pl.filePath}" alt="${pl.title}" style="width:100%; height:auto;">
                        </div>
                        <div style="padding: 10px; text-align: center; margin-top : 30px;">
                            <h4>${pl.title}</h4>
                            <p style="font-size:small;">${pl.storeName}</p>
                                <span class="address" style="font-size: medium;">주소 : ${pl.address} ${pl.detailAddress}</span>
                        </div>
                    </div>
                </c:forEach>
    </div>
</div>
</c:otherwise>
</c:choose>

<div class="container-best">
    <h4 class="bold-text">WEEKLY BEST</h4>
    <div class="light-text">한주간 가장 인기있는 상품입니다</div>
    <div class="weekly-best-container">
        <div class="weekly-best-wrapper">
            <c:forEach var="topPosting" items="${topPosting}">
                <div class="weekly-best-slide">
                    <a href="/postingDetail?postingIdx=${topPosting.POSTING_IDX}">
                        <div class="image-container" data-store-name="${topPosting.STORE_NAME}" data-posting-idx="${topPosting.POSTING_IDX}" data-price="${topPosting.PRICE}" data-title="${topPosting.TITLE}" data-date="${topPosting.UPDATE_DATE}">
                            <img src="${topPosting.FILE_PATH}" class="img-fluid" alt="Image 1" style="height: auto; width: 100%;">
                            <div class="overlay">
                                <div class="info"></div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="container">
    <h4 class="font-weight-bold">NEW ARRIVALS</h4>
    <div class="text-muted">새롭게 업데이트된 상품입니다</div>
    <div class="row">
        <c:forEach var="recent" items="${recent}">
            <div class="col-md-3 mt-3 mb-3 recent-posting-area">
                <div class="recent-posting">
                    <a class="text-decoration-none text-dark" href="/postingDetail?postingIdx=${recent.POSTING_IDX}">
                        <div class="recent-post-image">
                            <img src="${recent.FILE_PATH}" class="img-fluid" alt="${recent.TITLE}">
                        </div>
                        <div class="recent-post-title">${recent.TITLE}</div>
                        <div class="recent-post-info">
                            <div class="recent-price">${recent.PRICE}원</div>
                            <div class="recent-store-name">${recent.STORE_NAME}</div>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</main>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById('chat').onclick = function() {
    var modal = document.getElementById('chatModal');
    // 현재 모달이 열려있는지 확인
    var isVisible = modal.style.display === 'block';
    if (isVisible) {
        modal.style.display = "none";
    } else {
        modal.style.display = "block";
    }
}

// close 버튼 이벤트 핸들러 삭제

window.onclick = function(event) {
    var modal = document.getElementById('chatModal');
    // 모달 영역 외의 클릭 이벤트 처리
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const swiper = new Swiper('.swiper-container', {
        slidesPerView: 1,
        spaceBetween: 30,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        loop: true,
        loopAdditionalSlides: 1,
        // 자동 넘기기 기능
        autoplay: {
            delay: 5000, // 5초
            disableOnInteraction: false,
        },
        // 애니메이션 속도
        speed: 1000 
    });
});

// 페이지가 로드된 후에 body에 'loaded' 클래스를 추가
window.addEventListener('load', function() {
    document.body.classList.add('loaded');
});
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const imageContainers = document.querySelectorAll('.image-container');
    const weeklyBestWrapper = document.querySelector('.weekly-best-wrapper');

    imageContainers.forEach(container => {
        container.addEventListener('mouseover', function() {
            const postingIdx = this.dataset.postingIdx;
            const price = this.dataset.price;
            const title = this.dataset.title;
            const storeName = this.dataset.storeName;
            const infoDiv = this.querySelector('.info');

            // 가격을 파싱하여 포맷팅하는 함수
            const formattedPrice = Number(price).toLocaleString();

            infoDiv.innerHTML = '<div>' + title + '</div><div>' + formattedPrice + ' 원</div><div>' + storeName +'</div>';

            // 애니메이션을 일시 정지
            weeklyBestWrapper.style.animationPlayState = 'paused';
        });

        container.addEventListener('mouseout', function() {
            // 애니메이션을 다시 재생
            weeklyBestWrapper.style.animationPlayState = 'running';
        });
    });
});
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var recentPrices = document.querySelectorAll(".recent-price");

        recentPrices.forEach(function(priceElement) {
            var priceText = priceElement.textContent;
            var price = parseFloat(priceText.replace(/[^\d.-]/g, '')); // 숫자 이외의 문자 제거 후 숫자로 변환
            var formattedPrice = price.toLocaleString("ko-KR"); // 한국 통화 형식으로 포맷팅
            priceElement.textContent = formattedPrice + " 원";
        });
    });
</script>
</body>
</html>
