<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/bootstrap.min.css" rel="stylesheet" />
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
    width: 100%; /* 너비 설정 */
    background-color: #F6F4EE; /* 배경색 설정 */
    padding: 20px; /* 안쪽 여백 설정 */
    font-size: 15px; /* 폰트 크기 설정 */
    height: 100%;
    display: flex; /* 추가된 부분 */
    flex-direction: column; /* 추가된 부분 */
    align-items: center; /* 추가된 부분 */
    justify-content: center; /* 추가된 부분 */
    
}

.table-container {
    width: 100%;
    border-radius: 30px; /* 테이블 컨테이너 모서리 둥글게 설정 */
    overflow: hidden; /* 자식 요소의 테두리가 부모의 테두리를 넘지 않도록 설정 */
}

table {
    width: 100%; /* 테이블 너비 설정 */
    border-collapse: separate; /* 테두리 겹치기 해제 */
    border-spacing: 0; /* 셀 간격 설정 */
    margin-top: 0; /* 테이블 컨테이너 내부에 있어서 여백 제거 */
}

 td {
    padding: 20px; /* 안쪽 여백 설정 */
    text-align: left; /* 텍스트 정렬 */
    border-bottom: 1px solid #D3D3D3 !important; /* 연한 회색 밑줄 설정 */
}

thead {
    background-color: white; /* 헤더 배경색 설정 */
    border-bottom: 2px solid #867B73; /* 헤더 아래쪽 밑줄 설정 */
}

th {
    font-weight: bold; /* 글꼴 두께 설정 */
    background-color: #FFF; /* 헤더 배경색 설정 */
    border-bottom: 1px solid #867B73 !important; /* td 아래쪽 테두리 설정 */
}

tr:hover td {
    background-color: #f1f1f1; /* 마우스 오버 시 배경색 설정 */
}

.button-container {
    text-align: center; /* 텍스트 중앙 정렬 */
    margin-top: 20px; /* 위쪽 여백 설정 */
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

.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 10px; /* 추가된 여백 설정 */
    width: 50%; /* 검색창 너비 설정 */
}

.form-group {
    display: flex;
    align-items: center;
    flex-grow: 1; /* 검색창이 가질 수 있는 최대 너비 */
    background-color: white; /* 검색창 배경색 설정 */
    border-radius: 25px; /* 검색창 모서리 둥글게 설정 */
    border: 1px solid #E3E3E3; /* 검색창 테두리 색상 설정 */
    padding: 10px 15px; /* 검색창 안쪽 여백 설정 */
}

.form-group input {
    border: none; /* 검색창 테두리 없음 */
    outline: none; /* 검색창 포커스 시 아웃라인 없음 */
    width: 100%; /* 검색창 너비 설정 */
}

button.header-search-btn {
    background: none; /* 버튼 배경색 없음 */
    border: none; /* 버튼 테두리 없음 */
    cursor: pointer; /* 버튼 커서 모양 설정 */
    margin-left: 10px; /* 버튼 왼쪽 여백 설정 */
}

button.header-search-btn i {
    font-size: 20px; /* 아이콘 크기 설정 */
    color: #867B73; /* 아이콘 색상 설정 */
}

.faq-question {
    font-weight: bold; /* 글꼴 두께 설정 */
    color: #71B2C3; /* 글자 색상 설정 */
    font-size: 25px; /* 글자 크기 설정 */
}

.faq-answer a {
    text-decoration: none; /* 밑줄 제거 */
    color: black; /* 글자 색상 설정 */
    margin-left: 10px; /* 간격 설정 */
    font-size: 16px; /* 글자 크기 설정 */
}

.faq-answer a:hover {
    text-decoration: underline; /* 마우스 오버 시 밑줄 설정 */
}
</style>
</head>
<body style="background-color: #F6F4EE;">
<%@include file="/WEB-INF/layouts/mypageheader.jsp"%> 
<div class="col-sidebar"></div>
<main>
<input type="hidden" value="{user_idx}" id="userIdx">
<h1 class="mt-3 text-center" style="font-weight:bold; color: #867B73;">FAQ</h1>
키워드 추천:  입금확인  |  배송  |  반품  |  교환
<div class="search-container">
    <form action="${pageContext.request.contextPath}/admin/userManagement7" method="get">
        <div class="form-group mb-2">
            <label for="searchId" class="sr-only"></label>
            <input type="text" name="searchId" id="searchId" placeholder="검색어를 입력하세요">
            <button class="header-search-btn" type="submit">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </div>
    </form>
</div>
<hr class="mb-3">
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table>
                <tbody>
                    <c:forEach var="faq" items="${faqList}">
                        <tr>
                            <td class="faq-question">Q</td>
                            <td class="faq-answer"><a href="/faqDetail?faqIdx=${faq.faqIdx}">${faq.title}</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="button-container">
    <button onclick="window.location.href='qnaWriteform'">문의 글쓰기</button>
</div>
</main>
</body>
<%@include file="/WEB-INF/layouts/footer.jsp"%>
</html>
