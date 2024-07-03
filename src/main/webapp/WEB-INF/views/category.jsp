<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 - ${categoryEngName}</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<style>
.category-best-item{
	background-color :#fafafa;
}
.cateDefault {
	text-align: center;
	background-color :#fafafa;
    position: relative;
    height: 50vh;
    overflow: hidden;
    z-index: 1;
}

.category-name{
	text-align:center;
	margin-top : 100px;
	margin-bottom : 30px;
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
	color: gray;
}

.card {
	border: none !important; /* Added !important to override other styles */
	border-radius: 4px;
	padding: 15px;
	text-align: center;
}

.all-posting {
    text-align: left;
    margin: 20px;
    border: 0.5px solid #ccc;
    padding: 15px;
    border-radius: 5px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.all-posting:hover {
    transform: scale(1.02);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
.all-post-title {
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
}
.all-post-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}
.all-price {
    font-size: 17px;
    font-weight: bold;
}
.all-store-name {
    opacity: 0.7;
}
.all-post-image {
    height: 260px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    padding: 0;
}

.all-post-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    margin: 0;
}

.post-header{
	display:flex;
	justify-content: space-between;
	align-items: center;
}

.wishBtn{
	border:none;
	background-color : transparent;
}

.editorBtn{
	border:none;
	background-color : transparent;
}
.sort-form {
    display: flex;
	justify-content: flex-end;
    align-items: center;
    gap: 10px;
    padding: 10px;
}

.sort-select {
    padding: 5px 10px;
    font-size: 16px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    background-color: #ffffff;
    transition: border-color 0.3s;
}

.sort-select:focus {
    border-color: #80bdff;
    outline: none;
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


.swiper-pagination {
    position: absolute;
    width: 100%;
    text-align: center;
}

.swiper-pagination-progressbar {
  	z-index: 10;
  	position:relative;
    height: 100%;
    margin-bottom : 100px;
}
.swiper-pagination-progressbar .swiper-pagination-progressbar-fill {
    background: black; /* 원하는 색상으로 변경 */
}
.image-container {
    position: relative;
    overflow: hidden;
}

.image-container .overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 0;
    background: rgba(0, 0, 0, 0.7);
    color: #fff;
    overflow: hidden;
    transition: height 0.3s ease;
}

.image-container:hover .overlay {
    height: 25%;
}

.image-container .overlay .info {
    position: absolute;
    bottom: 0;
    left: 0;
    padding: 10px;
    text-align: left;
}

.image-container .title, .image-container .price, .image-container .store-name {
    margin: 0;
}

.image-container .title {
    font-size: 18px;
    font-weight: bold;
}

.image-container .price {
    font-size: 16px;
    color: #ffcc00;
}

