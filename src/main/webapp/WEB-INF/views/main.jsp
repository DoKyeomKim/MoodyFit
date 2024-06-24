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
</style>
</head>
<body>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<main id="main-content">
<div class="top-cards" id="editor-picks">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach var="all" items="${all}">
                <div class="swiper-slide">
                    <div style="text-align:center;">
                        <a href="/postingDetail?postingIdx=${all.POSTING_IDX}">
                            <div class="image-container" data-posting-idx="${all.POSTING_IDX}" data-price="${all.PRICE}" data-title="${all.TITLE}">
                                <img src="${all.FILE_PATH}" class="img-fluid" alt="Image 1" style="width: 1920px; height:900px;">
                                <div class="overlay">
                                    <div class="info"></div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="swiper-pagination"></div>
    </div>
</div>

<div class="container">
    <h4 class="bold-text">WEEKLY BEST</h4>
    <div class="light-text">한주간 가장 인기있는 상품입니다</div>

</div>

<div class="container">
    <h4 class="bold-text" >NEW ARRIVALS</h4>
    <div class="light-text">새롭게 업데이트된 상품입니다</div>
    <div class="row">
        <c:forEach var="recent" items="${recent}">
            <div class="col-md-3 mt-5 mb-5" style="text-align:center;">
                <a href="/postingDetail?postingIdx=${recent.POSTING_IDX}">
                    <div class="image-container" data-posting-idx="${recent.POSTING_IDX}" data-price="${recent.PRICE}" data-title="${recent.TITLE}" data-date="${recent.UPDATE_DATE}">
                        <img src="${recent.FILE_PATH}" class="img-fluid" alt="Image 1" style="height: 260px; width:334px;">
                        <div class="overlay">
                            <div class="info"></div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>
</main>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const imageContainers = document.querySelectorAll('.image-container');

    imageContainers.forEach(container => {
        container.addEventListener('mouseover', function() {
            const postingIdx = this.dataset.postingIdx;
            const price = this.dataset.price;
            const title = this.dataset.title;
            const updateDate = this.dataset.date
            const infoDiv = this.querySelector('.info');

            // 가격을 파싱하여 포맷팅하는 함수
            const formattedPrice = Number(price).toLocaleString();

            infoDiv.innerHTML = '<div>' + title + '</div><div>' + formattedPrice + '원</div><div>'+updateDate+'일 출시</div>';
        });
    });
});

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
    document.body.classList.add('loaded');
});
</script>
</body>
</html>
