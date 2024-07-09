<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
main {
   padding-left: 200px;
}
.delete-btn{
 background: none;
    border: none;
    color: #FF6F61;
    cursor: pointer;
    font-size: 18px;
    margin-left: 10px;}
.modal-lg {
   max-width: 800px;
}
.price{
font-weight:bold;}
.card {
   border: 1px solid #ccc;
   border-radius: 10px;
}

.card-body {
   display: flex;
   flex-direction: column;
   align-items: flex-start;
}

.card-title {
   font-size: 1.25rem;
   margin-bottom: 0.75rem;
}

.card-text {
   margin-bottom: 0.5rem;
}

.table thead th {
    text-align: center;
    vertical-align: middle;
    border-top: 2px solid #dee2e6;
    border-bottom: 2px solid #dee2e6;
    font-size:14px;
}

.table tbody td {
    text-align: center;
    vertical-align: middle;
    border-top: 1px solid #dee2e6;
    border-bottom: 1px solid #dee2e6;
    font-size:16px;
}
.box-container{
 border-top: 1px solid #ccc; /* 상단 구분선 추가 */
        border-bottom: 1px solid #ccc; /* 하단 구분선 추가 */
        padding: 2% 5%;
        display: flex;
        justify-content: space-evenly;
        font-size: 15px;}

.btn-main {
 margin-bottom: 10px;
    width: 100px;
    align-self: center;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    font-size: 14px;
    border: none;
    height: 50px;
    border-radius:10px;
}
.payment-btn {
    margin: 20px;
    float: right; /* 버튼을 오른쪽으로 정렬 */
    background-color: black; /* 버튼 배경색 */
    color: white; /* 버튼 글자색 */
    font-size: 14px;
    border: none;
    border-radius: 10px;
    padding: 10px 20px;
    cursor: pointer;
}
</style>

</head>
<body style="background-color:#F6F4EE !important;">
   <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>

   <%@include file="/WEB-INF/layouts/aside.jsp"%>

   <main style="width: 80%;">

        <h3 style="font-weight: bold; text-align: center;">주문서작성</h3>
        
        <h4 style="text-align: left; font-weight: bold; margin-top: 30px; margin-left: 100px;">주문상품</h4>
    <div class="order-container" style="background-color:white; padding: 20px; margin: 20px; border-radius: 20px;">
        
        <c:choose>
            <c:when test="${empty cartList}">
                <div style="text-align: center; margin-top: 50px;">
                    <h3 style="margin: 100px 30px;">주문목록이 비어있습니다.</h3>
                    <hr>
                </div>
                <div style="text-align: center; margin-right: 20px;">
                    <button type="button" class="btn-main" style="margin: 20px;" onclick="location.href='/'">홈으로</button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="payment-container" style="background-color:white;">
                    <c:set var="totalOrderPrice" value="0" scope="page" />
                    <form action="/myPage/cartQuantity" method="post" id="quantituyForm">
                        <table class="table ">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>상품정보</th>
                                    <th>상품명</th>
                               
                                    <th>가격</th>
                                    <th>수량</th>
                                    <th>총 금액</th>
                                   <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartList}">
                                    <input type="hidden" value="${item.cartIdx}" class="hiddenCartIdx">
                                    <c:set var="itemTotalPrice" value="${item.price * item.quantity}" />
                                    <c:set var="totalOrderPrice" value="${totalOrderPrice + itemTotalPrice}" />
                                    <c:set var="totalQuantity" value="${totalQuantity + item.quantity}" />
                                    <tr>
                                        <td><img src="${item.filePath}" style="width: 110px; height: 110px;"/></td>
                                        <td>${item.title}</td>
                                        <td>${item.name}</td>
                                        
                                        <td>${item.price}원</td>
                                        <td>${item.quantity}개</td>
                                        <td style="color:#d0591f; font-weight:bold;">${item.price * item.quantity}원</td>
                                        <td><button type="button" class="delete-btn" onclick="removeItem('${item.cartIdx}')">X</button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </div>

                <h4 style="text-align: left; margin-top: 50px; margin-left: 50px; font-size:16px ; font-weight:bold;">배송지</h4>
                <div class="box-container" style="background-color:white; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly;">
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" style="display:none;" name="deliveryIdx">${deliveryDto.deliveryIdx}</div>
                        <div class="box" name="name">이름 : ${deliveryDto.name}</div>
                        <div class="box" name="postCode">우편번호 : ${deliveryDto.postCode}</div>
                        <div class="box" name="address">주소 : ${deliveryDto.address}</div>
                        <div class="box" name="detailAddress">상세주소 : ${deliveryDto.detailAddress}</div>
                        <div class="box" name="content">요청사항 : ${deliveryDto.content}</div>
                    </div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="deliveryName" style="border: 1px solid black; border-radius: 80px; text-align: center;">
                            ${deliveryDto.deliveryName}
                        </div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div>
                            <button type="button" class="btn btn-secondary" onclick="showAddressModal()">배송지 변경</button>
                        </div>
                    </div>
                </div>

             <div class="box-container" style="background-color:white; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly; flex-direction: column;">
    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
        <form action="/myPage/orderMake" method="post" id="purchaseForm">
            <div class="box" style="text-align: left;">
                <h4 style="text-align: left; margin-top: 50px; margin-left: 20px; font-size:16px; font-weight:bold;">주문예상금액</h4>
            </div>
            <div class="payment"  style="display: flex; flex-direction: column; justify-content: space-evenly;">
                <input type="hidden" name="deliveryIdx" value="${deliveryDto.deliveryIdx}">
                <input type="hidden" name="personIdx" value="${deliveryDto.personIdx}">
                <div style="text-align: right; margin: 10px 0;">총 상품 금액: <input type="text" name="price" value="${totalOrderPrice}" readonly style="border: none; background: none; text-align: right;"> 원</div>
                <div style="text-align: right; margin: 10px 0;">총 수량: <input type="text" name="quantity" value="${totalQuantity}" readonly style="border: none; background: none; text-align: right;"> 개</div>
                <div style="text-align: right; margin: 10px 0;">배송비: <input type="text" name="deliveryPrice" value="3000" readonly style="border: none; background: none; text-align: right;"> 원</div>
                <div style="text-align: right; margin: 10px 0;">할인금액: <input type="text" name="discount" class="price2" value="${(totalOrderPrice + 3000) * discount}" readonly style="border: none; background: none; text-align: right;"> 원</div>
                <hr style="border: 1px solid black; margin: 20px 0;">
                <div style="text-align: right; margin: 10px 0;">
                    총 결제금액: <input type="text" class="price" value="${(totalOrderPrice + 3000) * (1 - discount)}" id="finalPrice" readonly style="border: none; background: none; text-align: right; color:#d0591f;"> 원
                </div>
            </div>
            <button type="button" class="payment-btn" onclick="window.location.href='/'" style="background-color: white; color: black; padding: 10px 20px; border: 1px solid black; font-size: 16px;">취소</button>
            <button type="button" id="addToCartButton" class="payment-btn"   style="margin: 20px; background-color: black; color: white; padding: 10px 20px; border: none; font-size: 16px;">결제하기</button>
        </form>
    </div>