.image-container .store-name {
    font-size: 14px;
    opacity: 0.7;
}
</style>
</head>
<body style="margin-top:70px;">
	<%@include file="/WEB-INF/layouts/header.jsp"%>


    <c:choose>
        <c:when test="${not empty topPosting}">
        <div class="category-best-item">
	        <div class="category-name">
			    <h3 style="padding-top:30px;">${categoryEngName} BEST ITEM</h3>
			</div>	
			<div class="cateDefault">
	            <div class="swiper-container">
	                <div class="swiper-wrapper">
					<c:forEach var="topPosting" items="${topPosting}">
					    <div class="swiper-slide">
					        <div class="image-container" data-store-name="${topPosting.STORE_NAME}" data-posting-idx="${topPosting.POSTING_IDX}" data-price="${topPosting.PRICE}" data-title="${topPosting.TITLE}" data-date="${topPosting.UPDATE_DATE}">
					            <a href="/postingDetail?postingIdx=${topPosting.POSTING_IDX}">
						            <img src="${topPosting.FILE_PATH}" class="img-fluid" alt="Image 1" style="height: 400px; width: auto;">
						            <div class="overlay">
						                <div class="info">
						                    <h3 class="title">${topPosting.TITLE}</h3>
						                    <p class="price top-posting">${topPosting.PRICE}</p>
						                    <p class="store-name">${topPosting.STORE_NAME}</p>
						                </div>
						            </div>
					            </a>
					        </div>
					    </div>
					</c:forEach>
	                </div>
	            </div>
			</div>
			<div class="best-progressbar">
				<div class="swiper-pagination swiper-pagination-progressbar"></div>
			</div>
		</div>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>
	<input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
    <div class="category-name">
	    <h3>${categoryEngName}</h3>
	</div>	
	<div class="subCateDefault">
		<c:forEach var="subCategory" items="${subCategories}">
			<a href="/category/${categoryEngName}/${subCategory.engName}"> <c:choose>
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
					<form method="get" action="/category/${categoryEngName}/${subCategoryName}" class="sort-form">
					    <select id="orderBy" name="orderBy" class="sort-select" onchange="this.form.submit()">
					        <option value="newest" ${orderBy == 'newest' ? 'selected' : ''}>최신순</option>
					        <option value="oldest" ${orderBy == 'oldest' ? 'selected' : ''}>오래된 순</option>
					        <option value="expensive" ${orderBy == 'expensive' ? 'selected' : ''}>비싼 순</option>
					        <option value="chip" ${orderBy == 'chip' ? 'selected' : ''}>저렴한 순</option>
					        <option value="sales" ${orderBy == 'sales' ? 'selected' : ''}>매출순</option>
					    </select>
					</form>
					<c:forEach var="allPosting" items="${allPosting}">
				            <div class="col-md-3 mt-3 mb-3 all-posting-area">
				                <div class="all-posting">
				                    <a class="text-decoration-none text-dark" href="/postingDetail?postingIdx=${allPosting.POSTING_IDX}">
			                        <div class="all-post-image">
			                            <img src="${allPosting.FILE_PATH}" class="img-fluid" alt="${allPosting.TITLE}">
			                        </div>
				                        <div class="post-header">
				                        	<div class="all-post-title">${allPosting.TITLE}</div>
					                        <div class="all-post-wish">
								                <security:authorize access="hasRole('ROLE_PERSON')">
													<button class="wishBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${allPosting.POSTING_IDX}">
													    <svg style="margin-top: 10px;" width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
													        <path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
													    </svg>
													</button>
												</security:authorize>	
												<security:authorize access="hasRole('ROLE_ADMIN')">
													<button class="editorBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${allPosting.POSTING_IDX}">
														<svg style="margin-top: 10px;" width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
															<path d="M11.2691 4.41115C11.5006 3.89177 11.6164 3.63208 11.7776 3.55211C11.9176 3.48263 12.082 3.48263 12.222 3.55211C12.3832 3.63208 12.499 3.89177 12.7305 4.41115L14.5745 8.54808C14.643 8.70162 14.6772 8.77839 14.7302 8.83718C14.777 8.8892 14.8343 8.93081 14.8982 8.95929C14.9705 8.99149 15.0541 9.00031 15.2213 9.01795L19.7256 9.49336C20.2911 9.55304 20.5738 9.58288 20.6997 9.71147C20.809 9.82316 20.8598 9.97956 20.837 10.1342C20.8108 10.3122 20.5996 10.5025 20.1772 10.8832L16.8125 13.9154C16.6877 14.0279 16.6252 14.0842 16.5857 14.1527C16.5507 14.2134 16.5288 14.2807 16.5215 14.3503C16.5132 14.429 16.5306 14.5112 16.5655 14.6757L17.5053 19.1064C17.6233 19.6627 17.6823 19.9408 17.5989 20.1002C17.5264 20.2388 17.3934 20.3354 17.2393 20.3615C17.0619 20.3915 16.8156 20.2495 16.323 19.9654L12.3995 17.7024C12.2539 17.6184 12.1811 17.5765 12.1037 17.56C12.0352 17.5455 11.9644 17.5455 11.8959 17.56C11.8185 17.5765 11.7457 17.6184 11.6001 17.7024L7.67662 19.9654C7.18404 20.2495 6.93775 20.3915 6.76034 20.3615C6.60623 20.3354 6.47319 20.2388 6.40075 20.1002C6.31736 19.9408 6.37635 19.6627 6.49434 19.1064L7.4341 14.6757C7.46898 14.5112 7.48642 14.429 7.47814 14.3503C7.47081 14.2807 7.44894 14.2134 7.41394 14.1527C7.37439 14.0842 7.31195 14.0279 7.18708 13.9154L3.82246 10.8832C3.40005 10.5025 3.18884 10.3122 3.16258 10.1342C3.13978 9.97956 3.19059 9.82316 3.29993 9.71147C3.42581 9.58288 3.70856 9.55304 4.27406 9.49336L8.77835 9.01795C8.94553 9.00031 9.02911 8.99149 9.10139 8.95929C9.16534 8.93081 9.2226 8.8892 9.26946 8.83718C9.32241 8.77839 9.35663 8.70162 9.42508 8.54808L11.2691 4.41115Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
														</svg>
													</button>
												</security:authorize>
											</div>
										</div>
				                        <div class="all-post-info">
				                            <div class="all-price">${allPosting.PRICE}원</div>
				                            <div class="all-store-name">${allPosting.STORE_NAME}</div>
				                        </div>
				                    </a>
				                </div>
				            </div>
				        </c:forEach>
						
						
						
						<nav aria-label="Page navigation" style="margin-top: 100px;">
							<ul class="pagination justify-content-center">
								<c:if test="${prev}">
									<li class="page-item"><a class="page-link"
										href="?orderBy=${orderBy}&&page=${startPageNum - 1}" aria-label="Previous"> <span
											aria-hidden="true" class="fas fa-angle-left"></span>
									</a></li>
								</c:if>
								<c:forEach begin="${startPageNum}" end="${endPageNum}"
									var="page">
									<li class="page-item ${currentPage == page ? 'active' : ''}">
										<a class="page-link" href="?orderBy=${orderBy}&&page=${page}">${page}</a>
									</li>
								</c:forEach>
								<c:if test="${next}">
									<li class="page-item"><a class="page-link"
										href="?orderBy=${orderBy}&&page=${endPageNum + 1}"> <span aria-hidden="true"
											class="fas fa-angle-right"></span>
									</a></li>
								</c:if>
							</ul>
						</nav>
					</c:when>
					<c:when test="${not empty selectedPosting}">
						<form method="get" action="/category/${categoryEngName}/${subCategoryName}" class="sort-form">
						    <select id="orderBy" name="orderBy" class="sort-select" onchange="this.form.submit()">
						        <option value="newest" ${orderBy == 'newest' ? 'selected' : ''}>최신순</option>
						        <option value="oldest" ${orderBy == 'oldest' ? 'selected' : ''}>오래된 순</option>
						        <option value="expensive" ${orderBy == 'expensive' ? 'selected' : ''}>비싼 순</option>
						        <option value="chip" ${orderBy == 'chip' ? 'selected' : ''}>저렴한 순</option>
						        <option value="sales" ${orderBy == 'sales' ? 'selected' : ''}>매출순</option>
						    </select>
						</form>
						<c:forEach var="selectedPosting" items="${selectedPosting}">
				            <div class="col-md-3 mt-3 mb-3 all-posting-area">
				                <div class="all-posting">
				                    <a class="text-decoration-none text-dark" href="/postingDetail?postingIdx=${selectedPosting.POSTING_IDX}">
			                        <div class="all-post-image">
			                            <img src="${selectedPosting.FILE_PATH}" class="img-fluid" alt="${selectedPosting.TITLE}">
			                        </div>
				                        <div class="post-header">
				                        	<div class="all-post-title">${selectedPosting.TITLE}</div>
					                        <div class="all-post-wish">
								                <security:authorize access="hasRole('ROLE_PERSON')">
													<button class="wishBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${selectedPosting.POSTING_IDX}">
													    <svg style="margin-top: 10px;" width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
													        <path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
													    </svg>
													</button>
												</security:authorize>	
												<security:authorize access="hasRole('ROLE_ADMIN')">
													<button class="editorBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${selectedPosting.POSTING_IDX}">
														<svg style="margin-top: 10px;" width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
															<path d="M11.2691 4.41115C11.5006 3.89177 11.6164 3.63208 11.7776 3.55211C11.9176 3.48263 12.082 3.48263 12.222 3.55211C12.3832 3.63208 12.499 3.89177 12.7305 4.41115L14.5745 8.54808C14.643 8.70162 14.6772 8.77839 14.7302 8.83718C14.777 8.8892 14.8343 8.93081 14.8982 8.95929C14.9705 8.99149 15.0541 9.00031 15.2213 9.01795L19.7256 9.49336C20.2911 9.55304 20.5738 9.58288 20.6997 9.71147C20.809 9.82316 20.8598 9.97956 20.837 10.1342C20.8108 10.3122 20.5996 10.5025 20.1772 10.8832L16.8125 13.9154C16.6877 14.0279 16.6252 14.0842 16.5857 14.1527C16.5507 14.2134 16.5288 14.2807 16.5215 14.3503C16.5132 14.429 16.5306 14.5112 16.5655 14.6757L17.5053 19.1064C17.6233 19.6627 17.6823 19.9408 17.5989 20.1002C17.5264 20.2388 17.3934 20.3354 17.2393 20.3615C17.0619 20.3915 16.8156 20.2495 16.323 19.9654L12.3995 17.7024C12.2539 17.6184 12.1811 17.5765 12.1037 17.56C12.0352 17.5455 11.9644 17.5455 11.8959 17.56C11.8185 17.5765 11.7457 17.6184 11.6001 17.7024L7.67662 19.9654C7.18404 20.2495 6.93775 20.3915 6.76034 20.3615C6.60623 20.3354 6.47319 20.2388 6.40075 20.1002C6.31736 19.9408 6.37635 19.6627 6.49434 19.1064L7.4341 14.6757C7.46898 14.5112 7.48642 14.429 7.47814 14.3503C7.47081 14.2807 7.44894 14.2134 7.41394 14.1527C7.37439 14.0842 7.31195 14.0279 7.18708 13.9154L3.82246 10.8832C3.40005 10.5025 3.18884 10.3122 3.16258 10.1342C3.13978 9.97956 3.19059 9.82316 3.29993 9.71147C3.42581 9.58288 3.70856 9.55304 4.27406 9.49336L8.77835 9.01795C8.94553 9.00031 9.02911 8.99149 9.10139 8.95929C9.16534 8.93081 9.2226 8.8892 9.26946 8.83718C9.32241 8.77839 9.35663 8.70162 9.42508 8.54808L11.2691 4.41115Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
														</svg>
													</button>
												</security:authorize>
											</div>
										</div>
				                        <div class="all-post-info">
				                            <div class="all-price">${selectedPosting.PRICE}원</div>
				                            <div class="all-store-name">${selectedPosting.STORE_NAME}</div>
				                        </div>
				                    </a>
				                </div>
				            </div>
				        </c:forEach>

						<nav aria-label="Page navigation" style="margin-top: 100px;">
							<ul class="pagination justify-content-center">
								<c:if test="${prev}">
									<li class="page-item"><a class="page-link"
										href="?orderBy=${orderBy}&&page=${startPageNum - 1}" aria-label="Previous"> <span
											aria-hidden="true" class="fas fa-angle-left"></span>
									</a></li>
								</c:if>
								<c:forEach begin="${startPageNum}" end="${endPageNum}"
									var="page">
									<li class="page-item ${currentPage == page ? 'active' : ''}">
										<a class="page-link" href="?orderBy=${orderBy}&&page=${page}">${page}</a>
									</li>
								</c:forEach>
								<c:if test="${next}">
									<li class="page-item"><a class="page-link"
										href="?orderBy=${orderBy}&&page=${endPageNum + 1}"> <span aria-hidden="true"
											class="fas fa-angle-right"></span>
									</a></li>
								</c:if>
							</ul>
						</nav>
						
					</c:when>
					<c:otherwise>
						<h3 style="text-align: center; margin-top: 50px;">상품 공고가 없습니다!!</h3>
					</c:otherwise>
				</c:choose>


			</div>
		</div>
	</main>



