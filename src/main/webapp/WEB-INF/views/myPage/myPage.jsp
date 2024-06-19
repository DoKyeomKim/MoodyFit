<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>
body {
    visibility: hidden;
    opacity: 0;
    transition: visibility 0s, opacity 1s ease;
    margin : 0;
}
body.loaded {
    visibility: visible;
    opacity: 1;
}
main {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  margin: 0 auto;
  margin-top:50px;
  max-width: 1000px;
}

.status {
  display: flex;
  justify-content: space-around;
  align-items: center;
  border: 1px solid #ccc;
  width: 100%;
  margin: auto;
  padding: 20px;
  box-sizing: border-box;
}

.status-box {
  width: 150px;
  height: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: #fff;
  margin: 0 10px;
  flex: 1;
  border-right: 0.5px solid #ccc;
}

.status-box:last-child {
  border-right: none;
}

.status-box h3 {
  font-size: 24px;
  font-weight: bold;
  margin: 0;
  color: #333;
}

.status-box p {
  font-size: 16px;
  margin: 5px 0 0 0;
  color: #666;
}

.status-box ul {
  list-style-type: none;
  padding: 0;
  margin-top: 10px;
  font-size:13px;
}

.status-box ul li {
  margin: 5px 0;
}
</style>

</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <h2 style="text-align: center; margin-top: 50px;">${person.nickName}님 반갑습니다.</h2>
    <hr>
    <%@include file="/WEB-INF/layouts/aside.jsp"%>

    <main style="margin-top: 70px;">
        <div class="status">
            <div class="status-box">
                <h3>
                	<c:choose>
						<c:when test="${empty orderPrePare}">
							0
						</c:when>
						<c:otherwise>
							${orderPrePare}
						</c:otherwise>
					</c:choose>
				</h3>
                <p>배송준비중</p>
            </div>
            <div class="status-box">
                <h3>
					<c:choose>
						<c:when test="${empty orderIng}">
							0
						</c:when>
						<c:otherwise>
							${orderIng}
						</c:otherwise>
					</c:choose>
				</h3>
                <p>배송중</p>
            </div>
            <div class="status-box">
                <h3>
                	<c:choose>
						<c:when test="${empty orderDone}">
							0
						</c:when>
						<c:otherwise>
							${orderDone}
						</c:otherwise>
					</c:choose>
                </h3>
                <p>배송완료</p>
            </div>
            <div class="status-box">
            	<ul>
            		<li>취소 : </li>
            		<li>교환 : </li>
            		<li>환불 : </li>
            	</ul>
            </div>
        </div>
        
        <div class="recent-post mt-5" >
        	<h2>최근 본 공고 영역</h2>
        </div>
    </main>

<script src="/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.add('loaded');
});
</script>
</body>
</html>