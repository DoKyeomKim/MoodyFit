<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 상세보기</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
/* 기본 스타일 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}
.posting-container {
    max-width: 1500px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
}
.product-image {
    width: 100%;
    max-width: 400px;
    height: auto;
}
.product-details {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
}
.product-image{
	height : 100%;
	width : 100%;
}
.product-title {
    font-size: 24px;
    margin-bottom: 10px;
}
.product-content {
    margin-bottom: 20px;
}
.purchase-info {
    padding: 20px;
}
.purchase-options {
    margin-bottom: 10px;
    
}
.purchase-options select, .purchase-options input {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
}
.price {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}
.buy-button {
    display: block;
    width: 100%;
    padding: 15px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border: none;
    cursor: pointer;
    font-size: 16px;
}
.tabs {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    border-top: 1px solid #ddd;
    padding-top: 10px;
}
.tab {
    flex: 1;
    text-align: center;
    padding: 10px;
    cursor: pointer;
    border-bottom: 2px solid transparent;
}
.tab.active {
    border-bottom: 2px solid #333;
    font-weight: bold;
}
.tab-content {
    margin-top: 20px;
}
.posting-info-area{
	width : 45%;
	margin-left: 100px;
}
.product-info {
    display: flex;
    justify-content: center;
    align-items: center; /* 수직 중앙 정렬을 원할 경우 추가 */
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<main>
<div class="posting-container">
    <!-- 상품 이미지 및 정보 -->
    <div class="product-details">
        <div class="product-info">
            <img src="${postingInfo.PRODUCT_FILE}" alt="상품 이미지" class="product-image">
        </div>
        <div class="posting-info-area">
            <h2 class="product-title" style="margin-left:20px;">${postingInfo.TITLE}</h2>
            <form action="/postingBuy" method="POST">
                <div class="purchase-info">
                    <div class="purchase-options">
                        <label for="color">색상</label>
                        <select id="color" name="color" onchange="updateSizes()">
                            <c:forEach var="color" items="${colors}">
                                <option value="${color}">${color}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="purchase-options">
                        <label for="size">사이즈</label>
                        <select id="size" name="size" onchange="updateProductInfo()">
                            <!-- 사이즈 옵션은 JavaScript로 동적으로 생성 -->
                        </select>
                    </div>
                    <div class="price">${postingInfo.PRICE} 원</div>
                    <input type="hidden" id="product_info_idx" name="product_info_idx">
                    <input type="hidden" id="posting_product_idx" name="posting_product_idx">
                    <button type="submit" class="buy-button">구매하기</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 상품 추가 정보 탭 -->
    <div class="tabs">
        <div class="tab active">상세정보</div>
        <div class="tab">사이즈</div>
        <div class="tab">상품후기</div>
        <div class="tab">상품문의</div>
    </div>
    
    <!-- 탭 내용 -->
    <div class="tab-content" style="text-align:center;">
        ${content}
    </div>
</div>
</main>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    updateSizes();
    updateProductInfo();
    
    $('.tab').click(function() {
        var index = $(this).index();
        $('.tab').removeClass('active');
        $(this).addClass('active');
        $('.tab-content').hide();
        $('.tab-content').eq(index).show();
    });
});

function updateSizes() {
    var color = $('#color').val();
    var sizeSelect = $('#size');
    sizeSelect.empty();

    var colorSizeMap = JSON.parse('${colorSizeMap}');
    var sizes = colorSizeMap[color];
    if (sizes) {
        for (var size in sizes) {
            var option = $('<option></option>').attr('value', size).text(size);
            sizeSelect.append(option);
        }
    }

    // Update the product_info_idx and posting_product_idx after updating sizes
    updateProductInfo();
}

function updateProductInfo() {
    var color = $('#color').val();
    var size = $('#size').val();
    var colorSizeMap = JSON.parse('${colorSizeMap}');
    
    if (colorSizeMap[color] && colorSizeMap[color][size]) {
        $('#product_info_idx').val(colorSizeMap[color][size].product_info_idx);
        $('#posting_product_idx').val(colorSizeMap[color][size].posting_product_idx);
    } else {
        $('#product_info_idx').val('');
        $('#posting_product_idx').val('');
    }
}
</script>
</body>
</html>