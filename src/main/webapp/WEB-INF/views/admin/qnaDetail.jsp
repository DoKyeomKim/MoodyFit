<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세</title>
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
        <h3 class="mt-3 text-center">Q&A</h3>
        <hr class="mb-3">
        <div class="container mt-3">
            <div class="row">
                <div>
                    <div class="flex-container">
                        <div style="font-weight: bold;">${qna.title}</div>
                        <div class="author">
                            작성자: ${qna.id}
                        </div>
                    </div>
                    <hr>
                    <p>${qna.content}</p>
                    <div class="button-container">
                        <button onclick="window.history.back()">목록</button>
                    </div>
                    <div class="answer-list">
                        <c:forEach var="answer" items="${answers}">
                            <div class="answer">
                                <h5>${answer.title}</h5>
                                <p>${answer.content}</p>
                                <div class="author">
                                    작성일: ${answer.createDate}
                                </div>
                                <hr>
                            </div>
                        </c:forEach>
                    </div>
					<security:authorize access="hasRole('ROLE_ADMIN')">
                        <button onclick="toggleAnswerContainer()" >답변 작성</button>
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
            </div>
        </div>
    </main>
     <script>
        async function updateStatus(id, state) {
            const response = await fetch('${pageContext.request.contextPath}/admin/updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                body: new URLSearchParams({
                    id: id,
                    state: state
                })
            });

            if (response.ok) {
                const statusCell = document.getElementById('status-' + id);
                if (state == 1) {
                    statusCell.innerText = '승인';
                } else if (state == 2) {
                    statusCell.innerText = '반려';
                }
            } else {
                alert('상태 업데이트 실패');
            }
        }
    </script>
</body>
</html>
