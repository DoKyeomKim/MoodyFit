<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 상세보기</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
/* 기본 스타일 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}
.posting-container {
    max-width: 1500px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
}
.product-image {
    width: 100%;
    max-width: 400px;
    height: auto;
}
.product-details {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
}
.product-image{
	height : 100%;
	width : 100%;
}
.product-title {
    font-size: 24px;
    margin-bottom: 10px;
}
.product-content {
    margin-bottom: 20px;
}
.purchase-info {
    padding: 20px;
}
.purchase-options {
    margin-bottom: 10px;
    
}
.purchase-options select, .purchase-options input {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
}
.price {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}
.buy-button {
    display: block;
    width: 100%;
    padding: 15px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border: none;
    cursor: pointer;
    font-size: 16px;
}
.tabs {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    border-top: 1px solid #ddd;
    padding-top: 10px;
}
.tab {
    flex: 1;
    text-align: center;
    padding: 10px;
    cursor: pointer;
    border-bottom: 2px solid transparent;
}
.tab.active {
    border-bottom: 2px solid #333;
    font-weight: bold;
}
.tab-content {
    margin-top: 20px;
}
.posting-info-area{
	width : 45%;
	margin-left: 100px;
}
.product-info {
    display: flex;
    justify-content: center;
    align-items: center; /* 수직 중앙 정렬을 원할 경우 추가 */
}
.posting-title-area{
	display: flex;
    justify-content: space-between;
    align-items: center;
}
.wishBtn{
	margin-right:20px;
	border:none;
	background-color : transparent;
}
.editorBtn{
	margin-right:20px;
	border:none;
	background-color : transparent;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<main>
<div class="posting-container">
    <!-- 상품 이미지 및 정보 -->
    <div class="product-details">
        <div class="product-info">
            <img src="${postingInfo.PRODUCT_FILE}" alt="상품 이미지" class="product-image">
        </div>
        <div class="posting-info-area">
        <div class="posting-title-area">
            <h2 class="product-title" style="margin-left:20px;">${postingInfo.TITLE}</h2>
            <input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
			<security:authorize access="hasRole('ROLE_PERSON')">
				<button class="wishBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${postingInfo.POSTING_IDX}">
				    <svg style="margin-top: 10px;" width="35px" height="35px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
				        <path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
				    </svg>
				</button>
			</security:authorize>	
			<security:authorize access="hasRole('ROLE_ADMIN')">
				<button class="editorBtn" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${postingInfo.POSTING_IDX}">
					<svg style="margin-top: 10px;" width="35px" height="35px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M11.2691 4.41115C11.5006 3.89177 11.6164 3.63208 11.7776 3.55211C11.9176 3.48263 12.082 3.48263 12.222 3.55211C12.3832 3.63208 12.499 3.89177 12.7305 4.41115L14.5745 8.54808C14.643 8.70162 14.6772 8.77839 14.7302 8.83718C14.777 8.8892 14.8343 8.93081 14.8982 8.95929C14.9705 8.99149 15.0541 9.00031 15.2213 9.01795L19.7256 9.49336C20.2911 9.55304 20.5738 9.58288 20.6997 9.71147C20.809 9.82316 20.8598 9.97956 20.837 10.1342C20.8108 10.3122 20.5996 10.5025 20.1772 10.8832L16.8125 13.9154C16.6877 14.0279 16.6252 14.0842 16.5857 14.1527C16.5507 14.2134 16.5288 14.2807 16.5215 14.3503C16.5132 14.429 16.5306 14.5112 16.5655 14.6757L17.5053 19.1064C17.6233 19.6627 17.6823 19.9408 17.5989 20.1002C17.5264 20.2388 17.3934 20.3354 17.2393 20.3615C17.0619 20.3915 16.8156 20.2495 16.323 19.9654L12.3995 17.7024C12.2539 17.6184 12.1811 17.5765 12.1037 17.56C12.0352 17.5455 11.9644 17.5455 11.8959 17.56C11.8185 17.5765 11.7457 17.6184 11.6001 17.7024L7.67662 19.9654C7.18404 20.2495 6.93775 20.3915 6.76034 20.3615C6.60623 20.3354 6.47319 20.2388 6.40075 20.1002C6.31736 19.9408 6.37635 19.6627 6.49434 19.1064L7.4341 14.6757C7.46898 14.5112 7.48642 14.429 7.47814 14.3503C7.47081 14.2807 7.44894 14.2134 7.41394 14.1527C7.37439 14.0842 7.31195 14.0279 7.18708 13.9154L3.82246 10.8832C3.40005 10.5025 3.18884 10.3122 3.16258 10.1342C3.13978 9.97956 3.19059 9.82316 3.29993 9.71147C3.42581 9.58288 3.70856 9.55304 4.27406 9.49336L8.77835 9.01795C8.94553 9.00031 9.02911 8.99149 9.10139 8.95929C9.16534 8.93081 9.2226 8.8892 9.26946 8.83718C9.32241 8.77839 9.35663 8.70162 9.42508 8.54808L11.2691 4.41115Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</button>
			</security:authorize>
		</div>
            <form action="/postingBuy" method="POST">
                <div class="purchase-info">
                    <div class="purchase-options">
                        <label for="color">색상</label>
                        <select id="color" name="color" onchange="updateSizes()">
                            <c:forEach var="color" items="${colors}">
                                <option value="${color}">${color}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="purchase-options">
                        <label for="size">사이즈</label>
                        <select id="size" name="size" onchange="updateProductInfo()">
                            <!-- 사이즈 옵션은 JavaScript로 동적으로 생성 -->
                        </select>
                    </div>
                    <div class="price">${postingInfo.PRICE} 원</div>
                    <input type="hidden" id="product_info_idx" name="product_info_idx">
                    <input type="hidden" id="posting_product_idx" name="posting_product_idx">
                    <button type="submit" class="buy-button">구매하기</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 상품 추가 정보 탭 -->
    <div class="tabs">
        <div class="tab active">상세정보</div>
        <div class="tab">사이즈</div>
        <div class="tab">상품후기</div>
        <div class="tab">상품문의</div>
    </div>
    
    <!-- 탭 내용 -->
    <div class="tab-content" style="text-align:center;">
        ${content}
    </div>
</div>
</main>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    updateSizes();
    updateProductInfo();
    
    $('.tab').click(function() {
        var index = $(this).index();
        $('.tab').removeClass('active');
        $(this).addClass('active');
        $('.tab-content').hide();
        $('.tab-content').eq(index).show();
    });
});

