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
    width: 100px;
    height: auto;
    border: 1px solid gray;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-left:40px;
    font-size:10px;
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
    font-size:12px;
}
</style>
</head>
<body>
    <aside id="sidebar">
        <nav>
            <ul>
                <li><a href="/myPage" class="bold">마이페이지</a></li>
                <li><a href="/personUpdateForm">정보 수정</a></li>
                <li><a href="/myPage/order">주문 정보</a></li>
                <li><a href="/myPage/delivery">배송지 관리</a></li>
                <li><a href="/myPage/wishList">관심상품</a></li>
                <li><a href="/myPage/cart">장바구니</a></li>
                <li><a href="/myPage/payment">
주문서작성</a></li>
       
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