</div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

      <!-- 배송지 변경 모달 -->
      <div class="modal" id="addressModal" tabindex="-1" role="dialog"
         aria-labelledby="addressModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h4 class="modal-title" id="addressModalLabel">배송지 선택</h4>
                     <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <!-- 자신의 배송지 목록을 보여주기 -->
                  <c:forEach var="de" items="${deliveryList}">
                     <div class="card mb-3">
                        <div class="card-body">
                           <h5 class="card-title">${de.deliveryName}</h5>
                           <p class="card-text">${de.address}</p>
                           <p class="card-text">${de.detailAddress}</p>
                           <button type="button" class="btn btn-primary"
                              onclick="selectAddress('${de.deliveryName}', '${de.address}', '${de.detailAddress}', '${de.name}', '${de.postCode}', '${de.content}', '${de.deliveryIdx}')">선택</button>
                        </div>
                     </div>
                  </c:forEach>
                  <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal()">닫기</button>
                        </div>
               </div>
            </div>
         </div>
      </div>

   
      <script src="/js/bootstrap.bundle.min.js"></script>
      <script>
      document.getElementById("addToCartButton").addEventListener("click", async (event) => {
          event.preventDefault();

          // cartIdx 값들을 담을 배열 초기화
          let cartIdxArray = [];
          document.querySelectorAll('.hiddenCartIdx').forEach(hidden => {
              cartIdxArray.push(parseInt(hidden.value));
          });

          const basketData1 = {
              cartIdxArray: cartIdxArray,
              price: parseInt(document.querySelector("input[name='price']").value),
              quantity: parseInt(document.querySelector("input[name='quantity']").value),
              deliveryPrice: parseInt(document.querySelector("input[name='deliveryPrice']").value),
              deliveryIdx: parseInt(document.querySelector('.box[name="deliveryIdx"]').textContent),
              personIdx: parseInt(document.querySelector("input[name='personIdx']").value)
          };

          const basketData2 = {
              price: parseInt(document.querySelector("input[name='price']").value),
              quantity: parseInt(document.querySelector("input[name='quantity']").value),
              deliveryPrice: parseInt(document.querySelector("input[name='deliveryPrice']").value),
              deliveryIdx: parseInt(document.querySelector('.box[name="deliveryIdx"]').textContent),
              personIdx: parseInt(document.querySelector("input[name='personIdx']").value)
          };

          try {
              const response1 = await fetch('/myPage/cartQuantity', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(basketData1)
              });

              const data1 = await response1.json();

              if (data1.status === 'success') {
                  const response2 = await fetch('/myPage/orderMake', {
                      method: 'POST',
                      headers: {
                          'Content-Type': 'application/json'
                      },
                      body: JSON.stringify(basketData1)
                  });

                  const data2 = await response2.json();

                  if (data2.status === 'success') {
                      alert('주문내역 생성!');
                      window.location.href = '/myPage/payPay';
                  } else {
                      alert('주문내역 생성실패!');
                      window.location.href = '/myPage/payment';
                  }
              } else {
                  alert('장바구니 업데이트 실패!');
                  window.location.href = '/myPage/cartQuantity';
              }
          } catch (error) {
              console.error('Error:', error);
              alert('실패!');
              window.location.href = '/myPage/payment';
          }
      });
   
   
   
   
   // 배송지 변경 모달 표시
   
    var modal = document.getElementById("addressModal");
    function showAddressModal() {
        modal.style.display = "block";
    }

    function closeModal() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    
    

   // 배송지 선택
   function selectAddress(deliveryName, address, detailAddress, name, postCode, content, deliveryIdx) {
      document.querySelector('.box[name="name"]').textContent = name;
      document.querySelector('.box[name="postCode"]').textContent = postCode;
      document.querySelector('.box[name="address"]').textContent = address;
      document.querySelector('.box[name="detailAddress"]').textContent = detailAddress;
      document.querySelector('.box[name="content"]').textContent = content;
      document.querySelector('.box[name="deliveryName"]').textContent = deliveryName;
      document.querySelector('.box[name="deliveryIdx"]').textContent = deliveryIdx;
       modal.style.display = "none";
   }
   
      async function removeItem(cartIdx) {
          try {
              const response = await fetch('/myPage/deleteCart2', {
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
                  location.reload(); // 페이지 새로고침
              } else {
                  throw new Error("삭제에 실패했습니다.");
              }
          } catch (error) {
              alert("삭제에 실패했습니다. " + error.message);
          }
      }
      /*
      async function mypayment() {
           const myAmount = Number(document.getElementById("finalPrice").value);
           const myMerchantUid = document.getElementById("merchantUid").value;

           const IMP = window.IMP; // 생략 가능
           IMP.init("imp68777271"); // Example: imp68777271
           IMP.request_pay(
             {
               // paramW
               pg: "tosspayments",
               pay_method: "card",
               name: "에어포스",
               amount: myAmount,
               merchant_uid: myMerchantUid,
               buyer_email: "hase9708@naver.com",
               buyer_name: "하세연",
               buyer_tel: "010-8552-7537",
               buyer_addr: "부산광역시 북구 화명동",
               buyer_postcode: "46534"
             },
             (response) => {
                   fetch(`/api/postToken?impUid=${response.imp_uid}`, {
                       method: "POST",
                       headers: { "Content-Type": "application/json" },
                       body: JSON.stringify({
                           impUid: response.imp_uid
                       }),
                   })
                   .then(res => res.ok ? res.text() : Promise.reject(res.statusText))
                   .then(data => {
                       console.log('Success:', data);
                       alert("결제가 완료되었습니다!");
                       window.location.href = "/myPage";
                   })
                   .catch(error => {
                       console.error('Error:', error);
                       alert("결제 실패!");
                       window.location.href = "/myPage/payment";
                   });
               });
           }
        */   
        
       // 모든 price 클래스를 가진 입력 태그들을 선택하여 처리
        var prices = document.querySelectorAll('.price');
        prices.forEach(function(input) {
            // 입력 태그의 값에서 소수점 이후의 부분을 제거하고 정수로 변환
            var value = input.value.trim(); // 값의 앞뒤 공백을 제거
            var integerValue = parseInt(value.split('.')[0], 10); // 점(.) 이후의 부분을 제거하고 정수로 변환

            // 정수로 변환된 값을 다시 입력 태그의 값으로 설정
            input.value = integerValue.toLocaleString();
        });
        
       // 모든 price 클래스를 가진 입력 태그들을 선택하여 처리
        var prices = document.querySelectorAll('.price2');
        prices.forEach(function(input) {
            // 입력 태그의 값에서 소수점 이후의 부분을 제거하고 정수로 변환
            var value = input.value.trim(); // 값의 앞뒤 공백을 제거
            var integerValue = parseInt(value.split('.')[0], 10); // 점(.) 이후의 부분을 제거하고 정수로 변환

            // 정수로 변환된 값에 마이너스 기호를 붙이기
            var formattedValue = '-' + Math.abs(integerValue).toLocaleString(); // 절댓값으로 변환 후 천 단위로 구분된 문자열로 변환

            // 입력 태그의 값으로 설정
            input.value = formattedValue;
        });
        
</script>
</body>
   <%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
