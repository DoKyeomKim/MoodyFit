<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
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
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

<div class="container">
    <h3>판매글 등록</h3>
    
    <!-- 상품 목록 -->
    <div class="product-list">
    <c:forEach var="product" items="${products}">
        <div class="product-item" onclick="selectProduct(${product.PRODUCTIDX})" id="product-${product.PRODUCTIDX}">
            <img src="${product.FILEPATHS}" alt="${product.NAME}">
            <p>${product.NAME}</p>
            <p>${product.PRICE} 원</p>
            <p>색상: ${product.COLOR}</p>
            <p>사이즈: ${product.SIZES}</p>
            <p>재고: ${product.QUANTITY} 개</p>
        </div>
    </c:forEach>
		</div>

    <!-- 선택한 상품 상세 정보 -->
    <div class="details-container">
        <h4>선택한 상품 정보</h4>
        <form action="/storeMyPage/postingWrite" method="post" enctype="multipart/form-data">
            <input type="hidden" id="selectedProductIdx" name="productIdx">
            
            <div class="form-group">
                <label for="title">판매글 제목</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="content">판매글 내용</label>
                <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="postingFile">판매글 이미지</label>
                <input type="file" id="postingFile" name="postingFile" class="form-control" multiple>
            </div>
            
            <button type="submit" class="btn btn-primary">등록</button>
        </form>
        
        <!-- 상품 상세 정보, 사이즈, 후기, Q&A 탭 -->
        <div class="tabs">
            <div class="tab-nav">
                <div class="tab-link active" data-tab="details">상세정보</div>
                <div class="tab-link" data-tab="sizes">사이즈</div>
                <div class="tab-link" data-tab="reviews">후기</div>
                <div class="tab-link" data-tab="qna">Q&A</div>
            </div>
            <div class="tab-content active" id="details">
                <p>상품 상세 정보 표시</p>
            </div>
            <div class="tab-content" id="sizes">
                <p>상품 사이즈 정보 표시</p>
            </div>
            <div class="tab-content" id="reviews">
                <p>상품 후기</p>
            </div>
            <div class="tab-content" id="qna">
                <p>상품 Q&A</p>
            </div>
        </div>
    </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
<script>
	
function selectProduct(productIdx) {
    console.log('Selected Product ID:', productIdx);

    if (typeof productIdx === 'undefined' || productIdx === null) {
        console.error('productIdx is not defined');
        return;
    }

    // 모든 product-item 요소에서 selected 클래스를 제거
    document.querySelectorAll('.product-item').forEach(item => {
        item.classList.remove('selected');
    });

    // 선택된 product-item 요소에 selected 클래스를 추가
    var selectedElement = document.getElementById('product-' + productIdx);
    if (selectedElement) {
        selectedElement.classList.add('selected');
    } else {
        console.error('No element found with ID: product-' + productIdx);
    }

    // 선택된 상품의 상세 정보를 처리하는 추가 코드 (필요한 경우)
    document.getElementById('selectedProductIdx').value = productIdx;
}

		
		// ===============================================================
		// ================ 하단 상세정보 부분 ===========================
    // 탭 전환 로직
    document.querySelectorAll('.tab-link').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.tab-link').forEach(item => {
                item.classList.remove('active');
            });
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            this.classList.add('active');
            document.getElementById(this.dataset.tab).classList.add('active');
        });
    });
</script>


</body>
</html>