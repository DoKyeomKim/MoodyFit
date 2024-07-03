<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <script src="${pageContext.request.contextPath}/scripts.js"></script>
<style>
 .sidenav {
    float: left;
    width: 200px;
    height: auto;
    top: 0;
    left: 0;
    background-color: White;
    overflow-x: hidden;
    padding-top: 20px;
}
.sidenav.dark-mode {
    background-color: #444444;
    color: #fff;
}
/* Style the sidenav links and the dropdown button */
.sidenav a, .dropdown-btn {
    padding: 10px 15px;
    text-decoration: none;
    font-size: 15px;
    color: #818181;
    display: block;
    border: none;
    background: none;
    text-align: left;
    cursor: pointer;
    outline: none;
    transition: 0.3s;
}
.sidenav.dark-mode a, .sidenav.dark-mode .dropdown-btn {
    color: #fff;
}
/* On mouse-over */
.sidenav a:hover, .dropdown-btn:hover {
    color: #c0c0c0;
}

/* Main content */
.main {
    margin-left: 260px; /* Same as the width of the sidenav */
    font-size: 28px; /* Increased text to enable scrolling */
    padding: 0px 10px;
}

/* Add an active class to the active dropdown button */
.active {
    background-color: white;
    color: #c0c0c0;
}
.sidenav.dark-mode .active {
    background-color: #444;
    color: #c0c0c0;
}

/* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
.dropdown-container {
    display: none;
    background-color: #FFFFFF; /* White background for dropdown */
    padding-left: 8px;
}
.sidenav.dark-mode .dropdown-container {
    background-color: #444;
}

/* Optional: Style the caret down icon */
.fa-caret-down {
    float: right;
    padding-right: 8px;
}

/* Underline link on click */
.sidenav a:focus, .dropdown-btn:focus {
    text-decoration: underline;
}
</style>
<title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "기본 제목" %></title>
</head>
<body>

  <div class="sidenav">

    <button class="dropdown-btn">회원관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-container">
      <a href="adminPuser">개인회원</a>
      <a href="adminCuser">가맹점</a>
    </div>
     <button class="dropdown-btn">카테고리 관리 
      <i class="fa fa-caret-down"></i></button>
       <div class="dropdown-container">
    <a href="adminCategoryWrite">카테고리 등록</a>
    <a href="adminCategoryUpdate">카테고리 수정</a>

    </div>
    <a href="adminApply">가맹점 공고 관리</a>
    <a href="adminOrder">주문내역 관리</a>
    <a href="adminSales">판매수익 관리</a>
    <a href="adminReview">리뷰 관리</a>
    <a href="adminQnA">Q&A 관리</a>
     <button class="dropdown-btn">FAQ 관리 
      <i class="fa fa-caret-down"></i></button>
       <div class="dropdown-container">
    		<a href="adminFAQWrite">FAQ 등록</a>
    		<a href="adminFAQUpdate">FAQ 수정/삭제</a>
  		</div>
     <button class="dropdown-btn">에디터픽 
      <i class="fa fa-caret-down"></i></button>
       <div class="dropdown-container">
    		<a href="adminEditorPick">리스트 관리</a>
    		<a href="adminEPScrap">스크랩 관리</a>
  		</div>
  
    <script>
    const dropdownBtns = document.getElementsByClassName("dropdown-btn");
    for (let i = 0; i < dropdownBtns.length; i++) {
      dropdownBtns[i].addEventListener("click", function() {
        this.classList.toggle("active");
        const dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
          dropdownContent.style.display = "none";
        } else {
          dropdownContent.style.display = "block";
        }
      });
    }
  </script>
<script>
    // JavaScript 코드
    function toggleDropdown(event) {
        event.preventDefault(); // 기본 동작 방지 (링크 이동 방지)
        var dropdownContent = event.target.nextElementSibling;
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            dropdownContent.style.display = "block";
        }
    }
    

</script>
<script>
</script>
  </body>
</html>
