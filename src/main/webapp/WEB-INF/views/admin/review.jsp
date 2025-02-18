<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .modal.right .modal-dialog {
            position: fixed;
            margin: auto;
            width: 90%;
            max-width: 400px;
            height: 100%;
            right: 0;
            top: 0; /* 화면에 딱 붙지 않게 */
        }
        .modal.right .modal-content {
            height: 100%;
            overflow: hidden;
        }
        .modal.right .modal-body {
            padding: 20px;
        }
        .modal-header {
            font-size: 15px;
            text-align: center;
            background-color: #e2e2e2;
            width: 100%;
            padding: 10px;
        }
        .input-group {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            width: 100%;
        }
        .input-group label {
            width: 20%;
            margin-bottom: 0;
            font-size: 16px;
            white-space: nowrap;
            text-align: center;
        }
        .input-group .input-wrapper {
            display: flex;
            align-items: center;
            width: 80%;
            border-radius: 4px;
            overflow: hidden;
            border: 1.5px solid #e2e2e2;
            background-color: transparent;
        }
        .input-group .input-wrapper input {
            flex: 1;
            padding: 8px;
            border: none;
            outline: none;
            font-size: 16px;
            color: #000;
            background-color: transparent;
        }
        .input-group .input-wrapper span {
            padding: 8px;
            font-size: 16px;
            color: #aaa;
        }
        .rating {
            display: flex;
            gap: 5px;
            justify-content: center;
            direction: rtl;
        }
        .rating input {
            display: none;
        }
        .rating label {
            font-size: 24px;
            color: #ddd;
            cursor: pointer;
            direction: ltr;
        }
        .rating input:checked ~ label {
            color: #f5b301;
        }
        .rating label:hover,
        .rating label:hover ~ label {
            color: #f5b301;
        }
        .button-group {
            text-align: right;
        }
        .button-group button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button-group button.submit {
            background-color: #007bff;
            color: #E5AAA3;
            border: 1.5px solid #E5AAA3;
        }
        .button-group button.cancel {
            background-color: #dc3545;
            color: #E5AAA3;
            margin-left: 10px;
            border: 1.5px solid #E5AAA3;
        }
        .open-modal-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #E5AAA3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            border: none; 
        }
        .open-modal-button:hover {
		    background-color: #E3AAA2;
		    color : #ccc;
        }
        
        
        .option-group {
            display: flex;
            align-items: center;
            justify-content: space-around;
            color: #e2e2e2;
            font-size: 14px;
        }
        .option-group button {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px 15px;
            border: 1.5px solid #E2e2e2;
            border-radius: 20px;
            cursor: pointer;
            background-color: #fff;
            color: #a0a0a0;
            height: 38px;
            margin-right: 10px;
        }
        .option-group button.active {
            border-color: #E5AAA3;
            color: #E5AAA3;
        }
        .input-group.no-border span,
        .input-group.no-border .input-wrapper input {
            border: none;
            background-color: transparent;
        }
        .input-group .centered-label {
            display: block;
            width: 100%;
            text-align: center;
            margin: 0 auto;
        }

        /* 오른쪽에서 왼쪽으로 나오는 애니메이션 */
        .modal.right.fade .modal-dialog {
            transform: translate3d(100%, 0, 0);
            transition: transform 0.3s ease-out;
        }
        .modal.right.fade.show .modal-dialog {
            transform: translate3d(0, 0, 0);
        }
    </style>
