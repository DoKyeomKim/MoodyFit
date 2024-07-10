<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<style>

    #gnb {
        border-bottom: 2px solid #c0c0c0;
        padding-bottom: 10px; /* Optional: to provide some spacing */
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .text-right {
        text-align: right;
    }
    .logo {
        height: 50px; /* Adjust this value based on your logo's size */
    }
    .dark-mode {
        background-color: #333;
        color: #fff;
    }
    .dark-mode a {
        color: #fff;
    }
    /* 다크 모드 버튼 스타일 */
    #darkModeButton {
        background-color: black;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
    }
    /* 다크 모드 상태에서 버튼 스타일 */
    .dark-mode #darkModeButton {
        background-color: white;
        color: black;
    }

.page-home {
	position:absolute;
	top:10px;
	right:200px;
}
</style>
<script>
    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
        const sidenav = document.querySelector('.sidenav');
        if (sidenav) {
            sidenav.classList.toggle('dark-mode');
        }
        // 다크 모드 상태를 로컬 스토리지에 저장
        const isDarkMode = document.body.classList.contains('dark-mode');
        localStorage.setItem('dark-mode', isDarkMode);
    }

    // 페이지 로드 시 다크 모드 상태 적용
    document.addEventListener('DOMContentLoaded', function() {
        const isDarkMode = localStorage.getItem('dark-mode') === 'true';
        if (isDarkMode) {
            document.body.classList.add('dark-mode');
        }
    });
</script>
</head>
<body>
<div id="gnb">
    <a href="/admin">
        <img src="/images/logo.png" alt="Logo" class="logo">
    </a>
    <div class="text-right">
        <button id="darkModeButton" onclick="toggleDarkMode()" style="margin-right:10px;">다크모드</button>
        <a href="/" >
        	<svg class="page-home" fill="#000000" width="60px" height="60px" viewBox="-4.5 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg">
			<path d="M19.469 12.594l3.625 3.313c0.438 0.406 0.313 0.719-0.281 0.719h-2.719v8.656c0 0.594-0.5 1.125-1.094 1.125h-4.719v-6.063c0-0.594-0.531-1.125-1.125-1.125h-2.969c-0.594 0-1.125 0.531-1.125 1.125v6.063h-4.719c-0.594 0-1.125-0.531-1.125-1.125v-8.656h-2.688c-0.594 0-0.719-0.313-0.281-0.719l10.594-9.625c0.438-0.406 1.188-0.406 1.656 0l2.406 2.156v-1.719c0-0.594 0.531-1.125 1.125-1.125h2.344c0.594 0 1.094 0.531 1.094 1.125v5.875z"></path>
			</svg>
		</a>
        <a href="/logout" id="logout_btn">로그아웃</a>
        <input type="hidden" value="${login.id}" id="login_userid">
    </div>
</div>
</body>
</html>
