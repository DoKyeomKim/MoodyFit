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
        background-color: #F6F4EE;
        margin: 0;
        padding: 0;
    }

    main {
        width: 60%;
        font-size: 15px;
        margin: 70px auto;
    }

    .container {
        background-color: #FFFFFF;
        padding: 20px;
        border-radius: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    .flex-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .author {
        font-size: 14px;
        color: #666;
    }

    .content {
        min-height: 200px;
        margin-bottom: 20px;
    }

    .answer-container {
        margin-top: 20px;
        display: none; /* Initially hide the answer container */
    }
       button.submit-btn, .button-container button {
       margin-bottom: 10px;

        width: 80px;
        align-self: center;
        background-color: #E5AAA3;
        color: white;
        cursor: pointer;
        border-radius: 10px !important;
        border: none;
        height: 40px;
    }

   

    .button-container {
        text-align: center;
        margin-top: 20px;


</style>
</head>
<body style="background-color:#F6F4EE !important;">
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
                </div>
            </div>
        </div>
                     <div class="button-container">
                    <button onclick="window.history.back()">목록</button>
                    </div>
    </main>
</body>
</html>
