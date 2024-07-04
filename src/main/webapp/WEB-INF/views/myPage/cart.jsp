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
body {
    background-color: #F6F4EE !important;
    font-family: Arial, sans-serif;
}
main {
    width: 90%;
    margin: 0 auto;
}

.box-container {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 20px;
    margin: 10px 0;
    display: flex;
    align-items: center;
    background-color: #fff;
}
.box-container img {
    width: 80px;
    height: 80px;
    border: 1px solid #CDCDCD;
    margin-right: 10px;
}
.box {
    padding: 5px;  
}
.item-details {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 60%;
    font-size: 14px;
    padding: 10px;
}
.item-options {
    display: flex;
    align-items: center;
    margin-left: auto;
}
.item-options button {
    background: none;
    border: 1px solid #CDCDCD;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    width: 30px;
    height: 30px;
}
.item-options .itemQuantity {
    margin: 0 10px;
    width: 30px;
    text-align: center;
}
.price-details {
    display: flex;
    padding:30px;
    flex-direction: column;
    align-items: flex-end;
}
.total-container {
    text-align: center;
    margin-top: 20px;
}
.select-btn {
    margin-bottom: 10px;
    width: 180px;
    align-self: center;
    background-color: #f6f4ee;
    color: black;
    cursor: pointer;
    font-size: 14px;
    border: none;
    height: 60px;
    border: 1px solid #CDCDCD;
}
.all-btn {
    margin-bottom: 10px;
    width: 180px;
    align-self: center;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    font-size: 14px;
    border: none;
    height: 60px;
}
.main-header {
    text-align: center;
    margin: 50px 0;
}
.main-header h1 {
    font-size: 2em;
    font-weight: bold;
    color: #333;
}
.main-header p {
    color: #999;
    margin-top: 10px;
}
.main-header p a {
    font-weight: lighter;
    color: #888888;
    padding: 8px;
    text-decoration: none;
    margin-right: 3px;
    font-size: 13px;
    display: inline-block;
}
.main-header p a:hover,
.main-header p a:active,
.main-header p a:focus {
    background-color: #ddd;
    color: #000;
    text-decoration: underline;
}
.delete-button {
    background: none;
    border: none;
    color: #FF6F61;
    cursor: pointer;
    font-size: 18px;
    margin-left: 10px;
}
.btn-main {
 margin-bottom: 10px;
    width: 120px;
    align-self: center;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    font-size: 14px;
    border: none;
    height: 60px;
    border-radius:10px;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
   
    <%@include file="/WEB-INF/layouts/aside.jsp"%>
    <main>
		<div class="container">
			<div class="main-header">
    <h3 style="font-weight: bold">장바구니</h3>
    <p>  <a href="/myPage/payment">주문/배송조회</a>
         <a href="/myPage/cart">장바구니</a><a href="/myPage/wishList">좋아요</a></p>
        <c:choose>
            <c:when test="${empty cartList}">
                <div style="text-align: center; margin-top: 50px;">
                    <h3 style="margin:100px 30px;">장바구니가 비어있습니다.</h3>
                    <hr>
                </div>
             
                <div class="total-container">
                    <button type="button" class="btn-main" onclick="location.href='/'">메인으로</button>
                </div>
            </c:when>
            <c:otherwise>
                <form id="cartForm" action="/mypage/paying" method="post">
                    <c:forEach var="item" items="${cartList}">
                        <div class="box-container">
                            <input type="checkbox" name="selectedItems" value="${item.cartIdx}" class="itemCheckbox" onchange="updateBuyButton()">
                            <img src="${item.filePath}" alt="Item Image" style="width: 110px; height: 110px;">
                            <div class="item-details">
                                <div class="box">${item.title}</div>
                                <div class="box">${item.name}</div>
                                <div class="box">내일 ${formattedDate} 도착 보장</div>
                          
                            </div>
                            <div class="item-options">
                                <button type="button" class="quantityButton" onclick="updateQuantity(this, -1)">-</button>
                                <span class="itemQuantity" name="quantity">1</span>
                                <button type="button" class="quantityButton" onclick="updateQuantity(this, 1)">+</button>
                            </div>
                            <div class="price-details">
                                <div class="box">가격: <span class="itemPrice" data-price="${item.price}">${item.price}</span>원</div>
                                </div>
                               <button type="button" class="delete-button" onclick="removeItem('${item.cartIdx}')">X</button>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="total-container">
                        <button type="button" class="select-btn" onclick="location.href='/'">전체상품 주문하기</button>
                        
                        <button type="submit" class="all-btn" id="buyButton">선택상품 주문하기</button>
                    </div></div></div>
                    
                </form>
            </c:otherwise>
        </c:choose>
    </main>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
    <script>
        function updateQuantity(button, change) {
            const quantitySpan = button.parentElement.querySelector('.itemQuantity');
            const priceSpan = button.closest('.box-container').querySelector('.itemPrice');
            const basePrice = parseFloat(priceSpan.getAttribute('data-price'));
            let currentQuantity = parseInt(quantitySpan.textContent);
            currentQuantity = Math.max(1, currentQuantity + change); 
            quantitySpan.textContent = currentQuantity;

            const newPrice = basePrice * currentQuantity;
            priceSpan.textContent = newPrice.toLocaleString(); 
        }

        async function removeItem(cartIdx) {
            try {
                const response = await fetch('/myPage/deleteCart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: JSON.stringify({ cartIdx: cartIdx })
                });

                if (!response.ok) {
                    throw new Error("삭제에 실패했습니다.");
                }

                const data = await response.json();
                if (data.message === "success") {
                    alert("삭제되었습니다.");
                    location.reload(); 
                } else {
                    throw new Error("삭제에 실패했습니다.");
                }
            } catch (error) {
                alert("삭제에 실패했습니다. " + error.message);
            }
        }

        document.getElementById('cartForm').addEventListener('submit', function(event) {
            event.preventDefault(); 

            const form = event.target;
            const formData = new FormData();

            document.querySelectorAll('.itemCheckbox:checked').forEach(checkbox => {
                const container = checkbox.closest('.box-container');
                const cartIdx = checkbox.value;
                const quantity = container.querySelector('.itemQuantity').textContent;
                const price = container.querySelector('.itemPrice').textContent.replace(/,/g, '');

                formData.append('selectedItems', cartIdx);
                formData.append('quantity_' + cartIdx, quantity);
                formData.append('price_' + cartIdx, price);
            });

            fetch(form.action, {
                method: form.method,
                body: formData
            }).then(response => {
                if (response.ok) {
                    window.location.href = response.url; 
                } else {
                    alert('Error submitting form');
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('Error submitting form');
            });
        });

        updateBuyButton();
    </script>
    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
