<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리 리스트</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.fixed-sidebar {
    position: fixed;
    top: auto;
    left: 0;
    height: 100%;
    width: 160px;
    overflow: auto;
    background-color: #f1f1f1;
    z-index: 1; 
  }
 
.main-container {
  margin-left: 160px; 
  padding: 16px;
}

.table-container {
    border: 2px solid grey; 
    padding: 10px;
    width: 75%;
    margin: auto;
}


.table {
    width: 100%;
    border-collapse: collapse;
}

.table th, .table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

.table th {
    background-color: #f4f4f4; 
    color: #333;
}

.table td img {
    width: 50px; 
    height: 50px;
    object-fit: cover;
}

.table tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
}

.table tbody tr:nth-child(even) {
    background-color: #fff;
}


.table th:first-child, .table td:first-child {
    width: 40px;
}


.button-container {
    text-align: right;
    margin-top: 10px;
}

.button-container button {
    background-color: grey; 
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    margin-left: 10px;
}

.button-container button:hover {
    background-color: #0056b3; 
}

.table th:nth-child(2), .table td:nth-child(2) {
    width: 60px; 
}

.table th:nth-child(3), .table td:nth-child(3) {
    width: 200px;
}

.table th:nth-child(4), .table td:nth-child(4) {
    width: 100px; 
}

.table th:nth-child(5), .table td:nth-child(5) {
    width: 150px; 
}

.table th:nth-child(6), .table td:nth-child(6) {
    width: 100px; 
}

.table th:nth-child(7), .table td:nth-child(7) {
    width: 100px; 
}

.table th:nth-child(8), .table td:nth-child(8) {
    width: 150px; 
}

.table th:nth-child(9), .table td:nth-child(9) {
    width: 150px; 
}

.table th:nth-child(10), .table td:nth-child(10) {
    width: 100px; 
}

.width  {
	width : 10px;
}

.table-container a {
    text-decoration: none; 
    color: inherit; 
}


.table-container {
	text-decoration: none;
}

.table-container a:hover {
	text-decoration: none;
}

.table-container a:hover .table {
    border: 2px solid lightgrey; 
    background-color: #f0f8ff; 
}


</style>

</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>


<div class="w3-container" style="margin-left:160px">
  <h3>상품 관리 리스트</h3>
</div>

<div class="table-container">
    <table class="table">
        <thead>
            <tr>
                <th><input type="checkbox" id="select-all"></th>
                <th style="width: 10px;">no</th>                
               	<th style="width: 50px;">사진</th>
                <th>상품명</th>
                <th>판매가</th>
                <th>분류</th>
                <th>재고</th>
                <th>수정일</th>
                <th>수정/삭제</th>
            </tr>
        </thead>
        <tbody>
       		<c:forEach var="product" items="${products }">
            <tr>
                <td><input type="checkbox" class="select-item"></td>
                <td style="width: 10px;">${product.PRODUCT_IDX}</td>
                	
                <td style="width: 50px;">
                  	<img src="${product.FILE_PATH}" >
                </td>
                <td>${product.NAME}</td>
                <td>${product.PRICE}</td>
                <td>${product.CATEGORY}/${product.SUB_CATEGORY}</td>
                <td>${product.INVENTORY}</td>
                <td>${product.UPDATE_DATE}</td>
                <td>
               		<button class="btn btn-primary" onclick="editProduct(${product.PRODUCT_IDX})">수정</button>
                	<button class="btn btn-danger" onclick="deleteProduct(${product.PRODUCT_IDX})">삭제</button>
                </td>
            </tr>
           </c:forEach>
        </tbody>
    </table>

    <div class="button-container">
        <a href="/storeMypage/productWrite"><button>신규 상품 등록</button></a>
        <a href="/storeMypage/productUpdate"><button>삭제</button></a>
    </div>
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

document.getElementById('select-all').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.select-item');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

</script>



</body>
</html>