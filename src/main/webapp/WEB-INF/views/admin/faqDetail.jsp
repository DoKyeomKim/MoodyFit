<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 상세</title>
<style>
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
}

main {
    width: 90%;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    font-size: 15px;
    margin-top: 20px;
}



hr {
    border: none;
    border-top: 1px solid #ccc;
    margin: 20px 0;
}

.flex-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.text-right {
    text-align: right;
}

.author {
    font-size: 14px;
    color: #666;
}

.container {
    margin-top: 20px;
}
p{
height : 300px;
}
.button-container {
    text-align: center;
    margin-left: 200px;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <div class="col-sidebar">
    </div>
    <main>
        <h3 class="mt-3 text-center">쇼핑몰 이용안내(FAQ)</h3>
        <hr class="mb-3">
        <div class="container mt-3">
            <div class="row">
                <div>
                    <div class="flex-container">
                        <div style="font-weight: bold;">${faq.title}</div>
                        <div class="author">
                            작성자: 관리자
                        </div>
                    </div>
                    <hr>
                    <p>${faq.content}</p>
                     <div class="button-container">
                    <button onclick="window.history.back()">목록</button>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
