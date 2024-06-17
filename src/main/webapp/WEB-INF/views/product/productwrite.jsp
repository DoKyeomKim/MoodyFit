<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
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
</style>
</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>

	<div class="w3-sidebar w3-bar-block w3-light-grey w3-card"
		style="width: 160px;">
		<a href="#" class="w3-bar-item w3-button">Link 1</a>
		<button class="w3-button w3-block w3-left-align"
			onclick="toggleAccFunc('productAcc')">
			상품 관리 <i class="fa fa-caret-down"></i>
		</button>
		<div id="productAcc" class="w3-hide w3-white w3-card">
			<a href="/storeMypage/productList" class="w3-bar-item w3-button">상품 리스트</a> <a
				href="/storeMypage/productAdd" class="w3-bar-item w3-button">상품등록</a> 
		</div>
		<button class="w3-button w3-block w3-left-align" 
			onclick="toggleAccFunc('saleAcc')">
			판매 글 관리 <i class="fa fa-caret-down"></i>
		</button>
		<div id="saleAcc" class="w3-hide w3-white w3-card">
			<a href="#" class="w3-bar-item w3-button">판매 글 리스트</a> <a href="#"
				class="w3-bar-item w3-button">판매 글 등록</a> <a href="#"
				class="w3-bar-item w3-button">판매 글 신청 현황</a>
		</div>

		<a href="#" class="w3-bar-item w3-button">정보 수정</a> <a href="#"
			class="w3-bar-item w3-button">회원 탈퇴</a>
	</div>
	
	
	<!-- ========= 등록 페이지 ============ -->
	
	<div class="w3-container" style="margin-left: 160px">
		<div class="container">
			<h3>상품 등록</h3>
			<form action="${pageContext.request.contextPath}/storeMypage/products/add"
				method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="pname">상품명</label> <input type="text" value="에어포스"
						class="form-control" id="pname" name="pname" required>
				</div>
				<div class="form-group">
					<label for="unitprice">상품 판매가</label> <input type="number" value="999"
						class="form-control" id="unitprice" name="unitprice" required>
				</div>
				<div class="form-group">
					<label for="menufecturer">제조사</label><input type="text" value="나이키"
						class="form-control" id="menufecturer" name="menufecturer" required>
				</div>
				<div class="form-group">
					<label for="category">카테고리</label>
					<div class="input-group">
						<input type="text" class="form-control" id="categoryInput" name="category" 
							placeholder="카테고리를 선택하세요" required readonly>	
						<div class="input-group-append">
							<button type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#categoryModal">카테고리 선택</button>
						</div>
					</div>
					
					<input type="hidden" id="subCategoryInput" name="subCategoryIdx">

					<!-- 모달 창 -->
					<div class="modal fade" id="categoryModal" tabindex="-1"
						role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="categoryModalLabel">카테고리 선택</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<!-- 검색창 -->
									<div class="input-group mb-3">
										<input type="text" class="form-control" id="searchInput" placeholder="카테고리를 검색하세요">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button" id="searchButton">검색</button>
										</div>
									</div>
									<!-- 카테고리 리스트 -->
									<table class="table">
										<thead>
											<tr>
												<th>카테고리</th>
												<th>선택</th>
											</tr>
										</thead>
										<tbody id="categoryList">
											<!-- 카테고리 리스트가 여기에 동적으로 추가 -->
										</tbody>
									</table>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary"id="applyCategory">적용</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
            <label for="color">색상</label>
            <div class="input-group">
                <input type="text" class="form-control" id="colorInput" name="colorName" placeholder="색상을 선택하세요" readonly>
                <input type="hidden" id="colorIdx" name="colorIdx">
                <div class="input-group-append">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#colorModal">색상 선택</button>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="size">사이즈</label>
            <div class="input-group">
                <input type="text" class="form-control" id="sizeInput" name="sizeName" placeholder="사이즈를 선택하세요" readonly>
                <input type="hidden" id="sizeIdx" name="sizeIdx">
                <div class="input-group-append">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sizeModal">사이즈 선택</button>
                </div>
            </div>
        </div>
				<div class="form-group">
					<label for="quantity">재고</label> <input type="text" value="99"
						class="form-control" id="quantity" name="quantity" required>
				</div>
				
				<!--
				<div class="form-group">
					<label for="image">상품 사진</label> <input type="file"
						class="form-control" id="image" name="image" required>
				</div>
				<br>
				<br>
				 -->
				 <br><br>
				<button type="submit" class="btn btn-outline-primary">상품 등록</button>
			</form>
				<a href="/storeMypage/productList"><button type="submit" class="btn btn-outline-dark">목록</button></a>
		</div>
	</div>
	
	<!-- 색상 선택 모달 -->