<script src="/js/bootstrap.bundle.min.js"></script>
<security:authorize access="isAuthenticated()">
    <c:choose>
        <c:when test="${sessionScope.role == 'ROLE_PERSON'}">
			<script>
			document.addEventListener("DOMContentLoaded", function() {
			    const userIdx = document.getElementById('userIdx').value;
			
			    function updateWishSvgs() {
			        const wishButtons = document.querySelectorAll('.wishBtn');
			        wishButtons.forEach(function(button) {
			            const postingIdx = button.getAttribute('data-posting-idx');
			            
			            if (!userIdx) {
			                const svg = button.querySelector('svg path');
			                svg.setAttribute('fill', 'none');
			                return;
			            }
			
			            // 스크랩 상태 확인 요청
			            fetch(`/checkWish?postingIdx=` + postingIdx + `&userIdx=` + userIdx,  {
			                method: 'GET',
			            })
			            .then(response => response.json())
			            .then(isWish => {
			                button.setAttribute('data-wish', isWish);
			                const svg = button.querySelector('svg path');
			                if (isWish) {
			                    svg.setAttribute('fill', 'red');
			                } else {
			                    svg.setAttribute('fill', 'none');
			                }
			            })
			            .catch(error => {
			                console.error('Error:', error);
			            });
			        });
			    }
			
			    updateWishSvgs(); // 페이지 로드 시 스크랩 버튼 상태 갱신
			
			    document.addEventListener('click', async function(e) {
			        const button = e.target.closest('.wishBtn'); // 상위 요소인 버튼을 찾기
			        if (button) {
			            e.preventDefault(); // 기본 동작 방지
			            e.stopPropagation(); // 이벤트 전파 방지
			            const svg = button.querySelector('svg path');
			            const postingIdx = button.getAttribute('data-posting-idx');
			            const userIdx = button.getAttribute('data-user-idx');
			            const isWish = button.getAttribute('data-wish') === 'true';
			            
			            try {
			                let response;
			                if (isWish) {
			                    // 찜 삭제 요청
			                    response = await fetch('/deleteWish', {
			                        method: 'DELETE',
			                        headers: {
			                            'Content-Type': 'application/json',
			                        },
			                        body: JSON.stringify({ postingIdx, userIdx }),
			                    });
			                } else {
			                    // 찜 추가 요청
			                    response = await fetch('/addWish', {
			                        method: 'POST',
			                        headers: {
			                            'Content-Type': 'application/json',
			                        },
			                        body: JSON.stringify({ postingIdx, userIdx }), // 변경된 부분
			                    });
			                }
			
			                if (response.ok) {
			                    const message = isWish ? '찜 목록에서 삭제되었습니다.' : '찜 목록에 추가되었습니다.';
			                    alert(message);
			                    updateWishSvgs(); // 개추 버튼 상태 갱신
			                } else {
			                    throw new Error('error.');
			                }
			            } catch (error) {
			                console.error('Error:', error);
			                alert('오류가 발생했습니다. 다시 시도해주세요.');
			            }
			            return; // 여기서 함수 실행 종료
			        }
			
			    });
			});
			</script>
		</c:when>
	</c:choose>
