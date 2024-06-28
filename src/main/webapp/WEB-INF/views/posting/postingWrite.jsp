<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery("#summernote").summernote({
          height : 550  // 에디터 높이
        , minHeight : null  // 최소 높이
        , maxHeight : null  // 최대 높이
        , focus : true  // 에디터 로딩후 포커스를 맞출지 여부( true, false )
        , lang : "ko-KR"    // 한글 설정
        , placeholder : "게시글 작성" 
        , fontNames : [ "맑은 고딕", "궁서", "굴림체", "굴림", "돋움체", "바탕체", "Arial", "Arial Black", "Comic Sans MS", "Courier New" ]
        , fontNamesIgnoreCheck : ["맑은 고딕"]  // 기본 폰트 설정( 2024-06-28 동작하지 않음, 'sans-serif' 자동선택 )
        , fontSizes : [ "8", "9", "10", "11", "12", "14", "16", "18", "20", "22", "24", "28", "30", "36", "50", "72" ]
    });
});


</script>

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
          
          
          <!-- 에디터 영역 -->
          <textarea id="summernote" name="editordata"></textarea>
          
              
          <!--  
          <div class="form-group">
              <label for="content">판매글 내용</label>
              <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
          </div>
          -->
        
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
            console.log("Data received:", data);
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
		// ======================= 에디터 영역 ============================================
		$(document).ready(function() {
			$('.summernote').summernote();
		});
		
		
		callbacks: {
		    onImageUpload: function (files, editor, welEditable) {
		        // 파일 업로드 (다중 업로드를 위해 반복문 사용)
		        for (var i = files.length - 1; i >= 0; i--) {
		            var fileName = files[i].name

		            // 이미지 alt 속성 삽일을 위한 설정
		            var caption = prompt('이미지 설명 :', fileName)
		            if (caption == '') {
		                caption = '이미지'
		            }
		            uploadSummernoteImageFile(files[i], this, caption)
		        }
		    },
		},
		})
		})

		// 이미지 업로드 함수 ajax 활용
		    function uploadSummernoteImageFile(file, el, caption) {
		        data = new FormData()
		        data.append('file', file)
		        $.ajax({
		            data: data,
		            type: 'POST',
		            url: 'uploadSummernoteImageFile',
		            contentType: false,
		            enctype: 'multipart/form-data',
		            processData: false,
		            success: function (data) {
		                $(el).summernote(
		                    'editor.insertImage',
		                    data.url,
		                    function ($image) {
		                        $image.attr('alt', caption) // 캡션 정보를 이미지의 alt 속성에 설정
		                    }
		                )
		            },
		        })
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