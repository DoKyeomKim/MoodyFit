<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 - ${categoryEngName}</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
.cateDefault {
	text-align: center;
}

.subCateDefault {
	text-align: center;
}

.subCateDefault a {
	text-decoration: none;
	margin: 20px;
	color: black;
}

.subCateDefault a:hover {
	color: grey;
}

.card {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 15px;
	text-align: center;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>
	<br>
	<br>
	<div class="cateDefault">
		<h3>${categoryEngName}</h3>
	</div>
	<div class="subCateDefault">
		<c:forEach var="subCategory" items="${subCategories}">
			<a href="/category/${categoryEngName}/${subCategory.engName}"> 
				<c:choose>
					<c:when test="${subCategory.korName == '전체'}">All</c:when>
					<c:otherwise>${subCategory.korName}</c:otherwise>
				</c:choose>
			</a>
		</c:forEach>
	</div>

<main>
    <div class="container">
        <div class="row">
            <c:choose>
                <c:when test="${not empty allPosting}">
                    <c:forEach var="allPosting" items="${allPosting}" begin="0" end="3">
                        <div class="col-3">
                            <div class="card">
                                <img src="${allPosting.FILE_PATH}" class="img-fluid">
                                <div class="card-body">
                                    <span>${allPosting.POSTING_IDX}</span><br>
                                    <span>제조사 : ${allPosting.MANUFACTURE_NAME}</span><br>
                                    <span>공고 제목 : ${allPosting.TITLE}</span><br>
                                    <span>가격 : ${allPosting.PRICE}</span>
                                </div>
                            </div>
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
                <c:when test="${not empty selectedPosting}">
                    <c:forEach var="selectedPosting" items="${selectedPosting}" begin="0" end="3">
                        <div class="col-3">
                            <div class="card">
                                <img src="${selectedPosting.FILE_PATH}" class="img-fluid">
                                <div class="card-body">
                                    <span>${selectedPosting.POSTING_IDX}</span><br>
                                    <span>제조사 : ${selectedPosting.MANUFACTURE_NAME}</span><br>
                                    <span>공고 제목 : ${selectedPosting.TITLE}</span><br>
                                    <span>가격 : ${selectedPosting.PRICE}</span>
                                </div>
                            </div>
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
                    <h3 style="text-align: center; margin-top:50px;">상품 공고가 없습니다!!</h3>
                </c:otherwise>
            </c:choose>
            
 
        </div>
    </div>
</main>



	<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
