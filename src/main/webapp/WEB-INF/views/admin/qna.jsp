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
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif; /* 글꼴 설정 */
    background-color: #F6F4EE; /* 배경색 설정 */
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center; /* 수직 정렬 */
}

main {
    width: 60%; /* 너비 설정 */
    background-color: #F6F4EE; /* 배경색 설정 */
    padding: 20px; /* 안쪽 여백 설정 */
    font-size: 15px; /* 폰트 크기 설정 */
    margin-top: 70px; /* 위쪽 여백 설정 */
}

table {
    width: 100%; /* 테이블 너비 설정 */
    margin-top: 20px; /* 위쪽 여백 설정 */
    border-radius:50px;
}

th, td {
    padding: 20px; /* 안쪽 여백 설정 */
    text-align: left; /* 텍스트 정렬 */
}

thead {
    background-color: white; /* 헤더 배경색 설정 */
    border-bottom: 2px solid #867B73; /* 헤더 아래쪽 밑줄 설정 */
}


th {
    font-weight: bold; /* 글꼴 두께 설정 */
    background-color: #FFF; /* 헤더 배경색 설정 */
       border-bottom: 1px solid #867B73 !important;  /* td 아래쪽 테두리 설정 */
}

td {
    background-color: white;
 
}

tr {
    background-color: #F6F4EE; /* 행 배경색 설정 */
}

tr:hover td {
    background-color: #f1f1f1; /* 마우스 오버 시 배경색 설정 */
}

.button-container {
    text-align: center; /* 텍스트 중앙 정렬 */
    margin-top: 20px; /* 위쪽 여백 설정 */
}
.table-container {
    width: 100%;
    border-radius: 20px; /* 테이블 컨테이너 모서리 둥글게 설정 */
    overflow: hidden; /* 자식 요소의 테두리가 부모의 테두리를 넘지 않도록 설정 */
}

button {
    padding: 15px 40px; /* 안쪽 여백 설정 */
    font-size: 16px; /* 폰트 크기 설정 */
    border: none; /* 테두리 없음 */
    background-color: #E5AAA3; /* 배경색 설정 */
    color: white; /* 글자 색상 설정 */
    cursor: pointer; /* 커서 모양 설정 */
    border-radius: 10px !important;
}

button:hover {
    background-color: #E3AAA2; /* 마우스 오버 시 배경색 설정 */
}
</style>
</head>
<body style="background-color: #F6F4EE;">
    <%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
    <main>
        <h2 class="text-center" style="font-weight:bold; color: #867B73;">1:1문의</h2>
        관리자문의 상품문의 
       <div class="table-container">
        <table >
        
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
                <c:forEach var="qna" items="${AdminqnaList}">
                    <tr>
                        <td>${qna.QUESTION_IDX}</td>
                        <td><a href="/qnaDetail?questionIdx=${qna.QUESTION_IDX}">${qna.TITLE}</a></td>
                        <td>${qna.ID}</td>
                        <td>${qna.CREATE_DATE}</td>
                        <td>
                        <c:choose>
                            <c:when test="${qna.STATE==1}">답변대기</c:when>
                            <c:when test="${qna.STATE==2}">답변완료</c:when>
                        </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="button-container">
            <button onclick="window.location.href='qnaWrite'">글 작성</button>
        </div>
    </main>
   
</body>
 <%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
