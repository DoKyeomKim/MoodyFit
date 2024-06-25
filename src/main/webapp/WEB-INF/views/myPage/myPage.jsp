<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mypagestyle.css">
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

    <%@include file="/WEB-INF/layouts/footer.jsp"%>

<script>
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.add('loaded');
});
</script>
</body>
</html>
