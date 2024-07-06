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

main {
  display: flex;
  flex-direction: column;
}

.status {
  display: flex;
  justify-content: space-around;
  align-items: center;

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

.my-postings {
  width: 100%;
  margin-top: 50px;
}

.my-postings h2 {
  text-align: center;
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
}

</style>

</head>
<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>
<body style="background-color:#F6F4EE !important;">
    <main>
<div class="container">
    <div class="row">
        <div class="text-center">
            <h2 style="text-align: center; font-size: 35px; font-weight: 600; color: #867B73;">마이페이지</h2>
        </div>
    </div>
        <h3 style="text-align: left; margin-bottom:50px; padding-top: 50px;">${store.storeName} 님</h3>
<div class="status1" style="background-color:white; border-radius:20px;" >

        <div class="status">
            <div class="status-box">
                <h3>0</h3>
                <p>등록한 공고 수</p>
            </div>
            <div class="status-box">
                <h3>0</h3>
                <p>등록한 제품 수</p>
            </div>
            <div class="status-box">
                <h3>0</h3>
                <p>총 주문 건수</p>
            </div>
            <div class="status-box">
                <h3>0</h3>
                <p>총 판매 건수</p>
            </div>
        </div>
        <div class="my-postings">
            <h2>제품 판매 순위</h2>
        </div>
</div>
</div>
    </main>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.add('loaded');
});
</script>
</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
