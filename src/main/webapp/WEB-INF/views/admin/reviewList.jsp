<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 100vh;
           
        }

        .container {
            width: 100%;
            margin-top: 80px;
            font-size: 15px;
            flex-grow: 1; /* This will make the container grow to fill the available space */
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

        .filter-bar select,
        .filter-bar input[type="text"] {
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

        .review-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom:70px;
        }

        .review-item {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            width: calc(33.333% - 20px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
        }

        .review-header {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .review-header .details {
            font-size: 14px;
            margin-left: 10px;
        }

        .review-header .details div {
            margin-bottom: 5px;
        }

        .review-header .rating {
            font-size: 14px;
            color: #f1c40f;
            margin-left: auto;
        }

        .review-options {
            font-size: 12px;
            color: #888;
            margin: 10px 0;
        }

        .review-options span {
            display: inline-block;
            margin-right: 10px;
        }

        .review-stats {
            font-size: 15px;
            color: #a1a1a1;
            margin-top: 10px;
        }

        .review-content {
            font-size: 14px;
            margin: 10px 0;
        }

        .review-image {
            width: 100%;
            height: auto;
            margin-top: 10px;
        }
        
        .review-like-area{
        	margin-top : 10px;
        }
      
    </style>
</head>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<body>
	<input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
    <div class="container">
        <h1 class="head" style="font-size: 18px; margin-top: 30px;">PHOTO REVIEW | 포토 리뷰</h1>
        <div class="header"></div>
        <div class="filter-bar">
            <select id="category">
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

            <select id="sort">
                <option value="latest">최신순</option>
                <option value="rating">별점순</option>
                <option value="recommend">추천순</option>
            </select>

            <input type="text" id="search" placeholder="검색어 입력">
            <button type="button" onclick="searchReviews()">검색</button>
        </div>
        <div class="review-list" id="review-list"></div>
    </div>
 
<script>
let reviews = [];

document.addEventListener('DOMContentLoaded', () => {
    fetchReviews();
});

async function fetchReviews() {
    try {
        const response = await fetch('/api/reviews');
        if (!response.ok) {
            throw new Error(`네트워크 응답에 문제가 있습니다: ${response.statusText}`);
        }
        reviews = await response.json();
        console.log('Fetched Reviews:', reviews);
        renderReviews(reviews);
    } catch (error) {
        console.error('리뷰 데이터를 가져오는 데 문제가 발생했습니다:', error);
        alert('리뷰 데이터를 가져오는 데 문제가 발생했습니다. 네트워크 상태를 확인하고 다시 시도해주세요.');
    }
}

function renderReviews(reviews) {
    try {
        const reviewList = document.getElementById('review-list');
        reviewList.innerHTML = '';

        reviews.forEach(review => {
            console.log('Review Data:', review);

            const reviewItem = document.createElement('div');
            reviewItem.className = 'review-item';

            const reviewHeader = document.createElement('div');
            reviewHeader.className = 'review-header';

            const reviewDetails = document.createElement('div');
            reviewDetails.className = 'details';

            const reviewTitle = document.createElement('div');
            reviewTitle.style.fontWeight = 'bold';
            reviewTitle.textContent = review.title;

            const reviewStats = document.createElement('div');
            reviewStats.className = 'review-stats';
            reviewStats.innerHTML = review.height + ' cm | ' + review.weight + ' kg | ' + review.sizes + ' size | ' + review.foot + ' mm';

            reviewDetails.appendChild(reviewTitle);
            reviewDetails.appendChild(reviewStats);

            reviewHeader.appendChild(reviewDetails);

            const reviewRating = document.createElement('div');
            reviewRating.className = 'rating';
            reviewRating.textContent = '★'.repeat(review.rating);

            reviewHeader.appendChild(reviewRating);

            const colorSatisText = ['연해요', '똑같아요', '진해요'][review.colorSatis] || '정보 없음';
            const sizeSatisText = ['작아요', '잘 맞아요', '커요'][review.sizesSatis] || '정보 없음';

            const reviewOptions = document.createElement('div');
            reviewOptions.className = 'review-options';
            
            const colorSpan = document.createElement('span');
            colorSpan.textContent = '색상: ' + colorSatisText;

            const sizeSpan = document.createElement('span');
            sizeSpan.textContent = '사이즈: ' + sizeSatisText;

            reviewOptions.appendChild(colorSpan);
            reviewOptions.appendChild(document.createTextNode(' | '));
            reviewOptions.appendChild(sizeSpan);

            const reviewContent = document.createElement('div');
            reviewContent.className = 'review-content';
            reviewContent.textContent = review.content;

            const reviewLikeArea = document.createElement('div');
            reviewLikeArea.className = 'review-like-area';
            reviewLikeArea.style.display = 'flex';
            reviewLikeArea.style.justifyContent = 'center';
            reviewLikeArea.style.alignItems = 'center';
            
            const reviewLikeCount = document.createElement('div');
            reviewLikeCount.className = 'review-like-count';
            reviewLikeCount.textContent = review.reviewLikeCount;
            reviewLikeCount.style.marginRight = '5px';

            const likeButton = document.createElement('button');
            likeButton.className = 'btn btn-outline-secondary like-button';
            likeButton.style.marginRight = '5px';
            likeButton.setAttribute('data-posting-review-idx', review.postingReviewIdx);

            const likeButtonSVG = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            likeButtonSVG.setAttribute('width', '25px');
            likeButtonSVG.setAttribute('height', '25px');
            likeButtonSVG.setAttribute('viewBox', '0 0 24 24');
            likeButtonSVG.setAttribute('fill', 'none');
            likeButtonSVG.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
            likeButtonSVG.innerHTML = `
                <path fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" d="M12 6.00019C10.2006 3.90317 7.19377 3.2551 4.93923 5.17534C2.68468 7.09558 2.36727 10.3061 4.13778 12.5772C5.60984 14.4654 10.0648 18.4479 11.5249 19.7369C11.6882 19.8811 11.7699 19.9532 11.8652 19.9815C11.9483 20.0062 12.0393 20.0062 12.1225 19.9815C12.2178 19.9532 12.2994 19.8811 12.4628 19.7369C13.9229 18.4479 18.3778 14.4654 19.8499 12.5772C21.6204 10.3061 21.3417 7.07538 19.0484 5.17534C16.7551 3.2753 13.7994 3.90317 12 6.00019Z"/>
            `;
            
            likeButton.appendChild(likeButtonSVG);

            reviewLikeArea.appendChild(reviewLikeCount);
            reviewLikeArea.appendChild(likeButton);
            
            reviewItem.appendChild(reviewHeader);
            reviewItem.appendChild(reviewOptions);
            reviewItem.appendChild(reviewContent);

            if (review.filePath) {
                console.log('Image file exists:', review.filePath);
                const reviewImageArea = document.createElement('div');
                reviewImageArea.className = 'review-image-area';
                reviewImageArea.style.display = 'flex';
                reviewImageArea.style.justifyContent = 'center';
                reviewImageArea.style.alignItems = 'center';
                
                const reviewImage = document.createElement('img');
                reviewImage.className = 'review-image';
                reviewImage.src = review.filePath;
                reviewImage.alt = review.filePath || 'Review Image';
                reviewImage.style.width = 'auto';  // 원하는 너비로 설정
                reviewImage.style.height = '300px'; // 원하는 높이로 설정
                reviewImage.onerror = function() {
                    console.error('Failed to load image:', review.filePath);
                };
                reviewImageArea.appendChild(reviewImage);
                reviewItem.appendChild(reviewImageArea);
            }

            reviewList.appendChild(reviewItem);
            reviewItem.appendChild(reviewLikeArea);
        });
    } catch (error) {
        console.error('리뷰 리스트를 렌더링하는 도중 문제가 발생했습니다:', error);
        alert('리뷰 리스트를 렌더링하는 도중 문제가 발생했습니다.');
    }
    updateLikesSvgs();
}

function searchReviews() {
    try {
        const searchInput = document.getElementById('search').value.toLowerCase();
        const categoryInput = document.getElementById('category').value;
        const sortInput = document.getElementById('sort').value;

        let filteredReviews = reviews;

        if (categoryInput) {
            filteredReviews = filteredReviews.filter(review => review.category && review.category.toLowerCase().includes(categoryInput.toLowerCase()));
        }

        if (searchInput) {
            filteredReviews = filteredReviews.filter(review => 
                review.title.toLowerCase().includes(searchInput) || 
                review.content.toLowerCase().includes(searchInput) || 
                review.personIdx && review.personIdx.toString().toLowerCase().includes(searchInput)
            );
        }

        if (sortInput === 'rating') {
            filteredReviews = filteredReviews.sort((a, b) => b.rating - a.rating);
        } else if (sortInput === 'review-like-count') {
            filteredReviews = filteredReviews.sort((a, b) => b.reviewLikeCount  - a.reviewLikeCount);
        } else {
            filteredReviews = filteredReviews.sort((a, b) => new Date(b.createDate) - new Date(a.createDate));
        }

        renderReviews(filteredReviews);
    } catch (error) {
        console.error('리뷰 검색 및 필터링 도중 문제가 발생했습니다:', error);
    }
}

function updateLikesSvgs() {
    const userIdx = document.getElementById('userIdx').value;

    if (userIdx === null || userIdx === '') {
        // userIdx가 null이면 모든 버튼의 SVG fill을 'none'으로 설정
        document.querySelectorAll('.like-button svg path').forEach(svgPath => {
            svgPath.setAttribute('fill', 'none');
        });
        return; // 함수 종료
    }

    document.querySelectorAll('.like-button').forEach(button => {
        const postingReviewIdx = button.getAttribute('data-posting-review-idx');
        
        
        fetch(`/api/checkLikes?postingReviewIdx=` + postingReviewIdx + `&userIdx=` + userIdx, {
            method: 'GET',
        })
        .then(response => response.json())
        .then(isLiked => {
            button.setAttribute('data-liked', isLiked);
            const svg = button.querySelector('svg path');
            if (isLiked) {
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

document.addEventListener('click', async function (e) {
    const button = e.target.closest('.like-button');
    if (button) {
        e.preventDefault();
        e.stopPropagation();

        const postingReviewIdx = button.getAttribute('data-posting-review-idx');
        const isLiked = button.dataset.liked === 'true';
        const userIdx = document.getElementById('userIdx').value;

        try {
            let response;
            if (isLiked) {
                response = await fetch('/api/deleteLikes', {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ postingReviewIdx, userIdx }),
                });
            } else {
                response = await fetch('/api/addLikes', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ postingReviewIdx, userIdx }),
                });
            }

            if (response.ok) {
                const message = isLiked ? '좋아요가 취소되었습니다.' : '좋아요가 추가되었습니다.';
                alert(message);

                // 좋아요가 추가 또는 삭제된 후에 리뷰의 좋아요 수 업데이트
                const responseData = await response.json();
                const { success, reviewLikeCount } = responseData;

                if (success) {
                    const reviewLikeCountElem = button.parentElement.querySelector('.review-like-count');
                    reviewLikeCountElem.textContent = reviewLikeCount;
                    button.dataset.liked = !isLiked; // 좋아요 상태 반전
                    updateLikeButtonAppearance(button, !isLiked);
                } else {
                    throw new Error('좋아요 수 업데이트에 실패했습니다.');
                }
            } else {
                throw new Error('좋아요 요청에 실패했습니다.');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('좋아요 처리 중 오류가 발생했습니다. 다시 시도해주세요.');
        }
    }
});

function updateLikeButtonAppearance(button, isLiked) {
    const svg = button.querySelector('svg path');
    if (isLiked) {
        svg.setAttribute('fill', 'red'); // 좋아요 상태인 경우 빨간색으로 표시
    } else {
        svg.setAttribute('fill', 'none'); // 좋아요 상태가 아닌 경우 비워둠
    }
}
</script>

</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>