<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
body {
    visibility: hidden;
    opacity: 0;
    transition: visibility 0s, opacity 1s ease;
    margin : 0;
}
body.loaded {
    visibility: visible;
    opacity: 1;
}
main{
	margin-top :50px;
}

.image-container {
  position: relative;
  display: inline-block;
}

.top-cards{
  background-color : #D4E1A2;
  width: 100%;
  height : auto;
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

</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<main>
<div class="container-fluid top-cards" id="editor-picks">
<h2>에디터 픽 영역</h2>
  <div class="row">
  <c:forEach var="all" items="${all }">
	    <div class="col-md-3 mt-5 mb-5" style="text-align:center;">
		  	<a href="/postingDetail?postingIdx=${all.POSTING_IDX }">
			      <div class="image-container" data-posting-idx="${all.POSTING_IDX}" data-price="${all.PRICE}" data-title="${all.TITLE}">
			        <img src="${all.FILE_PATH }" class="img-fluid" alt="Image 1" style="height: 300px; width:auto;">
			        <div class="overlay">
			          <div class="info"></div>
			        </div>
			      </div>
		    </a>
	    </div>
    </c:forEach>
  </div>
</div>

<div class="container">
	<h2>매출 상위</h2>

</div>

<div class="container">
	<h2>신상품</h2>
	  <div class="row">
  <c:forEach var="recent" items="${recent }">
	    <div class="col-md-3 mt-5 mb-5" style="text-align:center;">
		  	<a href="/postingDetail?postingIdx=${recent.POSTING_IDX }">
			      <div class="image-container" data-posting-idx="${recent.POSTING_IDX}" data-price="${recent.PRICE}" data-title="${recent.TITLE}" data-date="${recent.UPDATE_DATE }">
			        <img src="${recent.FILE_PATH }" class="img-fluid" alt="Image 1" style="height: 300px; width:auto;">
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
    document.body.classList.add('loaded');
});
</script>
</body>
</html>