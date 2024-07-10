<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매글 관리 리스트</title>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
    background-color: #F6F4EE;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

main {
    flex: 1;
    width: 80%;
    margin: 70px auto;
}

.main-container {
    margin-left: 160px; 
    padding: 16px;
}

.table-container {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 20px;
    margin: 10px 0;
    align-items: center;
    background-color: #fff;
    font-size: 14px;
}

.table {
    width: 100%;
    border-collapse: collapse;
    padding: 20px;
}

.table th, .table td {
    border: 1px solid #ddd;
    text-align: center;
}

.table th {
    background-color: #f4f4f4; 
    color: #333;
}

.table td img {
    width: 50px; 
    height: 50px;
    object-fit: cover;
}

.table tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
}

.table tbody tr:nth-child(even) {
    background-color: #fff;
}

.button-container {
    text-align: center;
    margin-top: 10px;
    display: inline-block;
    vertical-align: top;
    margin-left: 10px;
}

.button-container {
    display: inline-block;
    vertical-align: top;
    margin-left: 10px;
}

.delivery-btn:hover {
    text-decoration: underline;
}

.table-container a {
    text-decoration: none; 
    color: inherit; 
}

.delivery-btn {
    background-color: transparent;
    color: #E5AAA3;
    cursor: pointer;
    border: none;
    font-size: 14px;
    text-decoration: none;
    margin-left: 5px;
}

.table-container a:hover {
    text-decoration: none;
}

.table-container a:hover .table {
    border: 2px solid lightgrey; 
    background-color: #f0f8ff;
}

h3 {
    text-align: left;
    margin-left: 30px;
    display: inline-block;
}

.edit-btn {
    padding: 10px 20px;
    font-size: 14px;
    border: none;
    background-color: #E5AAA3;
    color: white;
    cursor: pointer;
    border-radius: 10px !important;
}