</security:authorize>
<security:authorize access="isAuthenticated()">
    <c:choose>
        <c:when test="${sessionScope.role == 'ROLE_ADMIN'}">
            <script>
            document.addEventListener("DOMContentLoaded", function() {
                const userIdx = document.getElementById('userIdx').value;

                function updateEditorPickSvgs() {
                    const editorButtons = document.querySelectorAll('.editorBtn');
                    editorButtons.forEach(function(button) {
                        const postingIdx = button.getAttribute('data-posting-idx');

                        if (!userIdx) {
                            const svg = button.querySelector('svg path');
                            svg.setAttribute('fill', 'none');
                            return;
                        }

                        // 에디터픽 상태 확인 요청
                        fetch(`/checkEditorPick?postingIdx=` + postingIdx + `&userIdx=` + userIdx,  {
                            method: 'GET',
                        })
                        .then(response => response.json())
                        .then(isEditorPick => {
                            button.setAttribute('data-editor-pick', isEditorPick);
                            const svg = button.querySelector('svg path');
                            if (isEditorPick) {
                                svg.setAttribute('fill', 'yellow');
                            } else {
                                svg.setAttribute('fill', 'none');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                    });
                }

                updateEditorPickSvgs(); // 페이지 로드 시 에디터픽 버튼 상태 갱신

                document.addEventListener('click', async function(e) {
                    const button = e.target.closest('.editorBtn'); // 상위 요소인 버튼을 찾기
                    if (button) {
                        e.preventDefault(); // 기본 동작 방지
                        e.stopPropagation(); // 이벤트 전파 방지
                        const svg = button.querySelector('svg path');
                        const postingIdx = button.getAttribute('data-posting-idx');
                        const userIdx = button.getAttribute('data-user-idx');
                        const isEditorPick = button.getAttribute('data-editor-pick') === 'true';

                        try {
                            let response;
                            if (isEditorPick) {
                                // 에디터픽 삭제 요청
                                response = await fetch('/deleteEditorPick', {
                                    method: 'DELETE',
                                    headers: {
                                        'Content-Type': 'application/json',
                                    },
                                    body: JSON.stringify({ postingIdx, userIdx }),
                                });
                            } else {
                                // 에디터픽 추가 요청
                                response = await fetch('/addEditorPick', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json',
                                    },
                                    body: JSON.stringify({ postingIdx, userIdx }), // 변경된 부분
                                });
                            }

                            if (response.ok) {
                                const message = isEditorPick ? '에디터픽 목록에서 삭제되었습니다.' : '에디터픽 목록에 추가되었습니다.';
                                alert(message);
                                updateEditorPickSvgs(); // 에디터픽 버튼 상태 갱신
                            } else {
                                throw new Error('error.');
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            alert('오류가 발생했습니다. 다시 시도해주세요.');
                        }
                        return; // 여기서 함수 실행 종료
                    }

                });
            });
            </script>
        </c:when>
    </c:choose>
</security:authorize>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var allPrices = document.querySelectorAll(".all-price");

        allPrices.forEach(function(priceElement) {
            var priceText = priceElement.textContent;
            var price = parseFloat(priceText.replace(/[^\d.-]/g, '')); // 숫자 이외의 문자 제거 후 숫자로 변환
            var formattedPrice = price.toLocaleString("ko-KR"); // 한국 통화 형식으로 포맷팅
            priceElement.textContent = formattedPrice + " 원";
        });
    });
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 2, // 한 번에 보여줄 슬라이드의 개수
        spaceBetween: 5, // 슬라이드 사이의 간격 (픽셀 단위)
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        pagination: {
            el: '.swiper-pagination',
            type: 'progressbar', // Progressbar 형식의 페이지네이션
        },
        loop: true, // 무한 루프
        autoplay: {
            delay: 5000, // 자동 재생 시간 (밀리초 단위)
            disableOnInteraction: false,
        },
        speed: 1000 
    });
});
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var topPostingPrices = document.querySelectorAll(".price.top-posting");

        topPostingPrices.forEach(function(priceElement) {
            var priceText = priceElement.textContent;
            var price = parseFloat(priceText.replace(/[^\d.-]/g, '')); // 숫자 이외의 문자 제거 후 숫자로 변환
            var formattedPrice = price.toLocaleString("ko-KR"); // 한국 통화 형식으로 포맷팅
            priceElement.textContent = formattedPrice + " 원";
        });
    });
</script>

</body>
</html>
