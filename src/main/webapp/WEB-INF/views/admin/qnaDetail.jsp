<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세</title>
<style>
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

    button.submit-btn:hover, .button-container button:hover {
        background-color: #45a049;
    }

    .button-container {
        text-align: center;
        margin-top: 20px;
    }
    .answer-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    box-sizing: border-box;
}

.answer-container h4 {
    margin-top: 0;
    color: #333;
}

.answer-container input[type="text"], .answer-container textarea {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.answer-container textarea {
    height: 150px;
    resize: none;
}

.submit-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-sizing: border-box;
}

.submit-btn:hover {
    background-color: #45a049;
}
.answer-area{
	text-align:center;
}
.answer-btn{
	text-align:right;
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
<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<body style="background-color:#F6F4EE !important;">
    <div class="col-sidebar"></div>
    <main>
        <h3 class="mt-3 text-center" style="font-weight:bold ;border-radius:30px;">Q&A</h3>


        <!-- Q&A Section -->
        <div class="container mt-3">
            <div class="flex-container">
                <div style="font-weight: bold;">${qna.title}</div>
                <div class="author">작성자: ${qna.id}</div>
            </div>
            <hr>
            <div class="content">
                <p>${qna.content}</p>
            </div>
        </div>

        <!-- Answer Section -->
        <div class="container">
           
            <div class="answer-list">
                <c:forEach var="answer" items="${answers}">
                    <div class="answer">
                        <h5>${answer.title}</h5>
                        <hr>
                        <div class="content">
                            <p>${answer.content}</p>
                        </div>
                        <div class="author">작성일: ${answer.createDate}</div>
                        <hr>
                    </div>
                </c:forEach>
            </div>

            <security:authorize access="hasRole('ROLE_ADMIN')">
                <div id="answerContainer" class="answer-container">
                    <h4>답변 작성</h4>
                    <form action="/submitAnswer" method="post">
                        <input type="text" name="title" placeholder="제목을 입력하세요" required>
                        <textarea name="content" placeholder="답변을 입력하세요" required></textarea>
                        <input type="hidden" name="questionIdx" value="${qna.questionIdx}">
                        <button type="submit" class="submit-btn">답변 제출</button>
                    </form>
                </div>
            </security:authorize>
        </div>

        <div class="button-container">
            <button onclick="window.history.back()">목록</button>
        </div>
    </main>
    <%@include file="/WEB-INF/layouts/footer.jsp"%>
</body>
</html>
