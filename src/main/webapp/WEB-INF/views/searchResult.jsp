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
body{
margin : 0 auto;
}
main{
	margin-top :50px;
}

.image-container {
  position: relative;
  display: inline-block;
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
.centered-container {
    display: flex;
    justify-content: center;
    margin-bottom:100px;
}
</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<main>
<div class="centered-container">
     <form class="search-box" id="searched-box" action="/search?keyword=${keyword}" method="GET">
         <input class="search-txt" id="searched-txt" type="text" name="keyword" value="${keyword}" placeholder="검색할 내용을 입력해주세요.">
         <button class="search-btn" type="submit">
         	<i class="fa-solid fa-magnifying-glass"></i>
         </button>
     </form>
</div>

<div class="container">
  <div class="row">
  <c:choose>
	  <c:when test="${not empty result}">
		  <c:forEach var="result" items="${result }">
			    <div class="col-md-3">
				  	<a href="/postingDetail?postingIdx=${result.POSTING_IDX }">
				      <div class="image-container" data-posting-idx="${result.POSTING_IDX}" data-price="${result.PRICE}" data-title="${result.TITLE}">
				        <img src="${result.FILE_PATH }" class="img-fluid" alt="Image 1">
				        <div class="overlay">
				          <div class="info"></div>
				        </div>
				      </div>
				    </a>
			    </div>
		    </c:forEach>
	    </c:when>
	    
		<c:otherwise>
		<div style="text-align:center; margin-top:50px;">
		    	<h2>검색 결과가 없습니다.</h2>
		</div>
		</c:otherwise>
    </c:choose>
  </div>
</div>
</main>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  const imageContainers = document.querySelectorAll('.image-container');

  imageContainers.forEach(container => {
    container.addEventListener('mouseover', function() {
      const postingIdx = this.dataset.postingIdx;
      const price = this.dataset.price;
      const title = this.dataset.title;
      const infoDiv = this.querySelector('.info');

      infoDiv.innerHTML = '<div>' + title + '</div><div>' + price + '원</div>';
    });
  });
});
</script>
<script>
document.getElementById('searched-box').addEventListener('submit', function(event) {
    var searchInput = document.getElementById('searched-txt').value;
    if (!searchInput) {
        alert('검색할 내용을 입력해주세요!');
        event.preventDefault();
    }
});
</script>				
</body>
</html>