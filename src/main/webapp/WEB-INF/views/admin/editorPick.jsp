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
    width: 100%;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    font-size : 15px;
  
}

.editor-pick-table {
    width: 100%;
    margin-bottom: 20px;
    border-collapse: collapse;
}

.editor-pick-table th, .editor-pick-table td {
    padding: 10px;
    text-align: center;
}

.editor-pick-table th {
    background-color: #343a40;
    color: #fff;
}

.editor-pick-table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
}

.editorPick-info td {
    vertical-align: middle;
}

.btn-margin-right {
    margin-right: 5px;
}
.button-group {
	margin-top : 20px;
    display: flex;
    justify-content: center;
}

.posting-status {
    pointer-events: none; /* 마우스 이벤트 무시 */
}
th a {
    text-decoration: none;
    color: inherit;
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
                    <th><a href="javascript:void(0);" onclick="sortTable(0);">게시 여부</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(1);">번호</a></th>
					<th><a href="javascript:void(0);" onclick="sortTable(2);">공고 번호</a></th>
					<th><a href="javascript:void(0);" onclick="sortTable(3);">공고 제목</a></th>
					<th><a href="javascript:void(0);" onclick="sortTable(4);">가맹점명</a></th>
					<th><a href="javascript:void(0);" onclick="sortTable(5);">게시 시작일</a></th>
					<th><a href="javascript:void(0);" onclick="sortTable(6);">게시 마감일</a></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="editorPick" items="${editorPick}">
                    <tr class="editorPick-info">
                        <form id="deleteForm${editorPick.PICK_IDX}" method="post" action="/EPDelete">
                            <input type="hidden" name="pickIdx" value="${editorPick.PICK_IDX}">
                            <td>
                                <input type="checkbox" class="posting-status">
                            </td>
                            <td>${editorPick.PICK_IDX}</td>
                            <td>${editorPick.POSTING_IDX}</td>
                            <td><a href="/postingDetail?postingIdx=${editorPick.POSTING_IDX}">${editorPick.TITLE}</a></td>
                            <td>${editorPick.STORE_NAME}</td>
                            <td class="start-date">${editorPick.START_DATE}</td>
                            <td class="end-date">${editorPick.END_DATE}</td>

                            <td>
                                <a href="/EPEditForm?pickIdx=${editorPick.PICK_IDX}" class="btn btn-primary" style="margin-right:5px;">수정</a>
                                <button type="button" class="btn btn-danger" onclick="confirmDelete(${editorPick.PICK_IDX})">삭제</button>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <nav aria-label="Page navigation" style="margin-top: 100px;">
            <ul class="pagination justify-content-center">
                <c:if test="${prev}">
                    <li class="page-item"><a class="page-link"
                        href="?page=${startPageNum - 1}" aria-label="Previous"> <span
                            aria-hidden="true" class="fas fa-angle-left"></span>
                    </a></li>
                </c:if>
                <c:forEach begin="${startPageNum}" end="${endPageNum}"
                    var="page">
                    <li class="page-item ${currentPage == page ? 'active' : ''}">
                        <a class="page-link" href="?page=${page}">${page}</a>
                    </li>
                </c:forEach>
                <c:if test="${next}">
                    <li class="page-item"><a class="page-link"
                        href="?page=${endPageNum + 1}"> <span aria-hidden="true"
                            class="fas fa-angle-right"></span>
                    </a></li>
                </c:if>
            </ul>
        </nav>
        
        <div class="button-group">
            <a href="/EPWriteForm" class="btn btn-outline-primary" style="width : 500px;">작성하기</a>
        </div>
    </div>
</main>

<script>
var sortDirections = {};

document.addEventListener("DOMContentLoaded", function() {
    var editorPicks = document.querySelectorAll(".editorPick-info");

    editorPicks.forEach(function(editorPick) {
        var startDateElem = editorPick.querySelector(".start-date");
        var endDateElem = editorPick.querySelector(".end-date");
        var postingStatusElem = editorPick.querySelector(".posting-status");

        var startDate = new Date(startDateElem.textContent.trim());
        var endDate = new Date(endDateElem.textContent.trim());
        var currentDate = new Date();

        var options = { year: 'numeric', month: '2-digit', day: '2-digit' };
        var startDateStr = startDate.toLocaleDateString('ko-KR', options);
        var endDateStr = endDate.toLocaleDateString('ko-KR', options);

        startDateElem.textContent = startDateStr;
        endDateElem.textContent = endDateStr;

        // 현재 날짜가 게시 시작일과 게시 마감일 사이에 있는지 확인하여 체크박스 설정
        if (currentDate >= startDate && currentDate <= endDate) {
            postingStatusElem.checked = true;
        } else {
            postingStatusElem.checked = false;
        }
    });
});

function confirmDelete(pickIdx) {
    var confirmDelete = confirm("정말로 삭제하시겠습니까?");
    if (confirmDelete) {
        var form = document.getElementById("deleteForm" + pickIdx);
        if (form) {
            form.submit();
        }
    }
}


function sortTable(columnIndex) {
    var table, rows, switching, i, x, y, shouldSwitch, direction, switchCount = 0;
    table = document.querySelector(".editor-pick-table");
    switching = true;

    if (!sortDirections[columnIndex]) {
        direction = "asc";
    } else {
        direction = sortDirections[columnIndex];
    }

    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            if (columnIndex === 0) { // 게시 여부 열
                x = rows[i].querySelector(".posting-status");
                y = rows[i + 1].querySelector(".posting-status");
                if (direction === "asc") {
                    if (!x.checked && y.checked) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (direction === "desc") {
                    if (x.checked && !y.checked) {
                        shouldSwitch = true;
                        break;
                    }
                }
            } else { // 다른 열
                x = rows[i].getElementsByTagName("TD")[columnIndex];
                y = rows[i + 1].getElementsByTagName("TD")[columnIndex];
                if (direction === "asc") {
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (direction === "desc") {
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                }
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchCount++;
        } else {
            if (switchCount === 0 && direction === "asc") {
                direction = "desc";
                switching = true;
            }
        }
    }
    sortDirections[columnIndex] = direction === "asc" ? "desc" : "asc";
}
</script>
</body>
</html>