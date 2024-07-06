<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
    width: 50%;
    margin: 70px auto;
}

.container {
    padding: 16px;
    background-color: white;
    border: 1px solid #e2e2e2;
    margin-top: 40px;
}

.modal-dialog {
    max-width: 800px;
}

.modal-body {
    max-height: 400px;
    overflow: auto;
}

.modal-footer .d-flex {
    gap: 10px;
    justify-content: end;
}

#imagePreviewContainer {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
}

.image-preview {
    position: relative;
    width: 150px;
    height: 180px;
    margin: 10px;
}

.image-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.remove-button {
    position: absolute;
    top: 10px;
    right: -10px;
    background-color: red;
    color: white;
    border: none;
    cursor: pointer;
    padding: 2px 6px;
    font-size: 15px;
    border-radius: 0; /* 사각형 디자인 */
}

.remove-button:hover {
    background-color: #ffcccc;
}

.selected-item {
    color: blue;
    font-weight: bold;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 20px;
}

.button-container button,
.button-container a {
    padding: 10px 20px;
    font-size: 18px;
}

input[type="text"],
input[type="number"] {
    background-color: transparent;
    border: none;
    border-bottom: 1px solid #e2e2e2;
    border-radius: 0;
    padding: 10px 0;
    box-shadow: none;
    width: 100%;
}

input[type="text"]:focus,
input[type="number"]:focus {
    background-color: transparent;
    border-bottom: 1px solid #000;
    outline: none;
    box-shadow: none;
}

.select-btn {
    background-color: white;
    border: 1px solid #ccc;
    color: #000;
    font-size: 14px;
    padding: 10px 20px;
    cursor: pointer;
    display: inline-block;
    display: flex;
    writing-mode: horizontal-tb;
    justify-content: center;
    margin: 0 auto;
}

.select-btn:hover {
    background-color: #f0f0f0; 
    border-color: #b0b0b0; 
}

.form-group {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    font-size: 14px;
    color: #888888;
}

.form-group label {
    flex: 0 0 150px;
    margin-right: 10px;
    text-align: right;
}

.form-group input {
    flex: 1;
    background-color: transparent;
    border: none;
    border-bottom: 1px solid #e2e2e2;
    border-radius: 0;
    padding: 10px 0;
    box-shadow: none;
}

.form-group input:focus {
    background-color: transparent;
    border-bottom: 1px solid #000;
    outline: none;
    box-shadow: none;
}

.form-group button#addProductInfo {
    background-color: white;
    border: 1px solid #ccc;
    color: #000;
    font-size: 14px;
    padding: 10px 20px;
    cursor: pointer;
    display: block;
    margin: 0 auto;
    text-align: center;
}

.apply-btn {
    background-color: #333;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    text-align: center;
    display: inline-block;
    border-radius: 5px;
}

/* 모달 상단 X 버튼 제거 */
.modal-header .close {
    display: none;
}

/* 선택 부분 밑줄 제거 */
.table a {
    text-decoration: none;
}

