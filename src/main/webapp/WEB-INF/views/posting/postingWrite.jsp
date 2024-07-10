<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css">
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<script type="text/JavaScript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
<script type="text/JavaScript" src="/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $('#summernote').summernote({
        height: 550,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR',
        placeholder: '게시글 작성',
        fontNames: ['맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
        fontNamesIgnoreCheck: ['맑은 고딕'],
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72']
    });
});
</script>

<style>

body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
    background-color: #F6F4EE;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
   
}

main {
    flex: 1;
    width: 70%;
    margin: 70px auto; /* 상단에 배치하기 위해 margin을 70px에서 20px로 수정 */
}

.container {
    margin-left: 160px; 
    padding: 16px;
    background-color: white;
    border: 1px solid #e2e2e2;

    
}
.product-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
.product-item {
    border: 1px solid #ddd;
    padding: 10px;
    cursor: pointer;
    width: 150px;
}
.product-item img {
    width: 100%;
    height: auto;
}
.product-item.selected {
    border-color: #007bff;
}
.details-container {
    margin-top: 20px;
}
.tab-content {
    display: none;
}
.tab-content.active {
    display: block;
}
.tab-nav {
    display: flex;
    cursor: pointer;
}
.tab-nav div {
    margin-right: 10px;
    padding: 10px;
    border: 1px solid #ddd;
}
.tab-nav div.active {
    background-color: #007bff;
    color: white;
}

.container {
    margin-top: 40px;
}
.apply-btn{
background-color: #333; /* 버튼 배경색 (어두운 회색) */
    color: white; /* 버튼 텍스트 색상 (흰색) */
    border: none; /* 버튼 테두리 없음 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    font-size: 16px; /* 버튼 글자 크기 */
    cursor: pointer; /* 마우스 커서 포인터 */
    text-align: center; /* 텍스트 가운데 정렬 */
    display: inline-block; /* 인라인 블록 요소 */
    border-radius: 5px; /* 버튼 모서리 둥글게 */
}
.button-container{
	margin-top:20px;
    display: flex;
    justify-content: right;
	gap:10px;
}
    
.product-selection{
	font-size:18px;
	padding:10px;
}
.form-group {
    display: flex;
    align-items: center;
    margin-top: 20px;
    font-size: 16px;
    margin-bottom: 20px;
    margin-right:50px;
    padding:10px;
}

.form-group label {
    flex: 0 0 150px; /* Adjust the width as needed */
    margin-bottom: 0;
}

.form-group input {
    flex: 1;
    border: none;
    border-bottom: 1px solid #e2e2e2;
    border-radius: 0;.
      text-align: left; /* Align text to the left */
    padding-left: 20px; /* Ensure there is no padding on the left */
}
.cancel-btn{
	background-color: white;
    color: black; /* 버튼 텍스트 색상 (흰색) */
    border: solid 1px black; /* 버튼 테두리 없음 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    font-size: 16px; /* 버튼 글자 크기 */
    cursor: pointer; /* 마우스 커서 포인터 */
    text-align: center; /* 텍스트 가운데 정렬 */
    display: inline-block; /* 인라인 블록 요소 */
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    text-decoration: none;
 }
     .product-pick-table {
        width: 100%;
        border-collapse: collapse;
    }
    .product-pick-table th, .product-pick-table td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    .product-pick-table th {
        background-color: #f2f2f2;
        text-align: center;
    }
    .product-pick-table tbody tr:hover {
        background-color: #f1f1f1;
        cursor: pointer;
    }
    .product-selection {
        margin-bottom: 20px;
    }
    #productDetails {
        margin-top: 20px;
    }
    .product-detail-area {
        max-width: 600px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        padding: 20px;
        margin-bottom:30px;
    }
    .product-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .product-price {
        font-size: 20px;
        color: #ff5722;
        margin-bottom: 15px;
    }
    .product-details {
        font-size: 16px;
        line-height: 1.5;
        color: #555;
    }
