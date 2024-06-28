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
        document.addEventListener('DOMContentLoaded', () => {
            fetchReviews();
        });

        function fetchReviews() {
            fetch('/api/reviews')
                .then(response => response.json())
                .then(data => {
                    renderReviews(data);
                })
                .catch(error => {
                    console.error('리뷰 데이터를 가져오는 데 문제가 발생했습니다:', error);
                });
        }

        function renderReviews(reviews) {
            const reviewList = document.getElementById('review-list');
            reviewList.innerHTML = '';

            reviews.forEach(review => {
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

                const reviewLikeCount = document.createElement('div');
                reviewLikeCount.className = 'review-like-count';
                reviewLikeCount.textContent = review.reviewLikeCount;

                const likeButton = document.createElement('button');
                likeButton.className = 'like-button';
                likeButton.textContent = '좋아요';
                likeButton.setAttribute('data-posting-review-idx', review.postingReviewIdx);
	
                const likeButtonSVG = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                likeButtonSVG.setAttribute('width', '24');
                likeButtonSVG.setAttribute('height', '24');
                likeButtonSVG.setAttribute('viewBox', '0 0 24 24');
                likeButtonSVG.setAttribute('fill', 'none');
                likeButtonSVG.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
                likeButtonSVG.innerHTML = `<path d="M12 21l-1-1.002M3 9.5a4 4 0 017.65-1.5l.35.5.35-.5A4 4 0 0121 9.5c0 5.5-9 10-9 10S3 15 3 9.5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>`;

                likeButton.appendChild(likeButtonSVG);
                reviewItem.appendChild(reviewHeader);
                reviewItem.appendChild(reviewOptions);
                reviewItem.appendChild(reviewContent);
                reviewItem.appendChild(reviewLikeCount);
                reviewItem.appendChild(likeButton);

                
                if (review.filePath) {
                    const reviewImage = document.createElement('img');
                    reviewImage.className = 'review-image';
                    reviewImage.src = review.filePath;
                    reviewImage.alt = review.filePath || 'Review Image';
                    reviewImage.onerror = function () {
                        console.error('Failed to load image:', review.filePath);
                    };
                    reviewItem.appendChild(reviewImage);
                }

                reviewList.appendChild(reviewItem);
            });

            updateLikesSvgs();
        }

        function updateLikesSvgs() {
            const userIdx = document.getElementById('userIdx').value;

            document.querySelectorAll('.like-button')
            .forEach(button => {
            	const postingReviewIdx = button.getAttribute('data-posting-review-idx');
                
            	console.log(postingReviewIdx)
                
                fetch(`/api/checkLikes?postingReviewIdx=`+postingReviewIdx+`&userIdx=`+userIdx, {
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
                        updateLikesSvgs();
                    } else {
                        throw new Error('오류 발생');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('오류가 발생했습니다. 다시 시도해주세요.');
                }
            }
        });
    </script>


</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