function updateSizes() {
    var color = $('#color').val();
    var sizeSelect = $('#size');
    sizeSelect.empty();

    var colorSizeMap = JSON.parse('${colorSizeMap}');
    var sizes = colorSizeMap[color];
    if (sizes) {
        for (var size in sizes) {
            var option = $('<option></option>').attr('value', size).text(size);
            sizeSelect.append(option);
        }
    }

    // Update the product_info_idx and posting_product_idx after updating sizes
    updateProductInfo();
}

function updateProductInfo() {
    var color = $('#color').val();
    var size = $('#size').val();
    var colorSizeMap = JSON.parse('${colorSizeMap}');
    
    if (colorSizeMap[color] && colorSizeMap[color][size]) {
        $('#product_info_idx').val(colorSizeMap[color][size].product_info_idx);
        $('#posting_product_idx').val(colorSizeMap[color][size].posting_product_idx);
    } else {
        $('#product_info_idx').val('');
        $('#posting_product_idx').val('');
    }
}
</script>
<security:authorize access="isAuthenticated()">
    <c:choose>
        <c:when test="${sessionScope.role == 'ROLE_PERSON'}">
<script>
function getCookie(name) {
    let cookieArr = document.cookie.split(";");
    for (let i = 0; i < cookieArr.length; i++) {
        let cookiePair = cookieArr[i].split("=");
        if (name === cookiePair[0].trim()) {
            return decodeURIComponent(cookiePair[1]);
        }
    }
    return null;
}

function setCookie(name, value, days) {
    let date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    let expires = "expires=" + date.toUTCString();
    document.cookie = name + "=" + encodeURIComponent(value) + ";" + expires + ";path=/";
}

document.addEventListener("DOMContentLoaded", function() {
    let postingIdx = "${postingInfo.POSTING_IDX}";
    let recentPostings = getCookie("recentPostings");

    if (recentPostings) {
        recentPostings = JSON.parse(recentPostings);
        if (!recentPostings.includes(postingIdx)) {
            recentPostings.push(postingIdx);
        }
    } else {
        recentPostings = [postingIdx];
    }

    setCookie("recentPostings", JSON.stringify(recentPostings), 7);
});
</script>
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
</body>
</html>