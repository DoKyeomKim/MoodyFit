<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
main {
    width: 80%;
    padding-left: 200px;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <h2 style="text-align:left; margin-top:30px; margin-left:100px;">장바구니</h2>
    <hr>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>

    <main style="margin-top:30px; width:90%;">
        <c:choose>
            <c:when test="${empty cartList}">
                <div style="text-align: center; margin-top: 50px;">
                    <h3 style="margin:100px 30px;">장바구니가 비어있습니다.</h3>
                    <hr>
                </div>
                <div style="text-align : right; margin-right:20px;">
                	<button type="button" class="btn btn-info" style="margin-right: 5px;" onclick="location.href='/'">메인으로</button>
                </div>
            </c:when>
            <c:otherwise>
                <form id="cartForm" action="/mypage/paying" method="post">
                    <c:forEach var="item" items="${cartList}">
                        <div class="box-container" style="border: 1px solid black; padding: 10px; margin: 5px; display: flex; justify-content: space-evenly;">
                            <div style="display: flex;">
                                <input type="checkbox" name="selectedItems" value="${item.cartIdx}" class="itemCheckbox" onchange="updateBuyButton()">
                            </div>
                            <div>
                                <img src="${item.filePath}" class="img-box" style="width: 150px; height: 150px; border: 1px solid #CDCDCD;">
                            </div>
                            <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                                <div class="box" name="title">${item.title}</div>
                                <div class="box" name="name">${item.name}</div>
                                <div class="box" name="name">내일 ${formattedDate} 도착 보장</div>
                                <div class="box" name="price">상품 단가: ${item.price} 원</div>
                            </div>
                            <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                                <div>
                                    <button type="button" class="quantityButton" onclick="updateQuantity(this, -1)">-</button>
                                    <span class="itemQuantity" name="quantity">1</span>
                                    <button type="button" class="quantityButton" onclick="updateQuantity(this, 1)">+</button>
                                </div>
                                <div>
                                    <button type="button" onclick="removeItem(this)">삭제</button>
                                </div>
                            </div>
                            <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                                <div class="box" name="price">가격: <span class="itemPrice" data-price="${item.price}">${item.price}</span>원</div>
                            </div>
                        </div>
                    </c:forEach>
                    <input type="submit" class="btn btn-primary" style="margin:20px;" id="buyButton" value="구매하기">
                </form>
            </c:otherwise>
        </c:choose>
    </main>

    <script>
        // 수량을 업데이트하는 함수
        function updateQuantity(button, change) {
            const quantitySpan = button.parentElement.querySelector('.itemQuantity');
            const priceSpan = button.closest('.box-container').querySelector('.itemPrice');
            const basePrice = parseFloat(priceSpan.getAttribute('data-price'));
            let currentQuantity = parseInt(quantitySpan.textContent);
            currentQuantity = Math.max(1, currentQuantity + change); // Ensure quantity is at least 1
            quantitySpan.textContent = currentQuantity;

            // 해당 상품의 총 가격 업데이트
            const newPrice = basePrice * currentQuantity;
            priceSpan.textContent = newPrice.toLocaleString(); // Add comma as thousand separator if needed
        }

        // 상품을 삭제하는 함수
        function removeItem(button) {
            const itemContainer = button.closest('.box-container');
            itemContainer.remove();

            // Update the buy button count after removing an item
            updateBuyButton();
        }

        // 폼 제출 처리
        document.getElementById('cartForm').addEventListener('submit', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            const form = event.target;
            const formData = new FormData();

            // 체크된 항목에서 데이터 수집
            document.querySelectorAll('.itemCheckbox:checked').forEach(checkbox => {
                const container = checkbox.closest('.box-container');
                const cartIdx = checkbox.value;
                const quantity = container.querySelector('.itemQuantity').textContent;
                const price = container.querySelector('.itemPrice').textContent.replace(/,/g, '');

                formData.append('selectedItems', cartIdx);
                formData.append('quantity_' + cartIdx, quantity);
                formData.append('price_' + cartIdx, price);
            });

            // fetch를 사용하여 수집된 데이터 제출
            fetch(form.action, {
                method: form.method,
                body: formData
            }).then(response => {
                if (response.ok) {
                    // 성공적인 응답을 처리합니다.
                    window.location.href = response.url; // 응답 URL로 리다이렉트
                } else {
                    // 오류 응답을 처리합니다.
                    alert('Error submitting form');
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('Error submitting form');
            });
        });

        // 페이지 로드 시 올바른 수를 설정하기 위한 초기 업데이트
        updateBuyButton();
    </script>
    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
