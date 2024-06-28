<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.fixed-sidebar {
    position: fixed;
    top: auto;
    left: 0;
    height: auto;
    width: 160px;
    overflow: auto;
    background-color: #F6F4EE !important;
    z-index: 1; 
    color:#867B73 !important;
    margin-top: 300px;
  }
 
.main-container {
  margin-left: 160px; 
  padding: 16px;
}

body, .w3-button, .w3-bar-item {
  font-family: 'Malgun Gothic', sans-serif;
  font-size: 16px;
}

</style>
</head>
<body>
<div class="fixed-sidebar w3-sidebar w3-bar-block w3-light-grey" style="width:160px;">
  <div style="margin-top :30px; font-weight : bold;" ></div>
  <button class="w3-button w3-block w3-left-align" onclick="toggleAccFunc('productAcc')">
    마이페이지 <i class="fa fa-caret-down"></i>
  </button>
  <div style="margin-top :30px;"></div>
  <button class="w3-button w3-block w3-left-align" onclick="toggleAccFunc('productAcc')">
    상품 관리 <i class="fa fa-caret-down"></i>
  </button>
  <div id="productAcc" class="w3-hide w3-white w3-card">
    <a href="/storeMyPage/productList" class="w3-bar-item w3-button">상품 리스트</a>
    <a href="/storeMyPage/productWrite" class="w3-bar-item w3-button">상품 등록</a>
  </div>
  <button class="w3-button w3-block w3-left-align" onclick="toggleAccFunc('saleAcc')">
    판매 글 관리 <i class="fa fa-caret-down"></i>
  </button>
  <div id="saleAcc" class="w3-hide w3-white w3-card">
    <a href="/storeMyPage/postingList" class="w3-bar-item w3-button">판매 글 리스트</a>
    <a href="/storeMyPage/postingWrite" class="w3-bar-item w3-button">판매 글 등록</a>
    <a href="#" class="w3-bar-item w3-button">판매 글 신청 현황..?</a>
  </div>

  <a href="/storeUpdateForm" class="w3-bar-item w3-button">정보 수정</a>

</div>
<script>
function toggleAccFunc(id) {
  var x = document.getElementById(id);
  
  // 모든 드롭다운 메뉴 닫기
  var dropdowns = document.getElementsByClassName("w3-hide");
  for (var i = 0; i < dropdowns.length; i++) {
    if (dropdowns[i].id !== id) {
      dropdowns[i].className = dropdowns[i].className.replace(" w3-show", "");
      if (dropdowns[i].previousElementSibling) {
        dropdowns[i].previousElementSibling.className = dropdowns[i].previousElementSibling.className.replace(" w3-lightgrey", "");
      }
    }
  }

  // 선택한 드롭다운 메뉴 상태 토글
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-lightgrey";
  } else {
    x.className = x.className.replace(" w3-show", "");
    x.previousElementSibling.className = x.previousElementSibling.className.replace(" w3-lightgrey", "");
  }
}
</script>
</body>
</html>