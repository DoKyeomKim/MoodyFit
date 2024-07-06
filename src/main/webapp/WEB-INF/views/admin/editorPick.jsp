<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에디터 픽</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
<script src="${pageContext.request.contextPath}/scripts.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<style>
main{
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
a {
    color: black;
    text-decoration: none;
}
a:hover {
    color: black;
    text-decoration: underline;
}

.btn-outline-primary {
    background-color: #111111;
    color: #fff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    font-size: 1.2em;
    display: block;
    margin: 20px auto;
    width: 30%;
    text-align: center;
}
.btn-outline-primary:hover {
    background-color: #ccc;
    text-decoration: none;
}
.btn-outline-primary:active,
.btn-outline-primary:focus {
    background-color: #999;
    border-color: #999; 
    text-decoration: none;
    box-shadow: none; 
}
.btn-outline-primary:active:focus {
    background-color: #999; /* 원하는 색상으로 변경 */
    border-color: #999; /* 원하는 테두리 색상으로 변경 */
}



.page-item.active .page-link {
    background-color: black;
    border-color: black;
    color: #fff;
}

.page-link {
    color: black; /* 기본 링크 색상 변경 */
}

.page-link:hover {
    color: #0056b3; /* 호버 시 링크 색상 변경 */
}

</style>

<script>
function confirmDelete(event, form) {
    event.preventDefault();
    if (confirm('정말로 삭제하시겠습니까?')) {
        form.submit();
    }
}

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

        if (currentDate >= startDate && currentDate <= endDate) {
            postingStatusElem.checked = true;
        } else {
            postingStatusElem.checked = false;
        }
    });
});

function sortTable(columnIndex) {
    var table, rows, switching, i, x, y, shouldSwitch, direction, switchCount = 0;
    table = document.querySelector(".table");
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
            if (columnIndex === 0) {
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
            } else {
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
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<main>
    <input type="hidden" value="{user_idx}" id="userIdx">
    <h3 class="mt-3 text-center">에디터 픽</h3>
    <hr class="mb-3">
    <div class="table-container">
        <table class="table table-bordered">
            <thead class="table-secondary">
                 <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                    <th><a href="javascript:void(0);" onclick="sortTable(0);">게시 여부</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(1);">번호</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(2);">공고 번호</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(3);">공고 제목</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(4);">가맹점명</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(5);">게시 시작일</a></th>
                    <th><a href="javascript:void(0);" onclick="sortTable(6);">게시 마감일</a></th>
                    <th>작업</th>
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
                                <a href="/EPEditForm?pickIdx=${editorPick.PICK_IDX}" class="btn btn-delete">수정</a>
                                <button type="button" class="btn btn-delete" onclick="confirmDelete(event, this.form)">삭제</button>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${prev}">
                <li class="page-item"><a class="page-link" href="?page=${startPageNum - 1}" aria-label="Previous"> <span aria-hidden="true" class="fas fa-angle-left"></span></a></li>
            </c:if>
            <c:forEach begin="${startPageNum}" end="${endPageNum}" var="page">
                <li class="page-item ${currentPage == page ? 'active' : ''}">
                    <a class="page-link" href="?page=${page}">${page}</a>
                </li>
            </c:forEach>
            <c:if test="${next}">
                <li class="page-item"><a class="page-link" href="?page=${endPageNum + 1}"> <span aria-hidden="true" class="fas fa-angle-right"></span></a></li>
            </c:if>
        </ul>
    </nav>
    <div class="button-group" style="text-align:center; margin-left :10%">
        <a href="/EPWriteForm" class="btn btn-outline-primary" style="width: 300px;">작성하기</a>
    </div>
</main>
</body>
</html>