.apply-btn {
    background-color: #f2eaeaa8;
    color: #B68555;
    border: 1px solid #B68555;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body style="background-color:#F6F4EE !important;">

<%@include file="/WEB-INF/layouts/mypageheader.jsp"%>
<%@include file="/WEB-INF/layouts/storeAside.jsp"%>

<main>
    <div style="display: flex; align-items: center;">
        <h3 style="font-weight:bold;"> 판매글 관리</h3>
        <div class="button-container">
            <button class="delivery-btn" onclick="openTab(event, 'postingList')">판매글 리스트</button>
            <button class="delivery-btn" onclick="openTab(event, 'onHoldList')">판매글 보류 리스트</button>
        </div>
    </div>

    <div id="postingList" class="tab-content">
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>사진</th>
                        <th>판매글 제목</th>
                        <th>판매가</th>
                        <th>분류</th>
                        <th>판매수량 및 옵션</th>
                        <th>수정일</th>
                        <th>판매상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody id="postingListBody">
                    <c:forEach var="posting" items="${postings}">
                    <tr id="postingRow_${posting.POSTING_IDX}">
                        <td>${posting.POSTING_IDX}</td>
                        <td>
                            <c:choose>
                                <c:when test="${!empty posting.FILE_PATHS}">
                                    <c:forEach var="filePath" items="${posting.FILE_PATHS}">
                                        <img src="${filePath}" alt="posting image" style="max-width: 100%; max-height: 50px;">
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no_image.png" alt="no image available">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="/postingDetail?postingIdx=${posting.POSTING_IDX}">${posting.TITLE}</a></td>
                        <td>${posting.PRICE}</td>
                        <td>${posting.CATEGORY}/${posting.SUB_CATEGORY}</td>
                        <td><c:out value="${posting.INVENTORY}" escapeXml="false"/></td>
                        <td>${posting.UPDATE_DATE}</td>
                        <td>
                            <c:choose>
                                <c:when test="${posting.STATE == 1}">
                                    등록 심사중
                                </c:when>
                                <c:when test="${posting.STATE == 2}">
                                    <select onchange="updatePostingState(${posting.POSTING_IDX}, this.value, 'postingList')">
                                        <option value="1" selected>판매중</option>
                                        <option value="2">판매중단</option>
                                    </select>
                                </c:when>
                                <c:when test="${posting.STATE == 3}">
                                    판매중단
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <button class="edit-btn" onclick="editPosting(${posting.POSTING_IDX})">수정</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="button-container">
                <a href="/storeMyPage/postingWrite"><button class="apply-btn">신규 판매글 등록</button></a>
            </div>
        </div>
    </div>

    <div id="onHoldList" class="tab-content" style="display:none;">
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>사진</th>
                        <th>판매글 제목</th>
                        <th>판매가</th>
                        <th>분류</th>
                        <th>판매수량 및 옵션</th>
                        <th>수정일</th>
                        <th>판매상태</th>
                        <th>수정</th>
                    </tr>
                </thead>
                <tbody id="onHoldListBody">
                    <c:forEach var="posting" items="${onHoldPostings}">
                    <tr id="postingRow_${posting.POSTING_IDX}">
                        <td>${posting.POSTING_IDX}</td>
                        <td>
                            <c:choose>
                                <c:when test="${!empty posting.FILE_PATHS}">
                                    <c:forEach var="filePath" items="${posting.FILE_PATHS}">
                                        <img src="${filePath}" alt="posting image" style="max-width: 100%; max-height: 50px;">
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no_image.png" alt="no image available">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="/postingDetail?postingIdx=${posting.POSTING_IDX}">${posting.TITLE}</a></td>
                        <td>${posting.PRICE}</td>
                        <td>${posting.CATEGORY}/${posting.SUB_CATEGORY}</td>
                        <td><c:out value="${posting.INVENTORY}" escapeXml="false"/></td>
                        <td>${posting.UPDATE_DATE}</td>
                        <td>
                            <c:choose>
                                <c:when test="${posting.STATE == 0}">
                                    등록 심사중
                                </c:when>
                                <c:when test="${posting.STATE == 1}">
                                    <select onchange="updatePostingState(${posting.POSTING_IDX}, this.value, 'onHoldList')">
                                        <option value="1" selected>판매중</option>
                                        <option value="2">판매중단</option>
                                    </select>
                                </c:when>
                                <c:when test="${posting.STATE == 2}">
                                    판매중단
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <button class="edit-btn" onclick="editPosting(${posting.POSTING_IDX})">수정</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<%@include file="/WEB-INF/layouts/footer.jsp"%>

<!-- 모달 추가 -->
<div class="modal fade" id="stateChangeModal" tabindex="-1" role="dialog" aria-labelledby="stateChangeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="stateChangeModalLabel">판매중단 사유 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <select id="stateReasonSelect" class="form-control">
                    <option value="품절">품절</option>
                    <option value="상품 생산 중단">상품 생산 중단</option>
                    <option value="상품 불량품 발견">상품 불량품 발견</option>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="applyStateChange">적용</button>
            </div>
        </div>
    </div>
</div>

<script>
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

var selectedPostingIdx = null;
var selectedTabId = null;

$('select').change(function() {
    var state = $(this).val();
    var postingIdx = $(this).closest('tr').attr('id').split('_')[1];
    var tabId = $(this).closest('.tab-content').attr('id');

    if (state == 2) {
        selectedPostingIdx = postingIdx;
        selectedTabId = tabId;
        $('#stateChangeModal').modal('show');
    } else {
        updatePostingState(postingIdx, state, tabId);
    }
});

$('#applyStateChange').click(function() {
    var reason = $('#stateReasonSelect').val();
    $('#stateChangeModal').modal('hide');

    $.ajax({
        url: '/storeMyPage/updatePostingState',
        type: 'POST',
        data: {
            postingIdx: selectedPostingIdx,
            state: 2, // 판매중단 상태 코드
            reason: reason // 추가된 사유
        },
        success: function(response) {
            alert("판매 상태가 변경되었습니다.");
            var row = $('#postingRow_' + selectedPostingIdx);
            row.fadeOut(400, function() {
                row.remove();
                if (selectedTabId == 'postingList') {
                    $('#onHoldListBody').append(row);
                } else {
                    $('#postingListBody').append(row);
                }
                row.fadeIn(400);
            });
        },
        error: function(xhr, status, error) {
            console.error('Failed to update posting state:', error);
        }
    });
});

function editPosting(postingIdx) {
    window.location.href = "#"
}

function updatePostingState(postingIdx, state, tabId) {
    $.ajax({
        url: '/storeMyPage/updatePostingState',
        type: 'POST',
        data: {
            postingIdx: postingIdx,
            state: state
        },
        success: function(response) {
            var row = $('#postingRow_' + postingIdx);
            row.fadeOut(400, function() {
                row.remove();
                if (tabId == 'postingList') {
                    $('#postingListBody').append(row);
                } else {
                    $('#onHoldListBody').append(row);
                }
                row.fadeIn(400);
            });
        },
        error: function(xhr, status, error) {
            console.error('Failed to update posting state:', error);
        }
    });
}
</script>
</body>
</html>
