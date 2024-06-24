<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Q&A 등록</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
        }
        main {
            width: 90%;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            font-size : 15px;
        }
        .table td {
            padding: 30px; /* 셀 내부 여백 조정 */
            margin: 30px; /* 셀 외부 여백 조정 */
        }
        .container {
            display: flex;
            flex-wrap: wrap;
        }
        .container > * {
            flex: 1;
            margin-right: 30px; /* Adjust as needed */
        }
        .container > *:last-child {
            margin-right: 0;
        }
        /* Adjust column widths as needed */
        .col-main {
            flex: 3; /* Main content width */
        }
        .col-sidebar {
            flex: 1; /* Sidebar content width */
            margin-top:30px;
        }
        form {
            margin-top: 20px;
        }
        table td {
            height: 50px;
            padding: 10px 0;
            border-bottom: 1px solid #e5e5e5;
            width:50%;
            vertical-align: middle; /* 수직 정렬을 중앙으로 맞춤 */
        }
        table td:first-child {
            width: 150px;
            font-weight: bold;
        }
        input[type="text"], input[type="file"] {
            height:30px;
            width:300px;
        }
        input[type="submit"],
        input[type="button"] {
            background-color: #111111;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left:188%;
        }
        input[type="button"] {
            background-color: #f4f4f4;
            color: #333;
        }
        textarea {
            width: 300%;
            height: 100px;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
            resize: vertical; /* 수직으로만 크기 조정 */
        }

        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            align-items: center; /* 수직 정렬을 중앙으로 맞춤 */
        }

        .rating input {
            display: none;
        }

        .rating label {
            position: relative;
            width: 1em;
            font-size: 3vw;
            color: #FFD600;
            cursor: pointer;
        }

        .rating label::before {
            content: "★";
            position: absolute;
            opacity: 0;
        }

        .rating label:hover:before,
        .rating label:hover ~ label:before {
            opacity: 1 !important;
        }

        .rating input:checked ~ label:before {
            opacity: 1;
        }

        .rating input:checked + label:hover:before,
        .rating input:checked + label:hover ~ label:before,
        .rating input:checked ~ label:hover:before,
        .rating input:checked ~ label:hover ~ label:before,
        .rating label:hover ~ input:checked ~ label:before {
            opacity: 0.4;
        }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%> 
    <div class="col-sidebar"></div>
    <main>
        <h2>리뷰 등록</h2>
        <form action="/admin/reviewWrite" method="POST" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" /></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea name="content"></textarea></td>
                </tr>
                <tr>
                    <td>별점</td>
                    <td>
                        <div class="rating">
                            <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="5 stars"></label>
                            <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 stars"></label>
                            <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="3 stars"></label>
                            <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 stars"></label>
                            <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="1 star"></label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>사진 업로드</td>
                    <td><input type="file" name="image" accept="image/*" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="저장" />
                    </td>
                </tr>
            </table>
        </form>
    </main>
</body>
</html>
