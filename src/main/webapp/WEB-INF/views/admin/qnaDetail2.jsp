<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOODYFIT</title>
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

p {
    height: 300px;
}

.button-container {
    text-align: center;
    margin-left: 200px;
}

.answer-container {
    margin-top: 20px;
    display: none; /* Initially hide the answer container */
}

textarea {
    width: 100%;
    height: 100px;
    margin-top: 10px;
}

button.submit-btn {
       background-color: #111111;
    color: #fff;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}

button.submit-btn:hover {
    background-color: #45a049;
}
</style>
<script>
function toggleAnswerContainer() {
    var answerContainer = document.getElementById("answerContainer");
    if (answerContainer.style.display === "none") {
        answerContainer.style.display = "block";
    } else {
        answerContainer.style.display = "none";
    }
}
</script>
</head>
<body>
    <%@include file="/WEB-INF/layouts/header.jsp"%>
    <div class="col-sidebar"></div>
    <main>
        <h3 class="mt-3 text-center">상품문의</h3>
        <hr class="mb-3">
        <div class="container mt-3">
            <div class="row">
                <div>
                    <div class="flex-container">
                        <div style="font-weight: bold;">${qna2.title}</div>
                        <div class="author">
                            작성자: ${qna2.name}
                        </div>
                    </div>
                    <hr>
                    <p>${qna2.content}</p>
                    <div class="button-container">
                        <button onclick="window.history.back()">목록</button>
                    </div>
                    <div class="answer-list">
                        <c:forEach var="answer2" items="${answers2}">
                            <div class="answer2">
                                <h5>${answer2.title}</h5>
                                <p>${answer2.content}</p>
                                <div class="author">
                                    작성일: ${answer2.createDate}
                                </div>
                                <hr>
                            </div>
                        </c:forEach>
                    </div>
					<security:authorize access="hasRole('ROLE_ADMIN')">
                        <button onclick="toggleAnswerContainer()" >답변 작성</button>
                        <div id="answerContainer" class="answer-container">
                            <h4>답변 작성</h4>
                            <form action="/submitAnswer2" method="post">
                                <input type="text" name="title" placeholder="제목을 입력하세요" required>
                                <textarea name="content" placeholder="답변을 입력하세요" required></textarea>
                                <input type="hidden" name="postingQuestionIdx" value="${qna2.postingQuestionIdx}">
                                <button type="submit" class="submit-btn">답변 제출</button>
                            </form>
                        </div>
                    </security:authorize>
                </div>
            </div>
        </div>
    </main>
     
</body>
</html>
