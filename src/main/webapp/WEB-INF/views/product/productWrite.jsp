<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style>
.modal-dialog {
    max-width: 800px;
}

.modal-body {
    max-height: 400px;
    overflow: auto;
}

/* Image preview styling */
#imagePreviewContainer {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
.image-preview {
    position: relative;
    width: 100px;
    height: 130px;
}
.image-preview img {
    width: 150px;
    height: 180px;
    object-fit: cover;
}

.remove-button {
    position: absolute;
    top: 15px;
    right: 15px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    padding: 2px 6px;
    font-size: 12px;
}

.selected-item {
    color: blue;
    font-weight: bold;
}

.container {
    margin-top: 100px;
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

</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <%@include file="/WEB-INF/layouts/storeAside.jsp"%>

    <!-- ========= 등록 페이지 ============ -->

    <div class="w3-container" style="margin-left: 160px">
        <div class="container">
            <h3>상품 등록</h3>
            <form action="${pageContext.request.contextPath}/storeMyPage/products/add"
                method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="pname">상품명</label> 
                        <input type="text" value="에어포스" class="form-control" id="pname" name="pname" required>
                </div>
                <div class="form-group">
                    <label for="unitprice">상품 판매가</label> 
                        <input type="number" value="109000" class="form-control" id="unitprice" name="unitprice" required>
                </div>
                <div class="form-group">
                    <label for="menufecturer">제조사</label>
                        <input type="text" value="나이키" class="form-control" id="menufecturer" name="menufecturer" required>
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
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
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
                                <div class="modal-footer d-flex justify-content-between align-items-center">
                                    <div id="selectedCategoryDisplay" class="selected-item"></div>
                                    <div>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                        <button type="button" class="btn btn-primary" id="applyCategory">적용</button>
                                    </div>
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
                    <div id="selectedColorDisplay" class="selected-item"></div>
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
                    <div id="selectedSizeDisplay" class="selected-item"></div>
                </div>
                
                <div class="form-group">
                    <label for="quantity">재고</label>
                    <input type="number" value="99" class="form-control" id="quantity" name="quantity" required min="0">
                </div>
                <br><br>
                <div class="form-group">
                    <button type="button" id="addProductInfo" class="btn btn-secondary" name="productInfos">색상/사이즈/재고 추가</button>
                </div>
                <div class="form-group">
                    <table class="table" id="productInfoTable">
                        <thead>
                            <tr>
                                <th>색상</th>
                                <th>사이즈</th>
                                <th>재고</th>
                                <th>삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 추가된 색상, 사이즈, 재고가 이 body에 추가됨 -->
                        </tbody>
                    </table>
                </div>
                
                <div class="form-group">
                    <label for="productImages"></label> 
                    <button type="button" id="addFileButton" class="btn btn-secondary mt-2">Image 추가</button>
                    <input type="file" class="form-control" id="productImages" name="productImages" style="display: none;">
                    <div id="imagePreviewContainer" class="d-flex flex-wrap mt-2"></div>
                </div>
                <br><br>
                <div class="button-container">
                    <button type="submit" class="btn btn-primary">상품 등록</button>
                    <a href="/storeMyPage/productList" class="btn btn-outline-dark">목록</a>
                </div>
            </form>
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
                <div class="modal-footer d-flex justify-content-between align-items-center">
                    <div id="selectedColorModalDisplay" class="selected-item"></div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" id="applyColor">적용</button>
                    </div>
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
                <div class="modal-footer d-flex justify-content-between align-items-center">
                    <div id="selectedSizeModalDisplay" class="selected-item"></div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" id="applySize">적용</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
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
            var selectedColor = null;
            var selectedSize = null;
            var productInfoIndex = 0;

            $('#categoryModal').on('show.bs.modal', function () {
                loadCategories();
            });

            $('#searchInput').on('input', debounce(function() {
                var keyword = $(this).val();
                loadCategories(keyword);
            }, 50));

            function loadCategories(keyword) {
                $.ajax({
                    url: '/storeMyPage/api/categories',
                    method: 'GET',
                    data: { keyword: keyword }, 
                    success: function(categories) {
                        var categoryList = $('#categoryList');
                        categoryList.empty();
                        categories.forEach(function(category) {
                            categoryList.append('<tr><td>' + category.engName + '</td><td><a href="#" class="category-item" data-code="' + category.korName + '" data-name="' + category.korName + '">' + category.korName + '</a></td></tr>');
                        });

                        $('.category-item').click(function() {
                            var categoryCode = $(this).data('code');
                            var categoryName = $(this).data('name');
                            selectedCategory = { code: categoryCode, name: categoryName };
                            loadSubCategories(categoryCode);
                        });
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('AJAX error: ', textStatus, errorThrown);
                        alert('카테고리를 불러오는 중 오류가 발생했습니다. 자세한 내용은 콘솔을 확인하세요.');
                    }
                });
            }

            function loadSubCategories(categoryCode) {
                $.ajax({
                    url: '/storeMyPage/api/subcategories',
                    method: 'GET',
                    data: { categoryCode: categoryCode },
                    success: function(subCategories) {
                        var subCategoryList = $('#categoryList');
                        subCategoryList.empty();
                        subCategories.forEach(function(subCategory) {
                            subCategoryList.append('<tr><td>' + subCategory.korName + '</td><td><a href="#" class="subcategory-item" data-id="' + subCategory.subCategoryIdx + '" data-name="' + subCategory.korName + '">' + subCategory.korName + '</a></td></tr>');
                        });

                        $('.subcategory-item').click(function() {
                            var subCategoryId = $(this).data('id');
                            var subCategoryName = $(this).data('name');
                            selectedSubCategory = { id: subCategoryId, name: subCategoryName };
                            $('#selectedCategoryDisplay').html(selectedCategory.name + ' / ' + selectedSubCategory.name);
                        });
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert('서브 카테고리를 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            $('#applyCategory').click(function() {
                if (selectedCategory && selectedSubCategory) {
                    $('#categoryInput').val(selectedCategory.name + ' / ' + selectedSubCategory.name);
                    $('#subCategoryInput').val(selectedSubCategory.id);
                    $('#categoryModal').modal('hide');
                } else {
                    alert('카테고리와 서브 카테고리를 선택하세요.');
                }
            });

            $('#colorModal').on('show.bs.modal', function () {
                loadColors();
            });

            function loadColors() {
                $.ajax({
                    url: '/storeMyPage/api/colors',
                    method: 'GET',
                    success: function(colors) {
                        var colorList = $('#colorList');
                        colorList.empty();
                        colors.forEach(function(color) {
                            colorList.append('<tr><td>' + color.color + '</td><td><a href="#" class="color-item" data-id="' + color.productColorIdx + '" data-name="' + color.color + '">선택</a></td></tr>');
                        });

                        $('.color-item').click(function() {
                            var colorId = $(this).data('id');
                            var colorName = $(this).data('name');
                            selectedColor = { id: colorId, name: colorName };
                            $('#selectedColorModalDisplay').html(colorName);
                        });
                    },
                    error: function() {
                        alert('색상을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            $('#applyColor').click(function() {
                if (selectedColor) {
                    $('#colorInput').val(selectedColor.name);
                    $('#colorIdx').val(selectedColor.id);
                    $('#colorModal').modal('hide');
                } else {
                    alert('색상을 선택하세요.');
                }
            });

            $('#sizeModal').on('show.bs.modal', function () {
                if (!selectedCategory) {
                    alert('카테고리를 먼저 선택해주세요.');
                    $('#sizeModal').modal('hide'); 
                    return;
                }
                loadSizes();
            });

            function loadSizes() {
                let sizes = [];
                switch (selectedCategory.name) {
                    case '아우터':
                    case '상의':
                    case '니트':
                    case '셔츠':
                        sizes = ['90 (S)', '95 (M)', '100 (L)', '105 (XL)', '110 (2XL)'];
                        break;
                    case '바지':
                        sizes = Array.from({ length: 13 }, (_, i) => (i + 30).toString());
                        break;
                    case '신발':
                        sizes = Array.from({ length: 11 }, (_, i) => (i * 10 + 200).toString());
                        break;
                    case '악세사리':
                    case '가방':
                    case '모자':
                        sizes = ['free'];
                        break;
                    default:
                        alert('올바른 카테고리를 선택해주세요.');
                        return;
                }

                var sizeList = $('#sizeList');
                sizeList.empty();
                sizes.forEach(function(size) {
                    var sizeIdx = size.split(' ')[0];  // 숫자 부분만 추출
                    sizeList.append('<tr><td>' + size + '</td><td><a href="#" class="size-item" data-id="' + sizeIdx + '" data-name="' + size + '">' + size + '</a></td></tr>');
                });

                $('.size-item').click(function() {
                    var sizeId = $(this).data('id');
                    var sizeName = $(this).data('name');
                    selectedSize = { sizeIdx: sizeId, sizes: sizeName };
                    $('#selectedSizeModalDisplay').text(sizeName);
                    $('#sizeInput').val(sizeName);
                    $('#sizeIdx').val(sizeId);  // sizeIdx를 hidden 필드에 설정
                });
            }

            $('#applySize').click(function() {
                if (selectedSize) {
                    $('#sizeInput').val(selectedSize.sizes);
                    $('#sizeIdx').val(selectedSize.sizeIdx);
                    $('#sizeModal').modal('hide');
                } else {
                    alert('사이즈를 선택하세요.');
                }
            });

            $('#addProductInfo').click(function() {
                var color = $('#colorInput').val();
                var colorIdx = $('#colorIdx').val();
                var size = $('#sizeInput').val();
                var sizeIdx = $('#sizeIdx').val();
                var quantity = $('#quantity').val();
                
                if (!color || !size || !quantity) {
                    alert("모든 필드를 입력하세요.");
                    return;
                }
                
                var row = '<tr>' +
                '<td>' + color + '</td>' +
                '<td>' + size + '</td>' +
                '<td>' + quantity + '</td>' +
                '<td><button type="button" class="btn btn-danger removeProductInfo">삭제</button></td>' +
                '<input type="hidden" name="productInfos[' + productInfoIndex + '].colorIdx" value="' + colorIdx + '">' +
                '<input type="hidden" name="productInfos[' + productInfoIndex + '].sizeIdx" value="' + sizeIdx + '">' +
                '<input type="hidden" name="productInfos[' + productInfoIndex + '].quantity" value="' + quantity + '">' +
                '</tr>';
            
                $('#productInfoTable tbody').append(row);
                productInfoIndex++;

            });

            $(document).on('click', '.removeProductInfo', function() {
                $(this).closest('tr').remove();
                productInfoIndex--;
                $('#productInfoTable tbody tr').each(function(index) {
                    $(this).find('input').each(function() {
                        var name = $(this).attr('name');
                        var newName = name.replace(/\[\d+\]/, '[' + index + ']');
                        $(this).attr('name', newName);
                    });
                });
            });

            document.getElementById('addFileButton').addEventListener('click', function() {
                document.getElementById('productImages').click();
            });

            document.getElementById('productImages').addEventListener('change', function(event) {
                handleFileSelect(event);
            });

            function handleFileSelect(event) {
                const file = event.target.files[0];  
                const previewContainer = document.getElementById('imagePreviewContainer');
                previewContainer.innerHTML = '';  

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
                            previewContainer.innerHTML = '';  
                            document.getElementById('productImages').value = '';  
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

            document.getElementById('quantity').addEventListener('input', function() {
                if (this.value < 0) {
                    this.value = 0;
                }
            });

            document.getElementById('quantity').addEventListener('change', function() {
                if (this.value < 0) {
                    this.value = 0;
                }
            });
            
            document.getElementById('quantity').addEventListener('keydown', function(e) {
                if (e.key === 'ArrowDown' && this.value <= 0) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
