<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리 리스트</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
    width: 80%; /* 기존 60%에서 80%로 수정 */
    margin: 70px auto;
}

.main-container {
    margin-left: 160px; 
    padding: 16px;
}

.table-container {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 20px;
    margin: 10px 0;
    align-items: center;
    background-color: #fff;
    font-size:14px;
   
}

.table {
    width: 100%;
    border-collapse: collapse;
       padding: 20px;
}

.table th, .table td {
    border: 1px solid #ddd;
 
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
    text-align: center; /* 중앙 정렬 추가 */
    margin-top: 10px;
    display: inline-block;
    vertical-align: top;
    margin-left: 10px;
}



.button-container {
        display: inline-block;
        vertical-align: top;
        margin-left: 10px;
        
    }
.delivery-btn:hover {
    text-decoration: underline;
}
.table-container a {
    text-decoration: none; 
    color: inherit; 
}
    .delivery-btn {
         background-color: transparent;
    color: #E5AAA3;
    cursor: pointer;
    border: none;
    font-size: 14px;
    text-decoration: none;
    margin-left: 5px;
}

.table-container a:hover {
    text-decoration: none;
}

.table-container a:hover .table {
    border: 2px solid lightgrey; 
    background-color: #f0f8ff;
}

h3 {
    text-align: left;
    margin-left: 30px;
    display: inline-block;
}
.edit-btn{
 padding: 10px 20px;
    font-size: 14px;
    border: none;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    border-radius: 10px !important;
}
.apply-btn{
 background-color: #f2eaeaa8;
            color: #B68555;
            border: 1px solid #B68555;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
       
}



</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>
<body style="background-color:#F6F4EE !important;">

<main>
    <div style="display: flex; align-items: center;">
        <h3 style="font-weight:bold;"> 상품 관리</h3>
    <div class="button-container">
        <button class="delivery-btn" onclick="openTab(event, 'productList')">상품관리 리스트</button>
        <button class="delivery-btn" onclick="openTab(event, 'onHoldList')">보류 상태 상품 리스트</button>
    </div>
    </div>

    <div id="productList" class="tab-content">
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr >
                        <th>no</th>
                        <th>사진</th>
                        <th>상품명</th>
                        <th>판매가</th>
                        <th>분류</th>
                        <th>재고</th>
                        <th>수정일</th>
                        <th>상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody id="productListBody">
                    <c:forEach var="product" items="${products}">
                    <tr id="productRow_${product.PRODUCT_IDX}">
                        <td>${product.PRODUCT_IDX}</td>
                        <td>
                            <c:choose>
                                <c:when test="${!empty product.FILE_PATHS}">
                                    <c:forEach var="filePath" items="${product.FILE_PATHS}">
                                        <img src="${filePath}" alt="product image" style="max-width: 100%; max-height: 50px;">
                                        <c:if test="${status.index == 0}">
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no_image.png" alt="no image available">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${product.NAME}</td>
                        <td>${product.PRICE}</td>
                        <td>${product.CATEGORY}/${product.SUB_CATEGORY}</td>
                        <td><c:out value="${product.INVENTORY}" escapeXml="false"/></td>
                        <td>${product.UPDATE_DATE}</td>
                        <td>
                            <select onchange="updateProductState(${product.PRODUCT_IDX}, this.value, 'productList')">
                                <option value="0" <c:if test="${product.STATE == 0}">selected</c:if>>상품등록완료</option>
                                <option value="1" <c:if test="${product.STATE == 1}">selected</c:if>>품절</option>
                                <option value="2" <c:if test="${product.STATE == 2}">selected</c:if>>상품 생산 중단</option>
                                <option value="3" <c:if test="${product.STATE == 3}">selected</c:if>>상품 불량품 발견</option>
                            </select>
                        </td>
                        <td>
                            <button class="edit-btn" onclick="editProduct(${product.PRODUCT_IDX})">수정</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="button-container">
                <a href="/storeMyPage/productWrite"><button class="apply-btn">신규 상품 등록</button></a>
            </div>
        </div>
    </div>

    <div id="onHoldList" class="tab-content" style="display:none;">
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>no</th>
                        <th>사진</th>
                        <th>상품명</th>
                        <th>판매가</th>
                        <th>분류</th>
                        <th>재고</th>
                        <th>수정일</th>
                        <th>상태</th>
                        <th>수정</th>
                    </tr>
                </thead>
                <tbody id="onHoldListBody">
                    <c:forEach var="product" items="${onHoldProducts}">
                    <tr id="productRow_${product.PRODUCT_IDX}">
                        <td>${product.PRODUCT_IDX}</td>
                        <td>
                            <c:choose>
                                <c:when test="${!empty product.FILE_PATHS}">
                                    <c:forEach var="filePath" items="${product.FILE_PATHS}">
                                        <img src="${filePath}" alt="product image" style="max-width: 100%; max-height: 50px;">
                                        <c:if test="${status.index == 0}">
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no_image.png" alt="no image available">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${product.NAME}</td>
                        <td>${product.PRICE}</td>
                        <td>${product.CATEGORY}/${product.SUB_CATEGORY}</td>
                        <td><c:out value="${product.INVENTORY}" escapeXml="false"/></td>
                        <td>${product.UPDATE_DATE}</td>
                        <td>
                            <select onchange="updateProductState(${product.PRODUCT_IDX}, this.value, 'onHoldList')">
                                <option value="0" <c:if test="${product.STATE == 0}">selected</c:if>>상품등록완료</option>
                                <option value="1" <c:if test="${product.STATE == 1}">selected</c:if>>품절</option>
                                <option value="2" <c:if test="${product.STATE == 2}">selected</c:if>>상품 생산 중단</option>
                                <option value="3" <c:if test="${product.STATE == 3}">selected</c:if>>상품 불량품 발견</option>
                            </select>
                        </td>
                        <td>
                            <button class="edit-btn" onclick="editProduct(${product.PRODUCT_IDX})">수정</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>


    <%@include file="/WEB-INF/layouts/footer.jsp"%>

<script>
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}


function editProduct(productIdx) {
    window.location.href = "/storeMyPage/updateForm?productIdx=" + productIdx;
}

function updateProductState(productIdx, state, tabId) {
    $.ajax({
        url: '/storeMyPage/updateProductState',
        type: 'POST',
        data: {
            productIdx: productIdx,
            state: state
        },
        success: function(response) {
            var row = $('#productRow_' + productIdx);
            row.fadeOut(400, function() {
                row.remove();
                if (state == 0) {
                    $('#productListBody').append(row);
                } else {
                    $('#onHoldListBody').append(row);
                }
                row.fadeIn(400);
            });
        },
        error: function(xhr, status, error) {
            console.error('Failed to update product state:', error);
        }
    });
}

</script>
</body>
</html>