</head>
<body>

    <div class="modal fade right" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="reviewModalLabel">다른 회원님들께 구매후기를 전해주세요!</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                	<input type="hidden" name="postingIdx" value="${postingInfo.POSTING_IDX}">
                    <div class="input-group no-border">
                        <label for="height">상품명</label>
                        <div class="input-wrapper">
                            <input type="text" id="title" name="title" >
                        </div>
                    </div>
                    
                    <div class="input-group no-border">
                        <label for="height">키</label>
                        <div class="input-wrapper">
                            <input type="text" id="height" name="height" placeholder="0">
                            <span>cm</span>
                        </div>
                    </div>
                    <div class="input-group no-border">
                        <label for="weight">몸무게</label>
                        <div class="input-wrapper">
                            <input type="text" id="weight" name="weight" placeholder="0" >
                            <span>kg</span>
                        </div>
                    </div>
                    <div class="input-group no-border">
                        <label for="size">사이즈</label>
                        <div class="input-wrapper">
                            <input type="text" id="sizes" name="sizes" placeholder="00">
                            <span>size</span>
                        </div>
                    </div>
                    <div class="input-group no-border">
                        <label for="shoes-size">발사이즈</label>
                        <div class="input-wrapper">
                            <input type="text" id="foot"  name="foot" placeholder="0">
                            <span>mm</span>
                        </div>
                    </div>
                    <div class="input-group">
                        <label class="centered-label">상품은 만족하셨나요?</label>
                    </div>
                    <div class="rating" style="margin-bottom:20px;" >
                        <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
                        <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                        <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                        <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                        <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                    </div>
                    <div class="input-group">
                        <label class="centered-label"  >색상은 어떠셨나요?</label>
                    </div>
                    <div class="option-group" style="margin-bottom:20px;">
                        <button type="button" onclick="toggleActive(this)" name="color_satis" value="0">연해요</button>
                        <button type="button" onclick="toggleActive(this)" name="color_satis" value="1">똑같아요</button>
                        <button type="button" onclick="toggleActive(this)" name="color_satis" value="2">진해요</button>
                    </div>
                    <div class="input-group" style="margin-bottom:20px;">
                        <label class="centered-label">사이즈는 잘 맞으셨나요?</label>
                    </div>
                    <div class="option-group" style="margin-bottom:20px;">
                        <button type="button" onclick="toggleActive(this)" name="sizes_satis" value="0">작아요</button>
                        <button type="button" onclick="toggleActive(this)" name="sizes_satis" value="1">잘맞아요</button>
                        <button type="button" onclick="toggleActive(this)" name="sizes_satis" value="2">커요</button>
                    </div>
                    <div class="input-group">
                        <label for="content" >핏이나 만족감은 어떠세요?</label>
                    </div>
                    <div>
                        <textarea id="content" rows="4" placeholder="최소 10자 이상 입력해주세요" style="width:100%; height:55px;"></textarea>
                    </div>
                    <div class="input-group"style="margin-top:20px;">
                        <input type="file" id="file" name="file" class="form-control-file">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="submitReview()">리뷰 쓰기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function toggleActive(button) {
            var buttons = button.parentElement.getElementsByTagName('button');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }
            button.classList.add('active');
        }

        function submitReview() {
            var reviewDto = {
                title: document.getElementById('title').value,
                height: document.getElementById('height').value,
                weight: document.getElementById('weight').value,
                sizes: document.getElementById('sizes').value,
                foot: document.getElementById('foot').value,
                postingIdx: document.querySelector('input[name="postingIdx"]').value,
                rating: document.querySelector('input[name="rating"]:checked').value,
                colorSatis: document.querySelector('button[name="color_satis"].active').value,
                sizeSatis: document.querySelector('button[name="sizes_satis"].active').value,
                content: document.getElementById('content').value
            };
            var file = document.getElementById('file').files[0];

            var formData = new FormData();
            formData.append('reviewDto', new Blob([JSON.stringify(reviewDto)], { type: 'application/json' }));
            formData.append('file', file);

            fetch('/reviewWrite', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('리뷰가 성공적으로 제출되었습니다!');
                    $('#reviewModal').modal('hide');
                } else {
                    alert('리뷰 제출에 실패했습니다. 다시 시도해주세요.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 제출에 실패했습니다. 다시 시도해주세요.');
            });
        }
    </script>
</body>
</html>