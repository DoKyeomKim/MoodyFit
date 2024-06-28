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
    background-color: #F6F4EE;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

main {
    width: 60%;
    background-color: #F6F4EE;
    padding: 20px;
    font-size: 15px;
    margin-top: 70px;
}

table {
    width: 100%;
    margin-top: 20px;
}

th, td {
    padding: 20px;
    text-align: left;
}

thead {
    background-color: white;
    border-bottom: 2px solid #867B73;
}

th {
    font-weight: bold;
    background-color: #FFF;
    border-bottom: 1px solid #867B73 !important;
}

td {
    background-color: white;
}

tr {
    background-color: #F6F4EE;
}

tr:hover td {
    background-color: #f1f1f1;
}

.button-container {
    text-align: center;
    margin-top: 30px;
}
.table-container {
    width: 100%;
    border-radius: 30px;
    overflow: hidden;
}

.qna-style {
    text-align: center;
    margin-bottom: 20px;
}

.qna-style a {
    margin: 0 10px;
    color: #A9A9A9;
    text-decoration: none;
    font-weight: normal;
    transition: color 0.3s, border-bottom 0.3s;
    padding-bottom: 5px;
}

.qna-style a.active, .qna-style a:hover {
    color: #867B73;
    border-bottom: 2px solid #867B73;
}

button {
    padding: 15px 40px;
    font-size: 16px;
    border: none;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    border-radius: 10px !important;
}

button:hover {
    background-color: #E3AAA2;
}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('.qna-style a');
    const currentPath = window.location.pathname;

    links.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
        link.addEventListener('click', function() {
            links.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });
});
</script>
</head>
<body>
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
    <main>
        <h2 class="text-center" style="font-weight:bold; color: #867B73;">상품문의</h2>
        <div class="qna-style">
            <a href="/qna">관리자문의</a>
            <a href="/qna2">상품문의</a>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>답변여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="qna2" items="${qna2List}">
                        <tr>
                            <td>${qna2.POSTING_QUESTION_IDX}</td>
                            <td><a href="/qnaDetail2?postingQuestionIdx=${qna2.POSTING_QUESTION_IDX}">${qna2.TITLE}</a></td>
                            <td>${qna2.NAME}</td>
                            <td>${qna2.CREATE_DATE}</td>
                            <td>
                            <c:choose>
                                <c:when test="${qna2.STATE==1}">답변대기</c:when>
                                <c:when test="${qna2.STATE==2}">답변완료</c:when>
                            </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="button-container">
            <button onclick="window.location.href='qnaWrite2'">글쓰기</button>
        </div>
    </main>
    <%@include file="/WEB-INF/layouts/footer.jsp"%>
</body>
</html>
