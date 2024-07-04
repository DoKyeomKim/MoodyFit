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
body {
    font-family: Arial, sans-serif;
    background-color: #f8f5f0;
    color: #333;
}
.main-header p a {
  
font-weight: lighter;
color: #888888;

    padding: 8px;
    text-decoration: none;
    margin-right: 3px;
    font-size: 13px;
    display: inline-block;
}

.main-header p a:hover,
.main-header p a:active,
.main-header p a:focus {
    background-color: #ddd;
    color: #000;
    text-decoration: underline;
}


.container {
    max-width: 1200px;
    margin: 0 auto;
}

.card {
    border: none;
    padding: 0;
    text-align: left;
    background-color: #fff;
    margin-bottom: 30px;
    position: relative;
}

.card img {
    width: 100%;
    height: auto;
}

.card-body {
    padding: 15px;
    position: relative;
}

.card-body span {
    display: block;
    margin-bottom: 5px;
}

.card-body .btn {
    padding: 10px 15px;
    font-size: 14px;
    border: none;
    position: absolute;
    bottom: 15px;
    right: 15px;
    background-color: transparent;
}

.card-body .btn svg {
    width: 25px;
    height: 25px;
}

.pagination {
    justify-content: center;
    margin-top: 30px;
}

.page-item.active .page-link {
    background-color: #000;
    border-color: #000;
}

.page-link {
    color: #000;
}

.page-link:hover {
    color: #fff;
    background-color: #000;
    border-color: #000;
}

svg {
    fill: none;
    stroke: #000;
    stroke-width: 2;
    stroke-linecap: round;
    stroke-linejoin: round;
}

.btn-outline-secondary:hover {
    background-color: #000;
    color: #fff;
}

.main-header {
    text-align: center;
    margin: 50px 0;
}

.main-header h1 {
    font-size: 2em;
    font-weight: bold;
    color: #333;
}

.main-header p {
    color: #999;
    margin-top: 10px;
}
</style>
</head>
<body style="background-color:#F6F4EE !important;">
	<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
	<%@include file="/WEB-INF/layouts/aside.jsp"%>
	<input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
	<main>
		<div class="container">
			<div class="main-header">
				<h3 style="font-weight:bold;">관심상품</h3>
				<p>  <a href="/myPage/payment">주문/배송조회</a>
         <a href="/myPage/cart">장바구니</a><a href="/myPage/wishList">좋아요</a></p>
			</div>
			<div class="row">
				<c:choose>
					<c:when test="${not empty wishList}">
						<c:forEach var="wishList" items="${wishList}">
							<div class="col-md-4">
								<div class="card">
									<img src="${wishList.FILE_PATH}" class="img-fluid">
									<div class="card-body">
										<span>${wishList.POSTING_IDX}</span>
										<span>가격 : ${wishList.PRICE}</span>
										<span>공고 제목	: ${wishList.TITLE}</span>
										<span>제조사: ${wishList.MANUFACTURE_NAME}</span>
										
											<button class="btn btn-outline-secondary wishBtn" style="margin-right: 5px;" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${wishList.POSTING_IDX}">
											    <svg width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
											        <path d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
											    </svg>
											</button>
									</div>
								</div>
							</div>
						</c:forEach>
						<nav aria-label="Page navigation" style="margin-top: 100px;">
							<ul class="pagination justify-content-center">
								<c:if test="${prev}">
									<li class="page-item"><a class="page-link"
										href="?page=${startPageNum - 1}" aria-label="Previous"> <span
											aria-hidden="true" class="fas fa-angle-left"></span>
									</a></li>
								</c:if>
								<c:forEach begin="${startPageNum}" end="${endPageNum}"
									var="page">
									<li class="page-item ${currentPage == page ? 'active' : ''}">
										<a class="page-link" href="?page=${page}">${page}</a>
									</li>
								</c:forEach>
								<c:if test="${next}">
									<li class="page-item"><a class="page-link"
										href="?page=${endPageNum + 1}"> <span aria-hidden="true"
											class="fas fa-angle-right"></span>
									</a></li>
								</c:if>
							</ul>
						</nav>
					</c:when>
					<c:otherwise>
						<h3 style="text-align: center; margin-top: 50px;">관심 상품이 없습니다!</h3>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
	</main>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
<script src="/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>
