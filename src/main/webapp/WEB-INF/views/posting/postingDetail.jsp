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
.container {
    max-width: 1200px;
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
    justify-content: space-between;
    margin-top: 20px;
}
.product-info, .purchase-info {
    flex: 1;
    padding: 10px;
}
.product-title {
    font-size: 24px;
    margin-bottom: 10px;
}
.product-content {
    margin-bottom: 20px;
}
.purchase-info {
    border: 1px solid #ddd;
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
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>

<div class="container">
    <!-- 상품 이미지 및 정보 -->
    <div class="product-details">
        <div class="product-info">
            <img src="${postingDetail.FILE_PATH}" alt="상품 이미지" class="product-image">
            <h2 class="product-title">${postingDetail.TITLE}</h2>
            <div class="product-content">
                ${postingDetail.CONTENT}
            </div>
        </div>
        <div class="purchase-info">
            <div class="purchase-options">
                <label for="color">색상</label>
                <select id="color" name="color">
                    <c:forEach var="color" items="${postingDetail.COLORS}">
                        <option value="${color.COLORS}">${color.COLORS}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="purchase-options">
                <label for="size">사이즈</label>
                <select id="size" name="size">
                    <c:forEach var="size" items="${postingDetail.SIZES}">
                        <option value="${size}">${size}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="price">${postingDetail.price} 원</div>
            <button class="buy-button">구매하기</button>
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
    <div class="tab-content">
        <p>${postingDetail.content}</p>
    </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    $('.tab').click(function() {
        var index = $(this).index();
        $('.tab').removeClass('active');
        $(this).addClass('active');
        $('.tab-content').hide();
        $('.tab-content').eq(index).show();
    });
});
</script>
</body>
</html>
