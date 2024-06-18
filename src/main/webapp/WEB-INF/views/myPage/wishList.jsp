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
	<input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
	<main>
		<div class="container">
			<div class="row">

						<c:forEach var="wishList" items="${wishList}">
							<div class="col-3">
								<div class="card">
									<img src="${wishList.FILE_PATH}" class="img-fluid">
									<div class="card-body">
										<span>${wishList.POSTING_IDX}</span><br> 
										<span>제조사: ${wishList.MANUFACTURE_NAME}</span><br> 
										<span>공고 제목	: ${wishList.TITLE}</span><br> 
										<span>가격 :${wishList.PRICE}</span>
										
											<button class="btn btn-outline-secondary wishBtn" style="margin-right: 5px;" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${wishList.POSTING_IDX}">
											    <svg width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
											        <path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
											    </svg>
											</button>
									</div>
								</div>
							</div>
						</c:forEach>

			</div>
		</div>
	</main>



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
