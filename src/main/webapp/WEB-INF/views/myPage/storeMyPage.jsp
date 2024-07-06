<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<style>
main {
  display: flex;
  flex-direction: column;
}

.status {
  display: flex;
  justify-content: space-around;
  align-items: center;
  width: 100%;
  margin: auto;
  padding: 20px;
  box-sizing: border-box;
}

.status-box {
  width: 150px;
  height: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: #fff;
  margin: 0 10px;
  flex: 1;
  border-right: 0.5px solid #ccc;
}

.status-box:last-child {
  border-right: none;
}

.status-box h3 {
  font-size: 24px;
  font-weight: bold;
  margin: 0;
  color: #333;
}

.status-box p {
  font-size: 16px;
  margin: 5px 0 0 0;
  color: #666;
}

.my-postings {
  width: 100%;
  margin-top: 50px;
}

.my-postings h2 {
  text-align: center;
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
}

.top-posting {
  position: relative;
  text-align: left;
  margin: 20px;
  border: 0.5px solid #ccc;
  padding: 15px;
  border-radius: 5px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.top-posting:hover {
  transform: scale(1.02);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.rank-badge {
  position: absolute;
  top: -10px;
  left: -10px;
  background-color: #d4fae5; /* 눈에 잘 띄는 빨간색 */
  color: #black;
  padding: 10px 15px;
  border-radius: 50%;
  font-size: 20px;
  font-weight: bold;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* 약간의 그림자 추가 */
  z-index: 10; /* 다른 요소보다 위에 오도록 */
}


.top-post-title {
  font-size: 20px;
  font-weight: bold;
  margin-top: 10px;
}

.top-post-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}

.top-price {
  font-size: 17px;
  font-weight: bold;
}

.top-store-name {
  opacity: 0.7;
}

.top-post-image {
  height: 260px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  padding: 0;
}

.top-post-image img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  margin: 0;
}

.swiper-container {
  height: auto; /* 필요에 따라 높이를 조절하세요 */
  overflow: hidden;
  position: relative;
}

.swiper-wrapper {
  height: 100%;
  -webkit-overflow-scrolling: touch; /* 스크롤 부드럽게 */
}
</style>
</head>
<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>
<body style="background-color:#F6F4EE !important;">
  <main style="margin-bottom : 100px;">
    <div class="container">
      <div class="row">
        <div class="text-center">
          <h2 style="text-align: center; font-size: 35px; font-weight: 600; color: #867B73;">마이페이지</h2>
        </div>
      </div>
      <h3 style="text-align: left; margin-bottom:50px; padding-top: 50px;">${store.storeName} 님</h3>
      <div class="status1" style="background-color:white; border-radius:20px;" >
        <div class="status">
          <div class="status-box">
            <h3>${postingCount }</h3>
            <p>등록한 공고 수</p>
          </div>
          <div class="status-box">
            <h3>${productCount }</h3>
            <p>등록한 제품 수</p>
          </div>
          <div class="status-box">
            <h3>${orderCount }</h3>
            <p>총 주문 건수</p>
          </div>
          <div class="status-box">
            <h3 class="new-price">${totalRevenue } 원</h3>
            <p>총 매출</p>
          </div>
        </div>
        <div class="my-postings">
          <h2>판매 TOP 10</h2>
          <c:choose>
            <c:when test="${not empty topPosting }">
              <div class="swiper-container">
                <div class="swiper-wrapper">
                  <c:forEach var="topPosting" items="${topPosting}" varStatus="status">
                    <div class="swiper-slide col-md-3 mt-3 mb-3 top-posting-area">
                      <div class="top-posting">
                        <div class="rank-badge">${status.index + 1}</div>
                        <a class="text-decoration-none text-dark" href="/postingDetail?postingIdx=${topPosting.POSTING_IDX}">
                          <div class="top-post-image">
                            <img src="${topPosting.FILE_PATH}" class="img-fluid" alt="${topPosting.TITLE}">
                          </div>
                          <div class="top-post-title">${topPosting.TITLE}</div>
                          <div class="top-post-info">
                            <div class="top-price new-price">${topPosting.PRICE}원</div>
                            <div class="top-store-name">${topPosting.STORE_NAME}</div>
                          </div>
                        </a>
                      </div>
                    </div>
                  </c:forEach>
                </div>
                <div class="swiper-pagination"></div>
              </div>
            </c:when>
            <c:otherwise>
              <div style="text-align:center; margin-top : 50px;">
                <h3> 아직 제품을 판매되지 않았습니다! </h3>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </main>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      document.body.classList.add('loaded');
    });
  </script>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      var swiper = new Swiper('.swiper-container', {
        slidesPerView: 4,
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
        autoplay: {
          delay: 5000, // 5초
          disableOnInteraction: false,
        },
        speed: 1000 
      });
    });
  </script>
  <script>
  document.addEventListener('DOMContentLoaded', function() {
  // 모든 new-price 클래스를 가진 요소를 선택합니다.
  var priceElements = document.querySelectorAll('.new-price');
  
  // 각 요소에 대해 숫자를 포맷팅합니다.
  priceElements.forEach(function(element) {
    var priceText = element.textContent;
    // 숫자만 추출합니다.
    var priceNumber = parseInt(priceText.replace(/[^0-9]/g, ''), 10);
    if (!isNaN(priceNumber)) {
      // 숫자를 1,000 단위로 쉼표를 추가하여 포맷팅합니다.
      element.textContent = priceNumber.toLocaleString('ko-KR') + ' 원';
    }
  });
});
</script>
</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
