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

</style>

</head>
<body>
	<%@include file="/WEB-INF/layouts/header.jsp"%>
	<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

	<h5 style="text-align: center; margin-top: 50px;">${store.storeName} 님 반갑습니다.</h5>
		<hr>
			
	    <main style="margin-top: 70px;">
        <div class="status">
            <div class="status-box">
                <h3>
					0
				</h3>
                <p>등록한 공고 수</p>
            </div>
            <div class="status-box">
                <h3>
					0
				</h3>
                <p>등록한 제품 수</p>
            </div>
            <div class="status-box">
                <h3>
					0
                </h3>
                <p>총 주문 건수</p>
            </div>
            <div class="status-box">
				<h3>
					0
                </h3>
                <p>총 판매 건수</p>
            </div>
        </div>
        <div class="my-postings">
        	<h2>제품 판매 순위</h2>
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