<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<div class="w3-sidebar w3-bar-block w3-light-grey w3-card" style="width:160px;">
  <a href="#" class="w3-bar-item w3-button">Link 1</a>
  <button class="w3-button w3-block w3-left-align" onclick="toggleAccFunc('productAcc')">
    상품 관리 <i class="fa fa-caret-down"></i>
  </button>
  <div id="productAcc" class="w3-hide w3-white w3-card">
    <a href="#" class="w3-bar-item w3-button">상품 리스트</a>
    <a href="/storeMypage/productWrite" class="w3-bar-item w3-button">상품 등록</a>
    <a href="#" class="w3-bar-item w3-button">상품 신청 현황</a>
  </div>
  <button class="w3-button w3-block w3-left-align" onclick="toggleAccFunc('saleAcc')">
    판매 글 관리 <i class="fa fa-caret-down"></i>
  </button>
  <div id="saleAcc" class="w3-hide w3-white w3-card">
    <a href="#" class="w3-bar-item w3-button">판매 글 리스트</a>
    <a href="#" class="w3-bar-item w3-button">판매 글 등록</a>
    <a href="#" class="w3-bar-item w3-button">판매 글 신청 현황..?</a>
  </div>

  <a href="#" class="w3-bar-item w3-button">정보 수정</a>
  <a href="#" class="w3-bar-item w3-button">회원 탈퇴</a>
</div>

<div class="w3-container" style="margin-left:160px">
  <h3>가맹점 마이페이지 메인화면</h3>
</div>
<script src="/js/bootstrap.bundle.min.js"></script>
<script>
function toggleAccFunc(id) {
  var x = document.getElementById(id);
  
  // 모든 드롭다운 메뉴 닫기
  var dropdowns = document.getElementsByClassName("w3-hide");
  for (var i = 0; i < dropdowns.length; i++) {
    if (dropdowns[i].id !== id) {
      dropdowns[i].className = dropdowns[i].className.replace(" w3-show", "");
      if (dropdowns[i].previousElementSibling) {
        dropdowns[i].previousElementSibling.className = dropdowns[i].previousElementSibling.className.replace(" w3-green", "");
      }
    }
  }

  // 선택한 드롭다운 메뉴 상태 토글
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-green";
  } else {
    x.className = x.className.replace(" w3-show", "");
    x.previousElementSibling.className = x.previousElementSibling.className.replace(" w3-green", "");
  }
}
</script>



</body>
</html>