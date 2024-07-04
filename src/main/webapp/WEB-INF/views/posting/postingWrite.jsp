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
<script type="text/JavaScript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

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
</style>
</head>
<%@ include file="/WEB-INF/layouts/mypageheader.jsp" %>
<%@ include file="/WEB-INF/layouts/storeAside.jsp" %>
<body style="background-color:#F6F4EE !important;">
<main>
         <h3 style="font-weight:bold; text-align: center; ">판매글 등록</h3>
<div class="container">
    
    <!-- 상품 목록 -->
    <div class="product-selection">
        <label for="productSelect">판매 상품 선택:</label>
        <select id="productSelect" onchange="loadProductDetails(this.value)">
            <option value="">상품을 선택하세요</option>
            <c:forEach var="product" items="${products}">
                <option value="${product.PRODUCTIDX}">${product.NAME} - ${product.CATEGORY} / ${product.SUBCATEGORY}</option> 
            </c:forEach>
        </select>
    </div>

    <div id="productDetails">
    </div>

    <form method="post" enctype="multipart/form-data" action="/storeMyPage/postingWrite">
        <input type="hidden" id="productIdx" name="productIdx" value="">
        <div style="display:none;" id="productInfoIdx" name="productInfoIdx"></div>
       <div class="form-group">
    <label for="title">판매글 제목 : </label>
    <input type="text" id="title" name="title" class="form-control" required>
</div>
        
        <!-- 에디터 영역 -->
        <textarea id="summernote" name="editordata"></textarea>
        
                 <div class="button-container">
			         <button type="submit" class="apply-btn">등록</button>
                     <a href="/storeMyPage/postingList" class="cancel-btn">목록</a>
                 </div>
    </form>
</div>
</main>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
    // 상품 상세 정보 로드 관련
    function loadProductDetails(productIdx) {
    if (productIdx === "") {
        document.getElementById('productDetails').innerHTML = "";
        return;
    }

    console.log("Selected Product IDX:", productIdx);

    fetch('/storeMyPage/posting/getProductDetails?productIdx=' + productIdx)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log("Data received:", data);
            document.getElementById('productIdx').value = productIdx;

            const productInfoIds = data.map(item => item.productInfoIdx).join(', ');
            document.getElementById('productInfoIdx').textContent = productInfoIds;

            displayProductDetails(data);
        })
        .catch(error => console.error('Error fetching product details:', error));
		}
		
		function displayProductDetails(data) {
		    console.log("Data received:", data);
		    const detailsDiv = document.getElementById('productDetails');
		    let imagesHtml = '';
		
		    data.forEach(item => {
		        if (item.filePaths) {
		            imagesHtml += item.filePaths.split(', ').map(filePath => {
		                return '<img src="' + filePath + '" alt="' + item.name + 
		                '" style="width: 100px; height: 100px; object-fit: cover; margin: 5px;">';
		            }).join('');
		        }
		
		        detailsDiv.innerHTML += `
		            <h3>${item.name}</h3>
		            <p>가격: ${item.price} 원</p>
		            <p>색상: ${item.colors}</p>
		            <p>사이즈: ${item.sizes}</p>
		            <p>재고: ${item.quantities} 개</p>
		            <div class="images">${imagesHtml}</div>
		        `;
		        console.log("HTML set to:", detailsDiv.innerHTML);
		    });
		}
</script>

</body>
</html>
