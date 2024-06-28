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
.modal-dialog {
    max-width: 800px;
}

.modal-body {
    max-height: 400px;
    overflow: auto;
}

.w3-container {    
    margin-top: 100px;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}

.button-container button,
.button-container a {
    padding: 10px 20px;
    font-size: 18px;
}

.image-preview {
    position: relative;
    display: inline-block;
    margin: 5px;
}

.image-preview img {
    width: 80px; /* 이미지 크기 조정 */
    height: 100px;
    object-fit: cover;
}

.remove-button {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    padding: 2px 6px;
    font-size: 12px;
}

</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

<div class="w3-container" style="margin-left: 160px">
    <div class="container">
        <h3>상품 수정</h3>
        
        <form id="updateForm" action="${pageContext.request.contextPath}/storeMyPage/products/update" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productIdx" value="${productDetails[0].productIdx}">
        
            <div class="form-group">
                <label for="pname">상품명</label> 
                <input type="text" value="${productDetails['NAME']}" class="form-control" id="pname" name="pname" readonly>
            </div>
    
            <div class="form-group">
                <label for="unitprice">상품 판매가</label>
                <input type="number" value="${productDetails['PRICE']}" class="form-control" id="unitprice" name="unitprice" min="0" required>
            </div>
    
            <div class="form-group">
                <label for="menufecturer">제조사</label>
                <input type="text" value="${productDetails['MANUFACTURENAME']}" class="form-control" id="menufecturer" name="manufactureName" readonly>
            </div>
    
            <div class="form-group">
                <label for="category">카테고리</label>
                <input type="text" value="${productDetails['CATEGORY']}/${productDetails['SUBCATEGORY']}" class="form-control" id="categoryInput" name="category" readonly>    
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
                                <td>${info['color']}</td>
                                <td>${info['sizes']}</td>
                                <td>
                                    <input type="number" name="productInfos[${status.index}].quantity" value="${info['quantity']}" class="form-control">
                                    <input type="hidden" name="productInfos[${status.index}].productInfoIdx" value="${info['productInfoIdx']}">
                                    <input type="hidden" name="productInfos[${status.index}].colorIdx" value="${info['productColorIdx']}">
                                    <input type="hidden" name="productInfos[${status.index}].sizeIdx" value="${info['productSizeIdx']}">
                                    <c:if test="${info['quantity'] == 0}">
                                        <span class="badge badge-danger">품절</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="form-group">
						    <label for="productImages"></label> 
						    <button type="button" id="addFileButton" class="btn btn-secondary mt-2">Image 추가</button>
						    <input type="file" class="form-control" id="productImages" name="productImages" style="display: none;" multiple>
						    <div id="imagePreviewContainer" class="d-flex flex-wrap mt-2"></div>
						    <c:forEach var="file" items="${productFiles}">
						        <div>
						            <img src="${file.filePath}" alt="${file.originalName}" width="50">
						            <input type="checkbox" name="deleteFiles" value="${file.productFileIdx}"> 삭제
						        </div>
						    </c:forEach>
						</div>


            <div class="button-container">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="/storeMyPage/productList" class="btn btn-outline-dark">목록</a>
            </div>
        </form>
    </div>
</div>


<script src="/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>

// ===================================================================================
// ===============================  스크립트 =========================================
    
    function toggleAccFunc(id) {
        var x = document.getElementById(id);

        // 모든 드롭다운 메뉴 닫기
        var dropdowns = document.getElementsByClassName("w3-hide");
        for (var i = 0; i < dropdowns.length; i++) {
            if (dropdowns[i].id !== id) {
                dropdowns[i].className = dropdowns[i].className.replace(
                        " w3-show", "");
                if (dropdowns[i].previousElementSibling) {
                    dropdowns[i].previousElementSibling.className = dropdowns[i].previousElementSibling.className
                            .replace(" w3-lightgrey", "");
                }
            }
        }

        // 선택한 드롭다운 메뉴 상태 토글
        if (x.className.indexOf("w3-show") == -1) {
            x.className += " w3-show";
            x.previousElementSibling.className += " w3-lightgrey";
        } else {
            x.className = x.className.replace(" w3-show", "");
            x.previousElementSibling.className = x.previousElementSibling.className
                    .replace(" w3-lightgrey", "");
        }
    }

    document.getElementById('updateForm').onsubmit = function() {
        var quantities = document.querySelectorAll('input[name^="productInfos"][name$="quantity"]');
        for (var i = 0; i < quantities.length; i++) {
            if (quantities[i].value.trim() === "") {
                alert('재고를 작성해주세요.');
                return false;
            }
        }
        return true;
    };

    document.querySelectorAll('input[name^="productInfos"][name$="quantity"]').forEach(input => {
        input.addEventListener('input', function() {
            if (this.value < 0) {
                this.value = 0; // 값이 0 미만으로 내려가면 0으로 설정
            }
        });
    
    // 화살표 키로 값을 조정할 때 제어
    input.addEventListener('keydown', function(event) {
        if (event.key === 'ArrowDown' && this.value <= 0) {
            event.preventDefault(); // 값이 0 이하로 내려가는 것을 방지
        }
    });
});
    
    // ================ ajax form 관련 ======================
    $(document).ready(function() {
        $('#updateForm').submit(function(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            // 폼 데이터를 직렬화
            var formData = new FormData(this);

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    window.location.href = '/storeMyPage/productList';
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX error: ', textStatus, errorThrown);
                    alert('수정 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
				
        // 사진 미리보기
        document.getElementById('addFileButton').addEventListener('click', function() {
				    document.getElementById('productImages').click();
				});
				
				document.getElementById('productImages').addEventListener('change', function(event) {
				    handleFileSelect(event);
				});
				
				function handleFileSelect(event) {
				    const file = event.target.files[0];  // Only handle single file
				    const previewContainer = document.getElementById('imagePreviewContainer');
				    previewContainer.innerHTML = '';  // Clear any existing previews
				
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
				                previewContainer.innerHTML = '';  // Clear the preview
				                document.getElementById('productImages').value = '';  // Clear the file input
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
    });
    
</script>
</body>
</html>
