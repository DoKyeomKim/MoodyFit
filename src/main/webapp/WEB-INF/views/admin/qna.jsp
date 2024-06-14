<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 리스트</title>
<style>
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
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

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

.secret {
    color: #ff0000;
    font-weight: bold;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

button {
    padding: 10px 20px;
    font-size: 16px;
}
</style>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <main>
        <h3 class="text-center">Q&A 리스트</h3>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="qa" items="${qaList}">
                    <tr>
                        <td>${qa.id}</td>
                        <td>
                            <c:choose>
                                <c:when test="${qa.secret}">
                                    <span class="secret">비밀글</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="qaDetail.jsp?id=${qa.id}">${qa.title}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${qa.author}</td>
                        <td>${qa.date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="button-container">
            <button onclick="window.location.href='qnaWrite'">새 질문 작성</button>
        </div>
    </main>
</body>
</html>
