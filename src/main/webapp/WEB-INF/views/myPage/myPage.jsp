<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mypagestyle.css">
<style>
#person-level{
margin-left:10px;
}
.modal-btn{
	border : none;
	background-color: transparent; 
	padding: 0;
}
.person-level-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 18px;
    text-align: left;
}
.person-level-table thead tr {
    background-color: black;
    color: #ffffff;
    text-align: left;
}
.person-level-table th, .person-level-table td {
    padding: 12px 15px;
    border: 1px solid #dddddd;
}
.person-level-table tbody tr:nth-child(even) {
    background-color: #f3f3f3;
}
.posting-info {
    transition: background-color 0.3s;
}
.level-img{
	height: 40px;
	width: auto;
	margin-right : 15px;
}
.person-level-name{
	display:flex;
	align-items: center;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>
    <div class="container mt-5">
        <div class="row">
            <div class="col-12 text-center">
                <h2 style="text-align: center; margin-top: 120px; font-size: 35px; font-weight: 600; color: #867B73;">마이페이지</h2>
            </div>
        </div>
        
        <div class="row profile-section mt-4">
            <div class="col-6 profile-info">
                <h2>${person.nickName}님</h2>
                <button type="button" class="modal-btn" data-bs-toggle="modal" data-bs-target="#levelModal">
                <img src="/images/${levelName}.png" id="person-level">
                </button>
                
            </div>
            <div class="col-3 profile-stats text-right">
                <ul>
                    <li>쿠폰 <span>${user.couponCount}</span>개</li>
                    <li>적립금 <span>${user.points}</span>원</li>
                    <li>장바구니 <span>${user.cartItems}</span>개</li>
                </ul>
            </div>
        </div>
        
        <div class="row order-status mt-4">
            <div class="col-12">
                <div class="status-box">
                    <div class="row">
                        <div class="col text-center">
                            <h3>배송준비중</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderPrePare}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderPrePare}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <h3>배송중</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderIng}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderIng}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <h3>배송완료</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${empty orderDone}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${orderDone}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col text-center">
                            <ul>
                                <li>취소: ${orderCanceled}</li>
                                <li>교환: ${orderExchanged}</li>
                                <li>환불: ${orderRefunded}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-5 recent-views">
            <div class="col-12">
                <h2>최근 본 공고</h2>
                <!-- 최근 본 공고 리스트 추가 -->
            </div>
        </div>
    </div>

<div class="modal fade" id="levelModal" tabindex="-1" aria-labelledby="levelModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl"> <!-- modal-xl로 변경 -->
    <div class="modal-content overflow-auto">
      <div class="modal-header">
        <h5 class="modal-title" id="levelModalLabel">공고 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="person-level-table">
            <thead>
                <tr>
                    <th>등급</th>
                    <th>가격</th>
                    <th>할인율</th>
                </tr>
            </thead>
            <tbody>
                    <c:forEach var="personLevel" items="${personLevel}">
	                    <tr class="posting-info">
	                        <td><span class="person-level-name"><img src="/images/${personLevel.name }.png" class="level-img" alt="level-img">${personLevel.name }</span></td>
        					<td><span id="purchase">${personLevel.purchase}원 이상</span></td>
	                        <td>${Math.round(personLevel.benefit * 100)}%</td>
	                    </tr>
                    </c:forEach>
            </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

    <%@include file="/WEB-INF/layouts/footer.jsp"%>

<script>
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.add('loaded');

});
</script>

</body>
</html>
