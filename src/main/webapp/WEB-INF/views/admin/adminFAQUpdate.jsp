<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 관리</title>


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
.btn-update {
  background-color: #f4f4f4;
    color: #333;
}

/* 반려 버튼 스타일 */
.btn-delete {
 background-color: #111111;
    color: #fff;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
   <div class="col-sidebar">
                <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
            </div>
<main>

<input type="hidden" value="{user_idx}" id="userIdx">
<h3 class="mt-3 text-center">FAQ 관리</h3>
<hr class="mb-3">
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered">
                <thead class="table-secondary">
                    <tr>
                        <th >번호</th>
                        <th >제목</th>
                        <th>내용</th>
             
                        <th >작업</th>
                    </tr>
                </thead>
                <tbody>
        
                    <c:forEach var="faq" items="${faqList}">
                        <tr>
                            <td>${faq.faqIdx}</td>
                            <td>${faq.title}</td>
                            <td>${faq.content}</td>
                    
                        
                            <td>
  
                                <button class="btn btn-update" onclick="updateStatus(${company.id}, 'rejected')">수정</button>
                                <button class="btn btn-delete" onclick="updateStatus(${company.id}, 'rejected')">삭제</button>
                            </td>
                        </tr>
                        <tr>
                         
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</main>


<script>
</script> 

</body>
</html>