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
</head>
<body>
<%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<div class="col-sidebar">
	<%@include file="/WEB-INF/layouts/adminsidebar.jsp"%>
</div>
<input type="hidden" name="userIdx" id="userIdx" value="${sessionScope.userIdx}">
<main>
	<h3 class="mt-3 text-center">에디터 픽 스크랩</h3>
    <hr class="mb-3">
    <div class="table-container">
        <table class="table table-bordered">
            <thead class="table-secondary">
                 <tr class="${status.index % 2 == 0 ? 'even-row' : 'odd-row'}">
                    <th>공고번호</th>
                    <th>공고명</th>
                    <th>편집샵명</th>
                    <th>스크랩여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="EPScrap" items="${EPScrap}">    
                    <tr class="posting-info">
                        <td>${EPScrap.POSTING_IDX}</td>
                        <td><a href="/postingDetail?postingIdx=${EPScrap.POSTING_IDX}" style="text-decoration: none; color: black;">${EPScrap.TITLE}</a></td>
                        <td>${EPScrap.STORE_NAME}</td>
                        <td>
	                   		<button class="btn btn-outline-secondary editorBtn" style="margin-right: 5px;" data-user-idx="${sessionScope.userIdx}" data-posting-idx="${EPScrap.POSTING_IDX}">
								<svg width="25px" height="25px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M11.2691 4.41115C11.5006 3.89177 11.6164 3.63208 11.7776 3.55211C11.9176 3.48263 12.082 3.48263 12.222 3.55211C12.3832 3.63208 12.499 3.89177 12.7305 4.41115L14.5745 8.54808C14.643 8.70162 14.6772 8.77839 14.7302 8.83718C14.777 8.8892 14.8343 8.93081 14.8982 8.95929C14.9705 8.99149 15.0541 9.00031 15.2213 9.01795L19.7256 9.49336C20.2911 9.55304 20.5738 9.58288 20.6997 9.71147C20.809 9.82316 20.8598 9.97956 20.837 10.1342C20.8108 10.3122 20.5996 10.5025 20.1772 10.8832L16.8125 13.9154C16.6877 14.0279 16.6252 14.0842 16.5857 14.1527C16.5507 14.2134 16.5288 14.2807 16.5215 14.3503C16.5132 14.429 16.5306 14.5112 16.5655 14.6757L17.5053 19.1064C17.6233 19.6627 17.6823 19.9408 17.5989 20.1002C17.5264 20.2388 17.3934 20.3354 17.2393 20.3615C17.0619 20.3915 16.8156 20.2495 16.323 19.9654L12.3995 17.7024C12.2539 17.6184 12.1811 17.5765 12.1037 17.56C12.0352 17.5455 11.9644 17.5455 11.8959 17.56C11.8185 17.5765 11.7457 17.6184 11.6001 17.7024L7.67662 19.9654C7.18404 20.2495 6.93775 20.3915 6.76034 20.3615C6.60623 20.3354 6.47319 20.2388 6.40075 20.1002C6.31736 19.9408 6.37635 19.6627 6.49434 19.1064L7.4341 14.6757C7.46898 14.5112 7.48642 14.429 7.47814 14.3503C7.47081 14.2807 7.44894 14.2134 7.41394 14.1527C7.37439 14.0842 7.31195 14.0279 7.18708 13.9154L3.82246 10.8832C3.40005 10.5025 3.18884 10.3122 3.16258 10.1342C3.13978 9.97956 3.19059 9.82316 3.29993 9.71147C3.42581 9.58288 3.70856 9.55304 4.27406 9.49336L8.77835 9.01795C8.94553 9.00031 9.02911 8.99149 9.10139 8.95929C9.16534 8.93081 9.2226 8.8892 9.26946 8.83718C9.32241 8.77839 9.35663 8.70162 9.42508 8.54808L11.2691 4.41115Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
								</svg>
							</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
		<nav aria-label="Page navigation">
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
</main>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const userIdx = document.getElementById('userIdx').value;

    function updateEditorPickSvgs() {
        const editorButtons = document.querySelectorAll('.editorBtn');
        editorButtons.forEach(function(button) {
            const postingIdx = button.getAttribute('data-posting-idx');

            if (!userIdx) {
                const svg = button.querySelector('svg path');
                svg.setAttribute('fill', 'none');
                return;
            }

            // 에디터픽 상태 확인 요청
            fetch(`/checkEditorPick?postingIdx=` + postingIdx + `&userIdx=` + userIdx,  {
                method: 'GET',
            })
            .then(response => response.json())
            .then(isEditorPick => {
                button.setAttribute('data-editor-pick', isEditorPick);
                const svg = button.querySelector('svg path');
                if (isEditorPick) {
                    svg.setAttribute('fill', 'yellow');
                } else {
                    svg.setAttribute('fill', 'none');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    }

    updateEditorPickSvgs(); // 페이지 로드 시 에디터픽 버튼 상태 갱신

    document.addEventListener('click', async function(e) {
        const button = e.target.closest('.editorBtn'); // 상위 요소인 버튼을 찾기
        if (button) {
            e.preventDefault(); // 기본 동작 방지
            e.stopPropagation(); // 이벤트 전파 방지
            const svg = button.querySelector('svg path');
            const postingIdx = button.getAttribute('data-posting-idx');
            const userIdx = button.getAttribute('data-user-idx');
            const isEditorPick = button.getAttribute('data-editor-pick') === 'true';

            try {
                let response;
                if (isEditorPick) {
                    // 에디터픽 삭제 요청
                    response = await fetch('/deleteEditorPick', {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ postingIdx, userIdx }),
                    });
                } else {
                    // 에디터픽 추가 요청
                    response = await fetch('/addEditorPick', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ postingIdx, userIdx }), // 변경된 부분
                    });
                }

                if (response.ok) {
                    const message = isEditorPick ? '에디터픽 목록에서 삭제되었습니다.' : '에디터픽 목록에 추가되었습니다.';
                    alert(message);
                    updateEditorPickSvgs(); // 에디터픽 버튼 상태 갱신
                } else {
                    throw new Error('error.');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
            return; // 여기서 함수 실행 종료
        }

    });
});

</script>
</body>
</html>