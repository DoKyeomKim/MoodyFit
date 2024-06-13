<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 관리</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
main{
    width: 80%;
    padding-left:200px;
}
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
    height: 60%;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>

</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
        <h2 style="text-align:left; margin-top:30px; margin-left : 100px;"> 배송지 관리</h2>
        <hr>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>

    <main style="margin-top:30px; width:90%; ">

       
            <c:forEach var="de" items="${deliveryList}">

                <div class="box-container"
                    style="border: 1px solid black; padding: 20px; margin: 5px 10px; display: flex; justify-content: space-evenly;">
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="name">${de.name}</div>
                        <div class="box" name="postCode">${de.postCode}</div>
                        <div class="box" name="address">${de.address}</div>
                        <div class="box" name="detailAddress">${de.detailAddress}</div>
                        <div class="box" name="content">${de.content}</div>
                    </div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly;">
                        <div class="box" name="deliveryName" 
                        style="border: 1px solid black; border-radius: 80px; text-align: center;">${de.deliveryName}</div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div>
                            <button type="button" onclick="removeItem(this)">수정</button>
                            <button type="button" onclick="removeItem(this)">삭제</button>
                        </div>
                    </div>
                </div>

            </c:forEach>
			<button class="btn btn-primary" style="margin:20px;" onclick="addDelivery()">배송지 추가</button>
      
       <!-- Modal -->
    <div id="deliveryModal" class="modal">
        <div class="modal-content">
        	<div style="display:flex;">
            <div style="text-align: left;"><h2>배송지 추가</h2></div>
            <div style="text-align: right;"><button class="close" onclick="closeModal()" >&times;</button></div>
            </div>
            <hr> <!--action="/myPage/addDelivery"  -->
            <form id="deliveryForm" method="post" onsubmit="submitForm(event)">
            <input type="hidden" name="personIdx" value="${personIdx}" >
            <div class="box-container"  style="display:flex; justify-content: space-evenly;">
            		<div class="box-container"  style="display: flex; flex-direction: column; justify-content: space-evenly;">
							<div>
							<label for="name">수취인:</label>
							<input type="text" id="name" name="name" required>
							</div>
							<div>
							<label for="deliveryName">배송지 이름:</label>
							<input type="text" id="deliveryName" name="deliveryName" required>
							</div>
							<div>
							<label for="email">이메일:</label>
							<input type="text" id="email" name="email">
							</div>
							<div>
							<label for="phone">연락처:</label>
							<input type="text" id="phone" name="phone" required>
							</div>
							<div>
							<label for="content">요청사항:</label>
							<input type="text" id="content" name="content" required>
							</div>
					</div>
					<div class="box-container"  style="display: flex; flex-direction: column; justify-content: space-evenly;">		
						<div>
						<table>
						<tr>
							<th>우편번호</th>
							<td><input type="text" name="postCode" id="sample6_postcode"
								placeholder="우편번호" style="margin-right: 30px; width: 20%;"><input
								type="button" class="btn btn-secondary"
								onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" name="address" id="sample6_address"
								style="width: 60%;" placeholder="주소"></td>
						</tr>
						<tr>
							<th>상세주소</th>
							<td><input type="text" name="detailAddress"
								id="sample6_detailAddress" style="width: 60%;"
								placeholder="상세주소를 입력해주세요"></td>
						</tr>
						</table>
						</div>
							
							<div >
							<button type="submit">저장</button>
							</div>
						</div>
						</div>
					</form>
        </div>
    </div>
   

    </main>
	
    <script>
    var modal = document.getElementById("deliveryModal");

    function addDelivery() {
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

    function submitForm(event) {
        event.preventDefault();
        
        var form = document.getElementById('deliveryForm');
        var formData = new FormData(form);
        
        var params = new URLSearchParams();
        formData.forEach((value, key) => {
            params.append(key, value);
        });

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/myPage/addDelivery', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        xhr.onload = function () {
            if (xhr.status === 200) {
                alert('배송지가 추가되었습니다.');
                closeModal();
                location.reload();  // 현재 페이지 새로고침
            } else {
                alert('배송지 추가에 실패했습니다.');
            }
        };

        xhr.send(params.toString());
    }
				</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