/* 표 형식 간격 맞추기 */
#productInfoTable th, #productInfoTable td {
    padding: 10px; /* 간격 조정 */
    text-align: center; /* 텍스트 가운데 정렬 */
}
#productInfoTable td input[type="number"] {
    width: 60px;
    margin: 0 auto;
}
</style>
</head>
<%@ include file="/WEB-INF/layouts/storeAside.jsp"%>
<%@ include file="/WEB-INF/layouts/mypageheader.jsp"%>
<body style="background-color:#F6F4EE !important;">
<main>
    <h3 style="font-weight:bold; text-align: center;">상품 수정</h3>
    <div class="container">
        <form id="updateForm" action="${pageContext.request.contextPath}/storeMyPage/products/update" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productIdx" value="${productDetails.productIdx}">
            <div class="form-group">
                <label for="pname">상품명</label> 
                <input type="text" value="${productDetails.name}" class="form-control" id="pname" name="pname" readonly>
            </div>
    
            <div class="form-group">
                <label for="unitprice">상품 판매가</label>
                <input type="number" value="${productDetails.price}" class="form-control" id="unitprice" name="unitprice" min="0" required>
            </div>
    
            <div class="form-group">
                <label for="menufecturer">제조사</label>
                <input type="text" value="${productDetails.manufactureName}" class="form-control" id="menufecturer" name="manufactureName" readonly>
            </div>
    
            <div class="form-group">
                <label for="category">카테고리</label>
                <input type="text" value="${category} / ${subCategory}" class="form-control" id="categoryInput" name="category" readonly>
            </div>
    
            <div class="form-group">
                <table class="table" id="productInfoTable">
                    <thead>
                        <tr>
                            <th>색상</th>
                            <th>사이즈</th>
                            <th>재고</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="info" items="${productInfos}" varStatus="status">
                            <tr>
                                <td>${info.color}</td>
                                <td>${info.sizes}</td>
                                <td>
                                    <input type="number" name="productInfos[${status.index}].quantity" value="${info.quantity}" class="form-control" style="width: 60px; margin: 0 auto;">
                                    <input type="hidden" name="productInfos[${status.index}].productInfoIdx" value="${info.productInfoIdx}">
                                    <input type="hidden" name="productInfos[${status.index}].colorIdx" value="${info.productColorIdx}">
                                    <input type="hidden" name="productInfos[${status.index}].sizeIdx" value="${info.productSizeIdx}">
                                    <c:if test="${info.quantity == 0}">
                                        <span class="badge badge-danger">품절</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
    
            <div class="form-group text-center">
                <button type="button" id="addFileButton" class="select-btn">Image 추가</button>
                <input type="file" class="form-control" id="productImages" name="productImages" style="display: none;" multiple>
            </div>
            <div id="imagePreviewContainer" class="d-flex flex-wrap mt-2 justify-content-center">
                <c:forEach var="file" items="${productFiles}">
                    <div class="image-preview">
                        <img src="${file.filePath}" alt="${file.originalName}">
                        <button type="button" class="remove-button" data-file-idx="${file.productFileIdx}">&times;</button>
                    </div>
                </c:forEach>
            </div>
    
            <div class="button-container">
                <button type="submit" class="apply-btn">수정 완료</button>
                <a href="/storeMyPage/productList" class="btn btn-outline-dark">목록</a>
            </div>
        </form>
    </div>
</main>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.amazonaws.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
    document.getElementById('addFileButton').addEventListener('click', function() {
        document.getElementById('productImages').click();
    });

    document.getElementById('productImages').addEventListener('change', function(event) {
        handleFileSelect(event);
    });

    function handleFileSelect(event) {
        const files = event.target.files;
        const previewContainer = document.getElementById('imagePreviewContainer');
        previewContainer.innerHTML = ''; 

        for (let file of files) {
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.classList.add('image-preview');
                    
                    const removeButton = document.createElement('button');
                    removeButton.classList.add('remove-button');
                    removeButton.innerHTML = '&times;';
                    removeButton.addEventListener('click', function() {
                        img.remove();
                        removeButton.remove();
                    });

                    const previewWrapper = document.createElement('div');
                    previewWrapper.classList.add('image-preview');
                    previewWrapper.appendChild(img);
                    previewWrapper.appendChild(removeButton);
                    previewContainer.appendChild(previewWrapper);
                };
                reader.readAsDataURL(file);
            }
        }
    }

    $(document).on('click', '.remove-button', function() {
        const fileIdx = $(this).data('file-idx');
        $(this).closest('.image-preview').remove();
        $('<input>').attr({
            type: 'hidden',
            name: 'deleteFiles',
            value: fileIdx
        }).appendTo('#updateForm');
    });

    $('#updateForm').submit(function(event) {
        var quantities = document.querySelectorAll('input[name^="productInfos"][name$="quantity"]');
        for (var i = 0; i < quantities.length; i++) {
            if (quantities[i].value.trim() === "") {
                alert('재고를 작성해주세요.');
                return false;
            }
        }
        return true;
    });

    // 재고 0 밑으로 안 떨어지게
    document.querySelectorAll('input[name^="productInfos"][name$="quantity"]').forEach(input => {
        input.addEventListener('input', function() {
            if (this value < 0) {
                this.value = 0;
            }
        });

        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowDown' && this.value <= 0) {
                event.preventDefault();
            }
        });
    });
});
</script>
</body>
</html>
