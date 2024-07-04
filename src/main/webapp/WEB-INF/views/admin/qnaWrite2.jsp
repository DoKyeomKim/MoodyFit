<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>상품문의</title>
      <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
            background-color: #F6F4EE;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        main {
            width: 100%;
            background-color: #F6F4EE;
            padding: 80px;
            font-size: 15px;
            margin-top: 70px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        form {
            width: 100%;
            max-width: 900px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            text-align: left;
        }

        input[type="text"] {
            width: calc(100% - 20px);
            height: 30px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            width: calc(100% - 20px);
            height: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            resize: vertical;
        }

        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            margin-right: 33px;
            padding:20px;
        }

        input[type="submit"] {
            background-color: #f2eaeaa8;
            color: #B68555;
            border: 1px solid #B68555;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            
        }

        .link-button {
            text-decoration: none;
            background-color: #EBDACB;
            color: #B68555;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 16px;
            display: inline-block;
            border: 1px solid #B68555;
            text-align: center;
              margin-right: 15px; 
        }

        .link-button:hover,
        input[type="submit"]:hover {
            background-color: #D1C0B0;
        }

        h2.text-center {
            font-weight: bold;
            color: #867B73;
            text-align: center;
            margin: 0;
            margin-bottom:20px;
            
        }
        </style>
</head>
<body>
   <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<main>
    <h2 class="text-center" style="font-weight:bold; color: #867B73;">상품문의</h2>
    <form action="qnaWrite2" method="POST">
        <table class="board_row" style="margin-top:20px; padding-bottom:15px;">
            <colgroup>
                <col style="width:10%;">
                <col style="width:90%;">
            </colgroup>
            <tbody>
                <tr class="bbaf">                        
                    <th scope="row">제목</th>
                    <td><input type="text" name="title" class="form_input subject" id="subject" placeholder="제목을 입력하세요"></td>
                </tr>
                <tr>
                    <th scope="row" style="vertical-align: top">내용</th>
                    <td>
                        <textarea name="content" id="memo" placeholder="안녕하세요. 무디핏입니다 :)
문의 사항 있으신가요?
고객님 성함/연락처/주문번호를 적어주시면 보다 빠르고 정확한 상담처리 도와드리겠습니다.

주문번호:
성함:
연락처:"></textarea>
                    </td>
                </tr>         
            </tbody>
        </table>
        <div class="button-container">
            <a href="qna2" class="link-button">목록으로</a>
            <input type="submit" value="등록">
        </div>
    </form>
</main>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</body>
</html>
