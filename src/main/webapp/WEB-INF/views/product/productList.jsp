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

.w3-container {
    margin-top: 0px;
}

.table-container a {
    text-decoration: none; 
    color: inherit; 
}

.table-container a:hover {
    text-decoration: none;
}

.table-container a:hover .table {
    border: 2px solid lightgrey; 
    background-color: #f0f8ff;
}


.w3-bar {
    margin-bottom: 10px;
    margin-top: 100px;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

<div class="w3-container" style="margin-left:160px">
    <h3>상품 관리 리스트</h3>
</div>

<div class="w3-bar w3-black">
    <button class="w3-bar-item w3-button" onclick="openTab(event, 'productList')">상품관리 리스트</button>
    <button class="w3-bar-item w3-button" onclick="openTab(event, 'onHoldList')">보류 상태 상품 리스트</button>
</div>

<div id="productList" class="tab-content">
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all"></th>
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
            <tbody id="productListBody">
                <c:forEach var="product" items="${products}">
                <tr id="productRow_${product.PRODUCT_IDX}">
                    <td><input type="checkbox" class="select-item"></td>
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
                        <button class="btn btn-primary" onclick="editProduct(${product.PRODUCT_IDX})">수정</button>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="button-container">
            <a href="/storeMyPage/productWrite"><button>신규 상품 등록</button></a>
        </div>
    </div>
</div>

<div id="onHoldList" class="tab-content" style="display:none;">
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all-hold"></th>
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
                    <td><input type="checkbox" class="select-item"></td>
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
                        <button class="btn btn-primary" onclick="editProduct(${product.PRODUCT_IDX})">수정</button>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
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

document.getElementById('select-all').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.select-item');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

document.getElementById('select-all-hold').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.select-item');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

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
