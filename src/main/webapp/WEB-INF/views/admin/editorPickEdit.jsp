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
/* CSS styles */
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
}
#main-area {
    text-align: center;
}
.preview-area, #uploadInput, .posting-date {
    margin: 20px 0;
}
.modal-dialog {
    max-width: 80%;
}
.modal-body {
    overflow-x: auto;
}
table.editor-pick-table {
    width: 100%;
    height: 100%;
    border: 1px solid #dee2e6;
    border-collapse: collapse;
}

table.editor-pick-table th, table.editor-pick-table td {
    border: 1px solid #dee2e6;
    padding: 8px;
    text-align: center;
}

table.editor-pick-table th {
    background-color: #f8f9fa;
}

table.editor-pick-table tr:nth-child(even) {
    background-color: #f2f2f2;
}

table.editor-pick-table tr.posting-info:hover {
    cursor: pointer;
    background-color: #e9ecef; /* 배경색 어두워짐 */
}

table.editor-pick-table tr.posting-info:active {
    transform: translateY(1px); 
}
.selected-posting {
    margin-top: 20px;
    padding: 10px;
    border: 1px solid #dee2e6;
    border-radius: 5px;
    background-color: #f8f9fa;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
    <%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>

<main>
<form id="editForm" action="/EPEdit" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="pickIdx" value="${editorPick.pickIdx}">
    <input type="hidden" id="initialPostingIdx" name="initialPostingIdx" value="${postingInfo.POSTING_IDX}">
    <div id="main-area">
        <h2>에디터 픽 수정페이지</h2>
        <div id="selected-posting" class="selected-posting">
            <h4>선택된 공고 정보</h4>
            <input type="hidden" value="" id="postingIdx" name="postingIdx">
            <p>공고번호: <span id="selected-posting-idx">${postingInfo.POSTING_IDX}</span></p>
            <p>공고명: <span id="selected-posting-title">${postingInfo.TITLE}</span></p>
            <p>가맹점명: <span id="selected-posting-store">${postingInfo.STORE_NAME}</span></p>
            <!-- 버튼 타입을 button으로 변경 -->
            <button type="button" id="pick-posting" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#pickModal">공고 선택</button>
        </div>
        <div class="preview-area"> 
            <img src="${editorPick.filePath}" id="imagePreview" style="height:450px; width:910px;" class="imagePreview">
        </div>
        <div class="file-area">
            <input type="file" name="file" id="uploadInput" onchange="previewImage()">
        </div>
        <div class="posting-date">
            <input type="date" name="startDate" value="${startDate}" required> ~ <input type="date" name="endDate" value="${endDate}" required>
        </div>
        <div>
            <button type="submit" class="btn btn-primary">수정하기</button>
            <a href="/adminEditorPick" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
</form>
</main>
<div class="modal fade" id="pickModal" tabindex="-1" aria-labelledby="pickModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pickModalLabel">공고 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="editor-pick-table">
            <thead>
                <tr>
                    <th>공고번호</th>
                    <th>공고명</th>
                    <th>가맹점명</th>
                </tr>
            </thead>
            <tbody>
                <!-- posting 변수로 forEach 반복 -->
                <c:forEach var="posting" items="${posting}">
                    <tr class="posting-info">
                        <td>${posting.POSTING_IDX}</td>
                        <td>${posting.TITLE}</td>
                        <td>${posting.STORE_NAME}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script src="/js/bootstrap.bundle.min.js"></script>

<script>
function previewImage() {
    const fileInput = document.getElementById('uploadInput');
    const imagePreview = document.getElementById('imagePreview');
    
    if (fileInput.files && fileInput.files[0]) {
        const reader = new FileReader();

        reader.onload = function(e) {
            imagePreview.src = e.target.result;
        }

        reader.readAsDataURL(fileInput.files[0]); // 파일을 읽어 데이터 URL로 변환
    }
}

window.onload = function() {

    // "공고 선택" 버튼 클릭 시 모달 열기
    document.getElementById('pick-posting').addEventListener('click', function() {
        var modal = new bootstrap.Modal(document.getElementById('pickModal'));
        modal.show();
    });

    // 테이블에서 공고 선택 시 처리
    document.querySelectorAll('.posting-info').forEach(function(row) {
        row.addEventListener('click', function() {
            var postingIdx = this.cells[0].innerText;
            var postingTitle = this.cells[1].innerText;
            var postingStore = this.cells[2].innerText;

            // 선택된 공고 정보 업데이트
            document.getElementById('postingIdx').value = postingIdx;
            document.getElementById('selected-posting-idx').innerText = postingIdx;
            document.getElementById('selected-posting-title').innerText = postingTitle;
            document.getElementById('selected-posting-store').innerText = postingStore;
            document.getElementById('initialPostingIdx').value = postingIdx; // 초기값 업데이트

            // 모달 닫기
            var modal = bootstrap.Modal.getInstance(document.getElementById('pickModal'));
            modal.hide();
        });
    });

    // 폼 제출 시 초기 postingIdx 값이 변경되지 않았을 경우 처리
    document.getElementById('editForm').addEventListener('submit', function() {
        var initialPostingIdx = document.getElementById('initialPostingIdx').value;
        var currentPostingIdx = document.getElementById('postingIdx').value;

        if (currentPostingIdx === '') {
            // 선택된 postingIdx가 없을 경우 초기값 사용
            document.getElementById('postingIdx').value = initialPostingIdx;
        }
    });
};
</script>
</body>
</html>