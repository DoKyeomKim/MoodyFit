<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mypagestyle.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<style>
#person-level{
margin-left:10px;
}
.row {
	display:flex;
	justify-content: center;
	align-items: center;
}
.modal-btn{
	border : none;
	background-color: transparent; 
	padding: 0;
}
.person-level-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 18px;
    text-align: left;
}
.person-level-table thead tr {
    background-color: black;
    color: #ffffff;
    text-align: left;
}
.person-level-table th, .person-level-table td {
    padding: 12px 15px;
    border: 1px solid #dddddd;
}
.person-level-table tbody tr:nth-child(even) {
    background-color: #f3f3f3;
}
.posting-info {
    transition: background-color 0.3s;
}
.level-img{
	height: 40px;
	width: auto;
	margin-right : 15px;
}
.person-level-name{
	display:flex;
	align-items: center;
}
.wishBtn{
	border:none;
	background-color : transparent;
}
.all-posting {
    text-align: left;
    margin: 20px;
    border: 0.5px solid #ccc;
    padding: 15px;
    border-radius: 5px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
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

.cookie-container{
	display:flex;
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
.swiper-button-prev, .swiper-button-next {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    color:black;
    z-index: 10;
    padding: 10px;
    border-radius: 50%;
    cursor: pointer;
}

.swiper-button-prev {
    left: 2px;
}

.swiper-button-next {
    right: 2px;
}

.recent-views {
    position: relative;
}
.deleteBtn {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: #ff5c5c;
    color: white;
    border: none;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.deleteBtn:hover {
    background-color: #ff1c1c;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>
    <main>
    <input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h2 style="text-align: center; font-size: 35px; font-weight: 600; color: #867B73;">마이페이지</h2>
            </div>
        </div>
        
        <div class="row profile-section mt-4">
            <div class="col-6 profile-info">
                <h2>${person.nickName}님</h2>
                <button type="button" class="modal-btn" data-bs-toggle="modal" data-bs-target="#levelModal">
                <img src="/images/${levelName}.png" id="person-level">
                </button>
                
            </div>
            <div class="col-3 profile-stats text-right">
                <ul>
                    <li><a href="/myPage/order" style="text-decoration: none; color:#867B73;">총 결제금액 <span class="userTotalPurchase">${price.SUM_PRICE }</span></a></li>
                    <li><a href="/myPage/cart" style="text-decoration: none; color:#867B73;">장바구니 <span>${cartCount }</span>개</a></li>
                </ul>
            </div>
        </div>
        
        <div class="row order-status mt-4">
            <div class="col-12">
                <div class="status-box">
                    <div class="row">
                        <div class="col text-center">
                            <h3>배송준비중</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderPrePare}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderPrePare}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <h3>배송중</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderIng}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderIng}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <h3>배송완료</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderDone}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderDone}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <ul>
                                <li>취소: 0</li>
                                <li>교환: 1</li>
                                <li>환불: 3</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
		<div class="row mt-5 recent-views">
		    <div class="col-12">
		        <h2>최근 본 공고</h2>
		        <div class="swiper-container">
		            <div class="swiper-wrapper cookie-container"></div>
		        </div>
		        <div class="swiper-button-prev"></div>
		        <div class="swiper-button-next"></div>
		    </div>
		</div>


<div class="modal fade" id="levelModal" tabindex="-1" aria-labelledby="levelModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl"> <!-- modal-xl로 변경 -->
    <div class="modal-content overflow-auto">
      <div class="modal-header">
        <h5 class="modal-title" id="levelModalLabel">공고 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="person-level-table">
            <thead>
                <tr>
                    <th>등급</th>
                    <th>가격</th>
                    <th>할인율</th>
                </tr>
            </thead>
            <tbody>
                    <c:forEach var="personLevel" items="${personLevel}">
	                    <tr class="posting-info">
	                        <td><span class="person-level-name"><img src="/images/${personLevel.name }.png" class="level-img" alt="level-img">${personLevel.name }</span></td>
        					<td><span class="purchase">${personLevel.purchase}원 이상</span></td>
	                        <td>${Math.round(personLevel.benefit * 100)}%</td>
	                    </tr>
                    </c:forEach>
            </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</div>
