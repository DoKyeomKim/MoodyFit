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
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
                    style="border: 1px solid black; padding: 2% 5%; margin: 2% 5%; display: flex; justify-content: space-evenly;">
                    <div class="form-check" style="display: flex; flex-direction: column; justify-content: space-evenly; width:30%;">
					  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault${de.deliveryIdx}" value="${de.isDefault}" ${de.isDefault == 1 ? 'checked' : ''}>
					  <label class="form-check-label" for="flexRadioDefault${de.deliveryIdx}">기본 배송지 설정</label>
					</div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly; width:50%;">
                        <div class="box" name="name">이름 : ${de.name}</div>
                        <div class="box" name="postCode">우편번호 : ${de.postCode}</div>
                        <div class="box" name="address">주소 : ${de.address}</div>
                        <div class="box" name="detailAddress">상세주소 : ${de.detailAddress}</div>
                        <div class="box" name="content">요청사항 : ${de.content}</div>
                    </div>
                    <div style="display: flex; flex-direction: column; justify-content: space-evenly; width:20%;">
                        <div class="box" name="deliveryName" 
                        style="border: 1px solid black; border-radius: 80px; text-align: center;  font-size:large;
                        display: flex; justify-content: space-evenly;">${de.deliveryName}</div>
                        <div style="display: flex; align-items: center; justify-content: space-evenly;">
                            <button type="button" class="btn btn-success" onclick="editDelivery('${de.deliveryIdx}')">수정</button>
                            <button type="button" class="btn btn-danger" onclick="removeDelivery('${de.deliveryIdx}')">삭제</button>
                        </div>
                    </div>
                </div>

            </c:forEach>
			<button class="btn btn-primary" style="margin:20px;" onclick="addDelivery()">배송지 추가</button>
			<button class="btn btn-primary" style="margin:20px;" onclick="updateDelivery()">기본 배송지 변경</button>
      
       <!-- Modal -->
<div id="deliveryModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">배송지 추가</h5>
                <button type="button" class="close" onclick="closeModal()" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="deliveryForm" method="post" onsubmit="submitForm(event)">
                    <input type="hidden" name="personIdx" value="${personIdx}">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="name">수취인:</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="deliveryName">배송지 이름:</label>
                            <input type="text" class="form-control" id="deliveryName" name="deliveryName" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="email">이메일:</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone">연락처:</label>
                            <input type="text" class="form-control" id="phone" name="phone" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content">요청사항:</label>
                        <input type="text" class="form-control" id="content" name="content" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label for="sample6_postcode">우편번호:</label>
                            <input type="text" class="form-control" name="postCode" id="sample6_postcode" placeholder="우편번호">
                        </div>
                        <div class="form-group col-md-2">
                            <label>&nbsp;</label>
                            <button type="button" class="btn btn-secondary btn-block" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sample6_address">주소:</label>
                        <input type="text" class="form-control" name="address" id="sample6_address" placeholder="주소">
                    </div>
                    <div class="form-group">
                        <label for="sample6_detailAddress">상세주소:</label>
                        <input type="text" class="form-control" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소를 입력해주세요">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal()">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

       <!-- Modal -->
<div id="deliveryModal2" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">배송지 추가</h5>
                <button type="button" class="close" onclick="closeModal()" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="deliveryForm" method="post" onsubmit="submitForm(event)">
                    <input type="hidden" name="personIdx" value="${personIdx}">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="name">수취인:</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="deliveryName">배송지 이름:</label>
                            <input type="text" class="form-control" id="deliveryName" name="deliveryName" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="email">이메일:</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone">연락처:</label>
                            <input type="text" class="form-control" id="phone" name="phone" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content">요청사항:</label>
                        <input type="text" class="form-control" id="content" name="content" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label for="sample6_postcode">우편번호:</label>
                            <input type="text" class="form-control" name="postCode" id="sample6_postcode" placeholder="우편번호">
                        </div>
                        <div class="form-group col-md-2">
                            <label>&nbsp;</label>
                            <button type="button" class="btn btn-secondary btn-block" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sample6_address">주소:</label>
                        <input type="text" class="form-control" name="address" id="sample6_address" placeholder="주소">
                    </div>
                    <div class="form-group">
                        <label for="sample6_detailAddress">상세주소:</label>
                        <input type="text" class="form-control" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소를 입력해주세요">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal()">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
   

    </main>
    <!-- jQuery Core -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Popper.js -->
	<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <!-- Bootstrap JS -->
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    
    async function editDelivery(deliveryIdx) {
        try {
            const response = await fetch(`/myPage/getDelivery?deliveryIdx=${deliveryIdx}`);
            if (!response.ok) {
                throw new Error('배송지 정보를 가져오는 데 실패했습니다.');
            }
            const delivery = await response.json();
            
            // Modal2에 데이터 채우기
            $('#deliveryModal2').modal('show'); // 모달2 열기
            $('#deliveryForm input[name="personIdx"]').val(delivery.personIdx);
            $('#deliveryForm input[name="name"]').val(delivery.name);
            $('#deliveryForm input[name="deliveryName"]').val(delivery.deliveryName);
            $('#deliveryForm input[name="email"]').val(delivery.email);
            $('#deliveryForm input[name="phone"]').val(delivery.phone);
            $('#deliveryForm input[name="content"]').val(delivery.content);
            $('#deliveryForm input[name="postCode"]').val(delivery.postCode);
            $('#deliveryForm input[name="address"]').val(delivery.address);
            $('#deliveryForm input[name="detailAddress"]').val(delivery.detailAddress);
        } catch (error) {
            console.error('Error:', error.message);
            alert('배송지 정보를 가져오는 데 실패했습니다.');
        }
    }

    async function removeDelivery(deliveryIdx) {
        try {
            const response = await fetch('/myPage/deleteDelivery', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=utf-8'
                },
                body: JSON.stringify({ deliveryIdx: deliveryIdx })
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


    function updateDelivery() {
        var selectedId = $("input[name='flexRadioDefault']:checked").attr("id").replace("flexRadioDefault", "");
        
        if (selectedId) {
            // Set current default to 0 and selected to 1
            $.ajax({
                type: "POST",
                url: "/myPage/updateDelivery",
                data: { deliveryIdx: selectedId, isDefault: 1 },
                success: function(response) {
                    alert("기본 배송지가 변경되었습니다.");
                    location.reload(); // Reload the page to reflect the changes
                },
                error: function(xhr, status, error) {
                    alert("기본 배송지 변경에 실패했습니다.");
                }
            });
        } else {
            alert("기본 배송지를 선택하세요.");
        }
    }

    // Ensure correct radio button is checked on page load
    $(document).ready(function() {
        $("input.form-check-input").each(function() {
            if ($(this).val() == '1') {
                $(this).prop("checked", true);
            }
        });
    });
</script>
    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
