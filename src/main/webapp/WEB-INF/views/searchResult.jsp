<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style>
.searched-box {
	height:50px;
	width:340px;
	background: white;
	border-radius:40px;
	padding:10px;
	border:1px solid #ccc;
}

.searched-txt{
	border:none;
	background:none;
	outline:none;
	float:left;
	padding:0px;
	padding-left:10px;
	color:#797979;
	font-size:16px;
	line-height:30px;
	width:260px;
}

.searched-btn{
	color: black;
	float:right;
	width:40px;
	height:100%;
	border-radius:50%;
	background:white;
	border:none;
	font-size:16px;
	display:flex;
	justify-content: center;
	align-items:center;
}

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
		    
	<nav aria-label="Page navigation"  style="margin-top:100px;">
		<ul class="pagination justify-content-center">
        
			      <c:if test="${prev}">
			        <li class="page-item">
			          <a class="page-link" href="?page=${startPageNum - 1}" aria-label="Previous">
			            <span aria-hidden="true"  class="fas fa-angle-left"></span>
			          </a>
			        </li>
			      </c:if>
        

					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="page">
		                    <li class="page-item ${currentPage == page ? 'active' : ''}">
					   			<a class="page-link"  href="?page=${page}">${page}</a> 
							</li>
					</c:forEach>
					

					
					
					<c:if test="${next}">
		 				 <li class="page-item">
		 				 	<a class="page-link" href="?page=${endPageNum + 1}">
		 				 	    <span aria-hidden="true"  class="fas fa-angle-right"></span> 				 	
		 				 	</a> 
		 				 </li>
					</c:if>

			</ul>
		</nav>
	</c:when>
	    
		<c:otherwise>
		<div style="text-align:center; margin-top:50px;">
		    	<h2>검색 결과가 없습니다.</h2>
		</div>
		</c:otherwise>
    </c:choose>
    
  </div>
</div>
<div class="centered-container mt-5">
     <form class="search-box searched-box" id="searched-box" action="/search?keyword=${keyword}" method="GET">
         <input class="search-txt searched-txt" id="searched-txt" type="text" name="keyword" value="${keyword}" placeholder="검색할 내용을 입력해주세요.">
         <button class="search-btn searched-btn" type="submit">
         	<i class="fa-solid fa-magnifying-glass"></i>
         </button>
     </form>
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

	      // 가격을 파싱하여 포맷팅하는 함수
	      const formattedPrice = Number(price).toLocaleString();

	      infoDiv.innerHTML = '<div>' + title + '</div><div>' + formattedPrice + '원</div>';
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