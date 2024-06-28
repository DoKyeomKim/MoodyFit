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
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!-- 검색창 -->
                                    <div id="selectedCategoryDisplay"></div>
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
                                    <button type="button" class="btn btn-primary" id="applyCategory">적용</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="color">색상</label>
                    <div id="selectedColorDisplay"></div>
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
                    <div id="selectedSizeDisplay"></div>
                    <div class="input-group">
                        <input type="text" class="form-control" id="sizeInput" name="sizeName" placeholder="사이즈를 선택하세요" readonly>
                        <input type="hidden" id="sizeIdx" name="sizeIdx">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sizeModal">사이즈 선택</button>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="quantity">재고</label> <input type="number" value="99" class="form-control" id="quantity" name="quantity" required>
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
                    <label for="productImages">상품 사진</label> 
                    <input type="file" class="form-control" id="productImages" name="productImages" multiple>
                </div>
                <br>
                <br>
                 
                 <br><br>
                <button type="submit" class="btn btn-outline-primary">상품 등록</button>
            </form>
                <a href="/storeMyPage/productList"><button type="submit" class="btn btn-outline-dark">목록</button></a>
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
        });

        $(document).ready(function() {
            var selectedColor = null;

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
                            $('#selectedColorDisplay').html(colorName);
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
        });

        $(document).ready(function() {
            var selectedSize = null;

            $('#sizeModal').on('show.bs.modal', function () {
                loadSizes();
            });

            function loadSizes() {
                $.ajax({
                    url: '/storeMyPage/api/sizes',
                    method: 'GET',
                    success: function(sizes) {
                        var sizeList = $('#sizeList');
                        sizeList.empty();
                        sizes.forEach(function(size) {
                            sizeList.append('<tr><td>' + size.sizes + '</td><td><a href="#" class="size-item" data-id="' + size.productSizeIdx + '" data-name="' + size.sizes + '">선택</a></td></tr>');
                        });

                        $('.size-item').click(function() {
                            var sizeId = $(this).data('id');
                            var sizeName = $(this).data('name');
                            selectedSize = { id: sizeId, name: sizeName };
                            $('#selectedSizeDisplay').html(sizeName + ' <button type="button" class="btn btn-sm btn-danger" id="removeSelectedSize">x</button>');

                            $('#removeSelectedSize').click(function() {
                                selectedSize = null;
                                $('#selectedSizeDisplay').empty();
                            });
                        });
                    },
                    error: function() {
                        alert('사이즈를 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            $('#applySize').click(function() {
                if (selectedSize) {
                    $('#sizeInput').val(selectedSize.name);
                    $('#sizeIdx').val(selectedSize.id);
                    $('#sizeModal').modal('hide');
                } else {
                    alert('사이즈를 선택하세요.');
                }
            });
        });

        var productInfoIndex = 0;
        
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
    </script>
</body>
</html>
