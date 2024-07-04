<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매글 등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css">
<script type="text/JavaScript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
<script type="text/JavaScript" src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
<style>
.container {
    margin-top: 200px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/layouts/header.jsp" %>
<%@ include file="/WEB-INF/layouts/storeAside.jsp" %>

<div class="container">
    <h3>판매글 등록</h3>
    
    <div class="product-selection">
        <label for="productSelect">판매 상품 선택:</label>
        <select id="productSelect">
            <option value="">상품을 선택하세요</option>
            <c:forEach var="product" items="${products}">
                <option value="${product.PRODUCTIDX}">${product.NAME} - ${product.CATEGORY} / ${product.SUBCATEGORY}</option>
            </c:forEach>
        </select>
    </div>


    <div id="productDetails"></div>

    <form id="postingForm" method="post" enctype="multipart/form-data" action="/storeMyPage/postingWrite">

        <input type="hidden" id="productIdx" name="productIdx" value="">
        <input type="hidden" id="productInfoIdx" name="productInfoIdx" value="">
        <div class="form-group">
            <label for="title">판매글 제목</label>
            <input type="text" id="title" name="title" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="summernote">판매글 내용</label>
            <textarea id="summernote" name="content"></textarea>
        </div>
        
        <button type="submit" class="btn btn-primary">등록</button>
    </form>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    $('#summernote').summernote({
        height: 550,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR',
        placeholder: '게시글 작성',
        fontNames: ['맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
        fontNamesIgnoreCheck: ['맑은 고딕'],
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
        callbacks: {
            onImageUpload: function(files) {
                uploadImage(files[0]);
            }
        }
    });

    $('#productSelect').change(function() {
        var productIdx = $(this).val();
        if (!productIdx) {
            $('#productDetails').html('');
            return;
        }


        $.ajax({
            url: '/storeMyPage/posting/getProductDetails',
            type: 'GET',
            data: { productIdx: productIdx },
            success: function(data) {
                console.log('Product details:', data);
                $('#productIdx').val(productIdx);

                const productInfoIds = data.map(item => item.productInfoIdx).join(', ');
                $('#productInfoIdx').val(productInfoIds);

                displayProductDetails(data);
            },
            error: function(error) {
                console.error('Error fetching product details:', error);
            }
        });
    });

    $('#postingForm').submit(function(event) {
        event.preventDefault();
        
        // Get Summernote content and extract image URLs
        var content = $('#summernote').val();
        var imageUrls = [];
        $(content).find('img').each(function() {
            imageUrls.push($(this).attr('src'));
        });

        // Prepare form data
        var formData = new FormData(this);
        imageUrls.forEach(function(url, index) {
            formData.append('files', urlToFile(url, 'image' + index + '.png'));
        });

        $.ajax({
            url: '/storeMyPage/postingWrite',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                window.location.href = '/storeMyPage/postingList';
            },
            error: function(error) {
                console.error('Error submitting form:', error);
            }
        });
    });
});

function displayProductDetails(data) {
    const detailsDiv = $('#productDetails');
    detailsDiv.empty();

    data.forEach(item => {
        let imagesHtml = '';
        if (item.filePaths) {
            imagesHtml += item.filePaths.split(', ').map(filePath => {
                return '<img src="' + filePath + '" alt="' + item.name + 
                '" style="width: 100px; height: 100px; object-fit: cover; margin: 5px;">';
            }).join('');
        }

        detailsDiv.append(`
            <h3>${item.name}</h3>
            <p>가격: ${item.price} 원</p>
            <p>색상: ${item.colors}</p>
            <p>사이즈: ${item.sizes}</p>
            <p>재고: ${item.quantities} 개</p>
            <div class="images">${imagesHtml}</div>
        `);
    });
}

function uploadImage(file) {
    var data = new FormData();
    data.append("file", file);
    $.ajax({
        url: '/storeMyPage/uploadSummernoteImageFile',
        type: 'POST',
        data: data,
        contentType: false,
        processData: false,
        success: function(response) {
            console.log('Image upload response:', response);
            var jsonObject = JSON.parse(response);
            if (jsonObject.responseCode === 'success') {
                $('#summernote').summernote('insertImage', jsonObject.url);
            } else {
                console.error('Image upload failed:', jsonObject);
            }
        },
        error: function(error) {
            console.error('Error uploading image:', error);
        }
    });
}

function urlToFile(url, filename, mimeType){
    return (fetch(url)
        .then(function(res){return res.arrayBuffer();})
        .then(function(buf){return new File([buf], filename, {type:mimeType});})
    );
}
</script>

</body>
</html>
