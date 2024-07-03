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
    margin-top: 150px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/layouts/header.jsp" %>
<%@ include file="/WEB-INF/layouts/storeAside.jsp" %>

<div class="container">
    <h3>판매글 등록</h3>
    
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
            <label for="title">판매글 제목</label>
            <input type="text" id="title" name="title" class="form-control" required>
        </div>
        
        <!-- 에디터 영역 -->
        <textarea id="summernote" name="editordata"></textarea>
        
        
        <button type="submit" class="btn btn-primary">등록</button>
    </form>
</div>

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
