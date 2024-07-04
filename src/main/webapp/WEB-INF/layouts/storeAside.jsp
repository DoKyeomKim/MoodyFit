<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#sidebar {
    position: fixed;
    top: 50%;
    left: 0;
    transform: translateY(-50%);
    width: 130px;
    height: auto;
    border: 1px solid gray;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-left:40px;
    font-size:12px;
    transition: top 0.5s;
}

#sidebar nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    text-align: left;
}

#sidebar nav ul li {
    margin-bottom: 20px;
    margin-left:20px;
    margin-top:20px;
}

#sidebar nav ul li a {
    text-decoration: none;
    color: #867B73;
}

#sidebar nav ul li a.bold {
    font-weight: bold;
    font-size:14px;
}
</style>
</head>
<body>
    <aside id="sidebar">
        <nav>
            <ul>
                <li><a href="/myPage" class="bold">마이페이지</a></li>
                <li><a href="/storeMyPage/productList">상품 리스트</a></li>
                <li><a href="/storeMyPage/productWrite">상품 등록</a></li>
                <li><a href="/storeMyPage/postingList">판매 글 리스트</a></li>
                <li><a href="/storeMyPage/postingWrite">판매 글 등록</a></li>
                <li><a href="/storeMyPage/postingStatus">판매 글 신청 현황</a></li>
                <li><a href="/storeUpdateForm">정보 수정</a></li>
            </ul>
        </nav>
    </aside>
    <script>
    window.addEventListener('scroll', function() {
        var sidebar = document.getElementById('sidebar');
        var scrollPosition = window.scrollY;
        var windowHeight = window.innerHeight;
        var sidebarHeight = sidebar.offsetHeight;
        
        var topPosition = scrollPosition + (windowHeight / 2) - (sidebarHeight / 2);
        sidebar.style.top = topPosition + 'px';
    });
    </script>
</body>
</html>