</style>
</head>
<%@ include file="/WEB-INF/layouts/mypageheader.jsp" %>
<%@ include file="/WEB-INF/layouts/storeAside.jsp" %>
<body>
    <main>
        <h3 style="font-weight:bold; text-align: center;">판매글 등록</h3>
        <div class="container">
            <!-- 상품 목록 -->
            <div class="product-selection">
                <label for="productSelect">판매 상품 선택:</label>
                <button type="button" id="product" class="btn btn-primary pick-product" data-bs-toggle="modal" data-bs-target="#pickModal">상품 선택</button>
            </div>
            <div id="productDetails"></div>
            <form method="post" enctype="multipart/form-data" action="/storeMyPage/postingWrite">
                <div class="form-group">
                    <label for="title">판매글 제목 : </label>
                    <input type="text" id="title" name="title" class="form-control" required>
                </div>
                <!-- 에디터 영역 -->
                <textarea id="summernote" name="editordata"></textarea>
                <div id="hiddenFieldsContainer"></div> <!-- 숨겨진 필드들이 삽입될 위치 -->
                <div class="button-container">
                    <button type="submit" class="apply-btn">등록</button>
                    <a href="/storeMyPage/postingList" class="cancel-btn">목록</a>
                </div>
            </form>
        </div>
    </main>

    <div class="modal fade" id="pickModal" tabindex="-1" aria-labelledby="pickModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content overflow-auto">
                <div class="modal-header">
                    <h5 class="modal-title" id="pickModalLabel">공고 선택</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="product-pick-table">
                        <thead>
                            <tr>
                                <th>선택</th>
                                <th>상품명</th>
                                <th>가격</th>
                                <th>색상,수량,갯수</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="productDetails" items="${productDetails}">
                            <tr class="productDetails">
                                <td>
                                    <input type="checkbox" class="productCheckbox" 
                                        data-info-idx="${productDetails.PRODUCTINFO_IDX}" 
                                        data-idx="${productDetails.PRODUCT_IDX}" 
                                        data-name="${productDetails.NAME}" 
                                        data-price="${productDetails.PRICE}" 
                                        data-details="${productDetails.COLORS}/${productDetails.SIZES}/${productDetails.QUANTITIES}개">
                                </td>
                                <td>${productDetails.NAME}</td>
                                <td>${productDetails.PRICE}</td>
                                <td>${productDetails.COLORS}/${productDetails.SIZES}/${productDetails.QUANTITIES}개</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="confirmSelectionBtn">선택 확인</button>
                </div>
            </div>
        </div>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('confirmSelectionBtn').addEventListener('click', function () {
        const selectedProductCheckboxes = document.querySelectorAll('.productCheckbox:checked');
        if (selectedProductCheckboxes.length > 0) {
            let productDetailsHTML = '<h5>선택된 상품</h5>';
            let hiddenFieldsHTML = '';
            selectedProductCheckboxes.forEach((checkbox, index) => {
            	const productInfoIdx = checkbox.getAttribute('data-info-idx');
            	const productIdx = checkbox.getAttribute('data-idx');
            	const productName = checkbox.getAttribute('data-name');
            	const productPrice = checkbox.getAttribute('data-price');
            	const productDetails = checkbox.getAttribute('data-details');

            	productDetailsHTML += `
            	    <div class="product-detail-area">
            	        <p class="product-name">상품명: ` + productName + `</p>
            	        <p class="product-price">가격: ` + productPrice + `</p>
            	        <p class="product-details">세부사항: ` + productDetails + `</p>
            	    </div>
            	`;

            	hiddenFieldsHTML += `
            	    <input type="hidden" name="productInfoIdx` + index + `" value="` + productInfoIdx + `">
            	    <input type="hidden" name="productIdx` + index + `" value="` + productIdx + `">
            	`;

            });

            document.getElementById('productDetails').innerHTML = productDetailsHTML;
            document.getElementById('hiddenFieldsContainer').innerHTML = hiddenFieldsHTML;

            // 모달 닫기
            const modal = bootstrap.Modal.getInstance(document.getElementById('pickModal'));

            // 모달 닫힘 이벤트 발생 시 처리
            modal._element.addEventListener('hidden.bs.modal', function () {
                document.querySelector('.btn-close').click();
            });

            modal.hide();
        } else {
            alert('상품을 선택해주세요.');
        }
    });
});
</script>
</body>
</html>
