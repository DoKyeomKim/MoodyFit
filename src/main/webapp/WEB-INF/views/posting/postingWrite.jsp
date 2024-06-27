<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
.product-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
.product-item {
    border: 1px solid #ddd;
    padding: 10px;
    cursor: pointer;
    width: 150px;
}
.product-item img {
    width: 100%;
    height: auto;
}
.product-item.selected {
    border-color: #007bff;
}
.details-container {
    margin-top: 20px;
}
.tab-content {
    display: none;
}
.tab-content.active {
    display: block;
}
.tab-nav {
    display: flex;
    cursor: pointer;
}
.tab-nav div {
    margin-right: 10px;
    padding: 10px;
    border: 1px solid #ddd;
}
.tab-nav div.active {
    background-color: #007bff;
    color: white;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/header.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

<div class="container">
    <h3>판매글 등록</h3>
    
    <!-- 상품 목록 -->
    <div class="product-selection">
		    <label for="productSelect">판매 상품 선택:</label>
		    <select id="productSelect" onchange="loadProductDetails(this.value)">
		        <option value="">상품을 선택하세요</option>
		        <c:forEach var="product" items="${products}">
		            <option value="${product.PRODUCTIDX}">${product.NAME} - ${product.CATEGORY} / ${product.SUBCATEGORY}</option>
		        </c:forEach>
		    </select>
		</div>

		
		<div id="productDetails">
		    <!-- 상품 상세 정보를 여기에 표시 -->
		</div>

		
		<form method="post" enctype="multipart/form-data" action="/storeMyPage/postingWrite">
   		<input type="hidden" id="productIdx" name="productIdx" value="">
   		<input type="hidden" id="productInfoIdx" name="productInfoIdx" value="">
          <div class="form-group">
              <label for="title">판매글 제목</label>
              <input type="text" id="title" name="title" class="form-control" required>
          </div>
          
          <div class="form-group">
              <label for="content">판매글 내용</label>
              <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
          </div>
          
          <div class="form-group">
	            <label for="postingFiles"></label>
	            <button type="button" id="addFileButton" class="btn btn-secondary mt-2">Image 추가</button>
	            <input type="file" id="postingFile" class="form-control" style="display: none;" multiple>
	            <div id="imagePreviewContainer" class="d-flex flex-wrap mt-2"></div>
	        </div>
          
          <button type="submit" class="btn btn-primary">등록</button>
    </form>
 </div>


<script src="/js/bootstrap.bundle.min.js"></script>

<script>
	// 상품 상세 정보 로드 관련
	function loadProductDetails(productIdx) {
	    if (productIdx === "") {
	        document.getElementById('productDetails').innerHTML = "";
	        return;
	    }
	
	    console.log("Selected Product IDX:", productIdx);
	
	    fetch('/storeMyPage/posting/getProductDetails?productIdx=' + productIdx)
	        .then(response => {
	            if (!response.ok) {
	                throw new Error('Network response was not ok ' + response.statusText);
	            }
	            return response.json();
	        })
	        .then(data => {
                document.getElementById('productIdx').value = productIdx;
                if (data.productInfoIdx) {
                    document.getElementById('productInfoIdx').value = data.productInfoIdx;
                } else {
                    console.error('productInfoIdx is undefined');
                    document.getElementById('productInfoIdx').value = ''; // 기본값 설정
                }
                displayProductDetails(data);
            })
            .catch(error => console.error('Error fetching product details:', error));
    }
	
	function displayProductDetails(data) {
        console.log("Data received:", data);
        const detailsDiv = document.getElementById('productDetails');
        let imagesHtml = '';

        if (data.filePaths) {
            imagesHtml = data.filePaths.split(', ').map(filePath => {
                return '<img src="' + filePath + '" alt="' + data.name + 
                '" style="width: 100px; height: 100px; object-fit: cover; margin: 5px;">';
            }).join('');
        }

        detailsDiv.innerHTML = `
            <h3>${data.name}</h3>
            <p>가격: ${data.price} 원</p>
            <p>색상: ${data.colors}</p>
            <p>사이즈: ${data.sizes}</p>
            <p>재고: ${data.quantities} 개</p>
            <div class="images">${imagesHtml}</div>
        `;
        console.log("HTML set to:", detailsDiv.innerHTML);
    }
		
	
	
		// ==================================================================================
		// ======================= 판매글 파일 등록 관련 =====================================
    document.getElementById('addFileButton').addEventListener('click', function() {
        document.getElementById('postingFile').click();
    });

    document.getElementById('postingFile').addEventListener('change', function(event) {
        handleFileSelect(event);
    });

    let filesArray = [];
	
    
    function handleFileSelect(event) {
        const files = event.target.files;
        const previewContainer = document.getElementById('imagePreviewContainer');
        
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            filesArray.push(file);
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.width = '100px';
                img.style.height = '130px';
                img.style.objectFit = 'cover';
                img.style.margin = '5px';
                
                // 삭제 아이콘
                const removeButton = document.createElement('span');
                removeButton.innerHTML = '&times;';
                removeButton.classList.add('btn', 'btn-danger', 'btn-sm', 'ml-2');
                removeButton.style.position = 'absolute';
                removeButton.style.top = '5px';
                removeButton.style.right = '5px';
                removeButton.style.cursor = 'pointer';
                removeButton.addEventListener('click', function() {
                    filesArray = filesArray.filter(f => f !== file);
                    previewContainer.removeChild(imgContainer);
                });

                const imgContainer = document.createElement('div');
                imgContainer.style.position = 'relative';
                imgContainer.appendChild(img);
                imgContainer.appendChild(removeButton);
                previewContainer.appendChild(imgContainer);
            }
            reader.readAsDataURL(file);
        }

        // Clear the input to allow the same file to be selected again if needed
        event.target.value = '';
    }
</script>


</body>
</html>