</main>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.add('loaded');

});
</script>
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

    async function deletePosting(postingIdx, userIdx) {
        let recentPostings = getCookie("recentPostings");
        if (recentPostings) {
            recentPostings = JSON.parse(recentPostings);
            const index = recentPostings.indexOf(postingIdx.toString());
            if (index > -1) {
                recentPostings.splice(index, 1);
                setCookie("recentPostings", JSON.stringify(recentPostings), 7);

                // Remove the posting from the DOM
                const postingElement = document.getElementById(`posting-${postingIdx}`);
                if (postingElement) {
                    postingElement.remove();
                }

                // Re-fetch the recent postings list
                await fetchRecentPostings(userIdx);
            }
        }
    }

    async function fetchRecentPostings(userIdx) {
        try {
            const response = await fetch('/myPage/recentPostings', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            const data = await response.json();
            renderRecentPostings(data, userIdx);
        } catch (error) {
            console.error('Error:', error);
        }
    }

    function renderRecentPostings(postings, userIdx) {
        const container = document.querySelector('.cookie-container');
        container.innerHTML = '';  // 기존 내용 제거
        postings.forEach(posting => {
            const postingElement =
                '<div class="swiper-slide col-md-3 mt-3 mb-3 all-posting-area" id="posting-' + posting.POSTING_IDX + '">' +
                    '<div class="all-posting">' +
                        '<a class="text-decoration-none text-dark" href="/postingDetail?postingIdx=' + posting.POSTING_IDX + '">' +
                            '<div class="all-post-image">' +
                                '<img src="' + posting.FILE_PATH + '" class="img-fluid" alt="' + posting.TITLE + '">' +
                            '</div>' +
                            '<div class="post-header">' +
                                '<div class="all-post-title">' + posting.TITLE + '</div>' +
                                '<div class="all-post-wish">' +
                                    '<security:authorize access="hasRole(\'ROLE_PERSON\')">' +
                                        '<button class="wishBtn" data-user-idx="' + userIdx + '" data-posting-idx="' + posting.POSTING_IDX + '">' +
                                            '<svg style="margin-top: 10px;" width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
                                                '<path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>' +
                                            '</svg>' +
                                        '</button>' +
                                    '</security:authorize>' +  
                                '</div>' +
                            '</div>' +
                            '<div class="all-post-info">' +
                                '<div class="all-price">' + posting.PRICE + '원</div>' +
                                '<div class="all-store-name">' + posting.STORE_NAME + '</div>' +
                            '</div>' +
                        '</a>' +
                        '<button class="deleteBtn" onclick="deletePosting(' + posting.POSTING_IDX + ', ' + userIdx + ')">X</button>' +
                    '</div>' +
                '</div>';
            container.innerHTML += postingElement;
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const userIdxElement = document.getElementById('userIdx');
        if (userIdxElement) {
            const userIdx = userIdxElement.value;
            fetchRecentPostings(userIdx);

            // Swiper 초기화
			var mySwiper = new Swiper('.swiper-container', {
			    loop: false, // 무한 반복 설정 해제
			    slidesPerView: 4, // 슬라이드를 자동으로 조정
			    spaceBetween: 20, // 슬라이드 간의 간격 설정
			    navigation: {
			        nextEl: '.swiper-button-next', // 다음 버튼 클래스 설정
			        prevEl: '.swiper-button-prev', // 이전 버튼 클래스 설정
			    },
			    pagination: {
			        el: '.swiper-pagination', // 페이지네이션 클래스 설정
			        clickable: true, // 페이지네이션 클릭 가능 여부 설정
			    },
			    on: {
			        reachEnd: function() {
			            setTimeout(() => {
			                mySwiper.slideTo(0, 0); // 맨 끝에 도달하면 처음 슬라이드로 이동
			            }, 0); // 딜레이 없이 바로 이동
			        }
			    }
            });
        } else {
            console.error('userIdx element not found');
        }
    });
</script>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        var purchaseElements = document.querySelectorAll(".purchase");
        var userTotalPurchaseElements = document.querySelectorAll(".userTotalPurchase");

        purchaseElements.forEach(function(purchaseElement) {
            var purchaseText = purchaseElement.textContent.trim();
            var purchaseValue = parseFloat(purchaseText.replace(/[^\d.-]/g, ''));
            var formattedPurchase = purchaseValue.toLocaleString("ko-KR");
            purchaseElement.textContent = formattedPurchase + "원 이상";
        });
        userTotalPurchaseElements.forEach(function(userTotalPurchaseElements) {
            var userTotalPurchaseText =  userTotalPurchaseElements.textContent.trim();
            var userTotalPurchaseValue = parseFloat(userTotalPurchaseText.replace(/[^\d.-]/g, ''));
            var formattedUserTotalPurchaseText = userTotalPurchaseValue.toLocaleString("ko-KR");
            userTotalPurchaseElements.textContent = formattedUserTotalPurchaseText + " 원";
        });
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
   <%@include file="/WEB-INF/layouts/footer.jsp"%>
</body>	
</html>
