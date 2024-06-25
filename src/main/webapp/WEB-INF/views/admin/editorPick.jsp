<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디터 픽</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
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
    font-size : 15px;
  
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
	<%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>

<main>
	<div id="main-area">
		<h2>에디터 픽</h2>
        <table class="editor-pick-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>공고 번호</th>
                    <th>공고 제목</th>
                    <th>가맹점명</th>
                    <th>게시 시작일</th>
                    <th>게시 마감일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="editorPick" items="${editorPick}">    
                    <tr class="editorPick-info">
                        <td>${editorPick.PICK_IDX}</td>
                        <td>${editorPick.POSTING_IDX}</td>
                        <td>${editorPick.TITLE}</td>
                        <td>${editorPick.STORE_NAME}</td>
                        <td class="start-date">${editorPick.START_DATE}</td>
            			<td class="end-date">${editorPick.END_DATE}</td>
                        <td><a href="#" class="btn btn-primary" style="margin-right:5px;">수정</a><a href="#" class="btn btn-danger">삭제</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="/EPWriteForm" class="btn btn-primary">작성하기</a>
	</div>
</main>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // editorPick 객체에서 날짜 필드들을 가져와 포맷팅
    var editorPicks = document.querySelectorAll(".editorPick-info");

    editorPicks.forEach(function(editorPick) {
        var startDateElem = editorPick.querySelector(".start-date");
        var endDateElem = editorPick.querySelector(".end-date");

        var startDate = new Date(startDateElem.textContent.trim());
        var endDate = new Date(endDateElem.textContent.trim());

        var options = { year: 'numeric', month: '2-digit', day: '2-digit' };
        var startDateStr = startDate.toLocaleDateString('ko-KR', options);
        var endDateStr = endDate.toLocaleDateString('ko-KR', options);

        startDateElem.textContent = startDateStr;
        endDateElem.textContent = endDateStr;
    });
});
</script>

</body>
</html>