<div class="modal fade" id="colorModal" tabindex="-1" role="dialog" aria-labelledby="colorModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="colorModalLabel">색상 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>색상</th>
                            <th>선택</th>
                        </tr>
                    </thead>
                    <tbody id="colorList">
                        <!-- 색상 리스트가 여기에 동적으로 추가됩니다 -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="applyColor">적용</button>
            </div>
        </div>
    </div>
</div>

<!-- 사이즈 선택 모달 -->
<div class="modal fade" id="sizeModal" tabindex="-1" role="dialog" aria-labelledby="sizeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sizeModalLabel">사이즈 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>사이즈</th>
                            <th>선택</th>
                        </tr>
                    </thead>
                    <tbody id="sizeList">
                        <!-- 사이즈 리스트가 여기에 동적으로 추가됩니다 -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="applySize">적용</button>
            </div>
        </div>
    </div>
</div>
	

	<script src="/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
	
	// =====================  스크립트 =========================================================================== 
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
		
		
		// =================== 카테고리 모달 ======================================================
		function debounce(func, wait) {
		    let timeout;
		    return function() {
		        const context = this, args = arguments;
		        clearTimeout(timeout);
		        timeout = setTimeout(() => func.apply(context, args), wait);
		    };
		}
			
			
		$(document).ready(function() {
    var selectedCategory = null;
    var selectedSubCategory = null;

    // 모달 창 열릴 때 카테고리 목록을 불러옴
    $('#categoryModal').on('show.bs.modal', function () {
        loadCategories();
    });

    // 검색 입력 시 실시간으로 필터링 된 카테고리 목록 불러옴
    $('#searchInput').on('input', debounce(function() {
        var keyword = $(this).val();
        loadCategories(keyword);
    }, 50)); // 50ms 지연 후 실행

    // 카테고리 목록 불러오는 함수
    function loadCategories(keyword) {
        $.ajax({
            url: '/api/categories',
            method: 'GET',
            data: { keyword: keyword }, 
            success: function(categories) {
                // 카테고리 리스트를 테이블에 추가
                var categoryList = $('#categoryList');
                categoryList.empty(); // 기존 목록 삭제
                categories.forEach(function(category) {
                	// 카테고리 로드 시 engName과 korName 으로
                    categoryList.append('<tr><td>' + category.engName + '</td><td><a href="#" class="category-item" data-code="' + category.korName + '" data-name="' + category.korName + '">' + category.korName + '</a></td></tr>');
                });

                // 카테고리 아이템 클릭 시
                $('.category-item').click(function() {
                    var categoryCode = $(this).data('code'); // engName
                    var categoryName = $(this).data('name'); // korName
                    selectedCategory = { code: categoryCode, name: categoryName };
                    
                    console.log('Selected Category:', selectedCategory);
                    loadSubCategories(categoryCode); // 서브 카테고리 로드
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
            		console.error('AJAX error: ', textStatus, errorThrown);
                console.error('Response text: ', jqXHR.responseText);
                alert('카테고리를 불러오는 중 오류가 발생했습니다. 자세한 내용은 콘솔을 확인하세요.');
            }
        });
    }

    // 서브 카테고리 목록을 불러오는 함수
    function loadSubCategories(categoryCode) {
        $.ajax({
            url: '/api/subcategories',
            method: 'GET',
            data: { categoryCode: categoryCode },
            success: function(subCategories) {
                // 서브 카테고리 리스트를 표시
                var subCategoryList = $('#categoryList');
                subCategoryList.empty(); 
                subCategories.forEach(function(subCategory) {
                	 // 서브 카테 이름 = kor, 선택 부분 = idx 표시
                    subCategoryList.append('<tr><td>' + subCategory.korName + '</td><td><a href="#" class="subcategory-item" data-id="' + subCategory.subCategoryIdx + '" data-name="' + subCategory.korName + '">' + subCategory.subCategoryIdx + '</a></td></tr>');
                });

                // 서브 카테고리 아이템 클릭 시
                $('.subcategory-item').click(function() {
                    var subCategoryId = $(this).data('id');
                    var subCategoryName = $(this).data('name');
                    selectedSubCategory = { id: subCategoryId, name: subCategoryName };
                    
                    console.log('Selected SubCategory:', selectedSubCategory);
		                // 선택된 서브 카테고리 idx를 숨겨진 필드에 설정
		                $('#subCategoryInput').val(subCategoryId);
		                $('#categoryInput').val(selectedCategory.name); // 카테고리 이름 설정
		           		  
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX error: ', textStatus, errorThrown);
                console.error('Response text: ', jqXHR.responseText);
                alert('서브 카테고리를 불러오는 중 오류가 발생했습니다. 자세한 내용은 콘솔을 확인하세요.');
            }
        });
    }

 // 적용 버튼 클릭 시
    $('#applyCategory').click(function() {
        // 선택된 카테고리와 서브 카테고리가 있는지 확인
        if (selectedCategory && selectedSubCategory) {
            // 선택된 카테고리와 서브 카테고리 값을 입력 필드에 설정
            $('#categoryInput').val(selectedCategory.name);
            $('#subCategoryInput').val(selectedSubCategory.id);
            
            console.log('Category set to:', $('#categoryInput').val()); // 디버깅용 로그
            console.log('SubCategory set to:', $('#subCategoryInput').val()); // 디버깅용 로그
            $('#categoryModal').modal('hide');
        } else {
            alert('카테고리와 서브 카테고리를 선택하세요.');
        }
    });
});
	
		
		
		// =================== 색상 모달 =============================
		$(document).ready(function() {
	        var selectedColor = null;

	        // 모달 창 열릴 때 색상 목록 로드
	        $('#colorModal').on('show.bs.modal', function () {
	            loadColors();
	        });

	        // 색상 목록 로드 함수
	        function loadColors() {
	            $.ajax({
	                url: '/storeMypage/api/colors', 
	                method: 'GET',
	                success: function(colors) {
	                    var colorList = $('#colorList');
	                    colorList.empty();
	                    colors.forEach(function(color) {
	                        colorList.append('<tr><td>' + color.color + '</td><td><a href="#" class="color-item" data-id="' + color.productColorIdx + '" data-name="' + color.color + '">선택</a></td></tr>');
	                    });
	                    
	                    console.dir($(this));
	                    var colorId = $(this).data('id');
                      var colorName = $(this).data('name');
                      console.log(colorId);
                      console.log(colorName);

	                    // 색상 아이템 클릭 시
	                    $('.color-item').click(function() {
	                        var colorId = $(this).data('id');
	                        var colorName = $(this).data('name');
	                        selectedColor = { id: colorId, name: colorName };
	                        $('#colorInput').val(colorName);
	                        $('#colorIdx').val(colorId);
	                        $('#colorModal').modal('hide');
	                    });
	                },
	                error: function() {
	                    alert('색상을 불러오는 중 오류가 발생했습니다.');
	                }
	            });
	        }
	    });

		// =================== 사이즈 모달 =============================
	    $(document).ready(function() {
	        var selectedSize = null;

	        // 모달 창 열릴 때 사이즈 목록을 불러옴
	        $('#sizeModal').on('show.bs.modal', function () {
	            loadSizes();
	        });

	        // 사이즈 목록 불러오는 함수
	        function loadSizes() {
	            $.ajax({
	                url: '/storeMypage/api/sizes', 
	                method: 'GET',
	                success: function(sizes) {
	                    var sizeList = $('#sizeList');
	                    sizeList.empty();
	                    sizes.forEach(function(size) {
	                        sizeList.append('<tr><td>' + size.sizes + '</td><td><a href="#" class="size-item" data-id="' + size.productSizeIdx + '" data-name="' + size.sizes + '">선택</a></td></tr>');
	                    });

	                    // 사이즈 아이템 클릭 시
	                    $('.size-item').click(function() {
	                        var sizeId = $(this).data('id');
	                        var sizeName = $(this).data('name');
	                        selectedSize = { id: sizeId, name: sizeName };
	                        $('#sizeInput').val(sizeName);
	                        $('#sizeIdx').val(sizeId);
	                        $('#sizeModal').modal('hide'); 
	                    });
	                },
	                error: function() {
	                    alert('사이즈를 불러오는 중 오류가 발생했습니다.');
	                }
	            });
	        }
	    });
		
			
	</script>
</body>
</html>