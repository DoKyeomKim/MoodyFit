<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지역별 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0; padding : 0;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	min-height: 100vh;
	padding: 0;
}

.container {
	width: 100%;
	margin-top: 80px;
	font-size: 15px;
	flex-grow: 1;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.header h1 {
	font-size: 18px;
	margin: 0;
}

.filter-bar {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.filter-bar select, .filter-bar input[type="text"] {
	padding: 10px;
	margin-right: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.filter-bar select {
	width: 200px;
}

.filter-bar input[type="text"] {
	flex-grow: 1;
}

.filter-bar button {
	padding: 10px 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #ddd;
	cursor: pointer;
}

.items-wrapper {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.item {
	width: calc(20% - 10px);
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

.image img {
	width: 100%;
	height: auto;
}

.details {
	padding: 10px;
	text-align: center;
}

.details h3 {
	font-size: 16px;
	margin: 10px 0;
}

.details p {
	font-size: 14px;
	color: #555;
}

.price {
	margin-top: 10px;
	font-size: 14px;
	color: #f60;
}

.address {
	display: block;
	margin-top: 5px;
	font-size: 12px;
	color: #777;
}

.stars {
	display: inline-block;
	font-size: 24px;
}

.star {
	display: inline-block;
	width: 24px;
	height: 24px;
	background-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2c-.3 0-.5.1-.7.3L8.3 6.3 3.9 7.2c-.4.1-.7.5-.8.9-.1.4 0 .9.3 1.2l4.5 4.4-1.1 5.4c-.1.4.1.7.4.9.3.2.7.2 1.1 0L12 16.3l5.8 3c.4.2.8.2 1.1 0 .3-.2.5-.5.4-.9l-1.1-5.4 4.5-4.4c.3-.3.4-.8.3-1.2-.1-.4-.5-.8-.8-.9l-4.4-.9-2.9-3.6c-.2-.2-.4-.3-.7-.3z"/></svg>');
	background-size: cover;
}

.pagination {
	display: flex;
	justify-content: center;
	margin: 20px 0px;
	border-top: 1px solid #ddd;
}

.pagination button {
	padding: 10px;
	margin: 20px 5px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: gray;
	cursor: pointer;
}

.pagination button.active {
	background-color: #gray;
	color: #fff;
}
</style>
</head>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<body>
    <input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
    <div class="container">
        <h1 class="head" style="font-size: 18px; margin-top: 30px;">NEARBY LISTING | 자역별 리스트</h1>
        <div class="header"></div>
        <div class="filter-bar">
            <select id="address" onchange="filterItems()">
                <option value="">지역을 선택해주세요</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="인천">인천</option>
                <option value="부산">부산</option>
                <option value="대구">대구</option>
                <option value="광주">광주</option>
                <option value="대전">대전</option>
                <option value="울산">울산</option>
                <option value="세종">세종</option>
                <option value="강원">강원</option>
                <option value="경남">경남</option>
                <option value="경북">경북</option>
                <option value="전남">전남</option>
                <option value="전북">전북</option>
                <option value="충남">충남</option>
                <option value="충북">충북</option>
                <option value="제주">제주</option>
            </select>

            <select id="category" onchange="filterItems()">
                <option value="">카테고리를 선택해주세요</option>
                <option value="OUTER">OUTER</option>
                <option value="TOP">TOP</option>
                <option value="KNIT">KNIT</option>
                <option value="SHIRTS">SHIRTS</option>
                <option value="PANTS">PANTS</option>
                <option value="SHOES">SHOES</option>
                <option value="BAG">BAG</option>
                <option value="ACC">ACC</option>
                <option value="HAT">HAT</option>
            </select>

            <select id="sort" onchange="filterItems()">
                <option value="latest">최신순</option>
                <option value="rating">별점순</option>
                <option value="reviewCount">리뷰 많은순</option>
            </select>

            <input type="text" id="search" placeholder="검색어 입력" onkeyup="filterItems()">
        </div>
        <c:if test="${not empty postingList}">
            <div class="items-wrapper" id="items-wrapper">
                <c:forEach items="${postingList}" var="pl">
                    <div class="item" data-address="${pl.address}" data-category="${pl.engName}" data-title="${pl.title}" 
                    data-date="${pl.updateDate}" data-rating="${pl.rating}" data-reviewCount="${pl.reviewCount}">
                        <div class="image">
                            <img src="${pl.filePath}" alt="${pl.title}">
                        </div>
                        <div class="details">
                            <h3>${pl.title}</h3>
                            <p>${pl.storeName}</p>
                            <div>KRW <span class="price">${pl.price}</span> </div>
                                <span class="engName">${pl.engName}</span>
                                <span class="address">주소 : ${pl.address} ${pl.detailAddress}</span>
                            <div>별점 : <span class="rating">${pl.rating}</span>
                            	
                            </div>
                                <hr>
                            <div style="color:gray; font-size:small; text-align: left; display:flex; justify-content: space-between;">
                                <div >
                                등록 날짜 : <span class="date">${pl.updateDate}</span>
                                </div>
                                <div>리뷰 수 : <span class="reviewCount">${pl.reviewCount}</span></div>
                           </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- 페이지 숫자 버튼 -->
            <div class="pagination" id="pagination"></div>
        </c:if>
    </div>
    <script src="/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterItems() {
            var addressFilter = document.getElementById("address").value.toLowerCase();
            var categoryFilter = document.getElementById("category").value.toLowerCase();
            var sortFilter = document.getElementById("sort").value;
            var searchFilter = document.getElementById("search").value.toLowerCase();

            var items = document.querySelectorAll(".item");

            items.forEach(function(item) {
                var address = item.getAttribute("data-address").toLowerCase();
                var category = item.getAttribute("data-category").toLowerCase();
                var title = item.getAttribute("data-title").toLowerCase();

                var addressMatch = addressFilter === "" || address.includes(addressFilter);
                var categoryMatch = categoryFilter === "" || category.includes(categoryFilter);
                var searchMatch = searchFilter === "" || title.includes(searchFilter);

                if (addressMatch && categoryMatch && searchMatch) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            });

            // Sorting items
            var itemsWrapper = document.getElementById("items-wrapper");
            var itemsArray = Array.prototype.slice.call(items);

            itemsArray.sort(function(a, b) {
                if (sortFilter === "latest") {
                    return new Date(b.getAttribute("data-date")) - new Date(a.getAttribute("data-date"));
                } else if (sortFilter === "rating") {
                    return parseFloat(b.getAttribute("data-rating")) - parseFloat(a.getAttribute("data-rating"));
                } else if (sortFilter === "reviewCount") {
                    return parseFloat(b.getAttribute("data-reviewCount")) - parseFloat(a.getAttribute("data-reviewCount"));
                }
            });

            itemsArray.forEach(function(item) {
                itemsWrapper.appendChild(item);
            });
        }
        
        var currentPage = 0;
        var itemsPerPage = 20; // 페이지당 출력할 아이템 수

        // 페이지 변경 함수
        function changePage(page) {
            currentPage = page;
            showPage(currentPage);
        }

        // 현재 페이지에 따라 보여줄 아이템 설정
        function showPage(page) {
            var items = document.querySelectorAll('.item');
            var start = page * itemsPerPage;
            var end = start + itemsPerPage;

            items.forEach(function(item, index) {
                if (index >= start && index < end) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });

            // 페이지 번호 버튼 생성
            renderPagination();
        }

        // 페이지 번호 버튼 생성 함수
        function renderPagination() {
            var items = document.querySelectorAll('.item');
            var totalItems = items.length;
            var totalPages = Math.ceil(totalItems / itemsPerPage);

            var paginationContainer = document.getElementById('pagination');
            paginationContainer.innerHTML = '';

            for (var i = 0; i < totalPages; i++) {
                var pageNumber = i + 1;
                var button = document.createElement('button');
                button.textContent = pageNumber;
                button.classList.add('page-btn');
                if (currentPage === i) {
                    button.classList.add('active');
                }
                button.onclick = (function(page) {
                    return function() {
                        changePage(page);
                    };
                })(i);
                paginationContainer.appendChild(button);
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            // 페이지 로드 시 첫 페이지 보여주기
            showPage(currentPage);

            // 모든 price 클래스 요소를 선택하여 천 단위 쉼표 추가
            var prices = document.querySelectorAll('.price');
            prices.forEach(function(price) {
                var value = parseInt(price.textContent, 10);
                price.textContent = value.toLocaleString();
            });
        });
    </script>
</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
