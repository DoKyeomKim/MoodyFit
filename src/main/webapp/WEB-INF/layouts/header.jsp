<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/960173563c.js" crossorigin="anonymous"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet" />
<style>

/* styles.css 파일 */

body {
    margin: 0;
    font-family: Arial, sans-serif;
}

.fixed-header {
    position: fixed;
    top: 0;
    width: 100%;
    background: transparent; /* 헤더 배경 투명하게 설정 */
    z-index: 1000;
    transition: background 0.3s ease, box-shadow 0.3s ease; /* 애니메이션 추가 */
}
.fixed-header.scrolled {
    background: #000; /* 스크롤 시 헤더 배경을 검은색으로 변경 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* 스크롤 시 그림자 강화 */
    color: white; /* 스크롤 시 글자 색을 흰색으로 변경 */
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 50px; /* 양옆 패딩 추가 */
    background: transparent; /* 헤더 배경 투명하게 설정 */
}

.logo-img img {
    height: 50px; /* 로고 크기 조정 */
    width: auto;
}

.header-search-box {
    height: 50px;
    width: 450px;
    background: transparent; /* 검색창 배경 투명하게 설정 */
    border-radius: 25px;
    padding: 10px;
    border: none; /* 기존 테두리 제거 */
    display: flex;
    align-items: center;
    border-bottom: 2px solid #ccc; /* 검색창 하단에 밑줄 추가 */
}

.header-search-txt {
    border: none;
    background: none;
    outline: none;
    flex-grow: 1;
    padding-left: 10px;
    color: #797979;
    font-size: 16px;
    line-height: 30px;
}

.header-search-txt::placeholder {
    color: #797979;
}

.header-search-btn {
    color: black;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: transparent; /* 버튼 배경 투명하게 설정 */
    border: none;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
}

.navbar {
    background: transparent; /* 네비게이션 바 배경 투명하게 설정 */
}

.navbar-nav {
    display: flex;
    align-items: center;
}

#navbarNav {
    display: flex;
    justify-content: flex-start; /* 왼쪽 정렬 */
    margin-left: 20px; /* 로고와 카테고리 사이의 간격 */
}

#navbarNav .nav-link {
    margin-right: 30px;
    font-size: 14px; /* 폰트 사이즈 */
    font-family: Arial, sans-serif; /* 글씨체 */
    color: black;
    text-decoration: none;
    transition: color 0.3s ease; /* 애니메이션 추가 */
}

#navbarNav .nav-link:hover {
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}



.navbar-nav.ml-auto {
    margin-left: auto;
}

main {
    padding-top: 160px; /* 고정된 헤더 높이만큼 패딩 추가 */
}

.fixed-header.scrolled .nav-link,
.fixed-header.scrolled .header-search-txt,
.fixed-header.scrolled .header-search-btn i {
    color: white !important; /* 스크롤 시 글자 색을 흰색으로 변경 */
}

.fixed-header.scrolled .header-search-btn {
    color: white !important; /* 검색 버튼 색상 변경 */
}

.dropdown-menu {
    min-width: auto;

}

.search-container {
    display: flex;
    align-items: center;
}

</style>
</head>
<body>
 

    <div class="fixed-header">
        <div class="header-container">
            <div class="logo-img">
                <a href="/"><img id="logo" src="/images/logo.png"></a>
            </div>
            
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <c:forEach var="category" items="${category}">
                            <li class="nav-item">
                                <a id="header-category" class="nav-link" aria-current="page" href="/category/${category.engName}">${category.engName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </nav>
            
            <div class="search-container">
                <div class="search-cols">
                    <form class="header-search-box" action="/search?keyword=${keyword}" method="GET">
                        <input class="header-search-txt" id="search-txt" type="keyword" name="keyword" placeholder="검색어를 입력하세요">
                        <button class="header-search-btn" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                </div>

                <!-- COMMUNITY 드롭다운 버튼 추가 -->
                <div class="dropdown ms-3">
                    <a class="nav-link dropdown-toggle" href="#" id="communityDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        COMMUNITY
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="communityDropdown">
                        <li><a class="dropdown-item" href="/faq">FAQ</a></li>
                        <li><a class="dropdown-item" href="/qna">QNA</a></li>
                        <li><a class="dropdown-item" href="/review">Review</a></li>
                        <li><a class="dropdown-item" href="/reviewList">Review리스트</a></li>
                    </ul>
                </div>
            </div>

            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <security:authorize access="isAuthenticated()">
                            <c:choose>
                                <c:when test="${sessionScope.role == 'ROLE_PERSON'}">
                                    <li class="nav-item1">
                                        <a href="/myPage" class="nav-link">마이페이지</a>
                                    </li>
                                </c:when>
                                <c:when test="${sessionScope.role == 'ROLE_STORE'}">
                                    <li class="nav-item1">
                                        <a href="/storeMyPage" class="nav-link">마이페이지</a>
                                    </li>
                                </c:when>
                            </c:choose>
                            <li class="nav-item1">
                                <a href="<c:url value='/logout' />" class="nav-link">로그아웃</a>
                            </li>
                        </security:authorize>
                        <security:authorize access="!isAuthenticated()">
                            <li class="nav-item1">
                                <a href="<c:url value='/login' />" class="nav-link">로그인</a>
                            </li>
                            <li class="nav-item1">
                                <a href="<c:url value='/totalJoin' />" class="nav-link">회원가입</a>
                            </li>
                        </security:authorize>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <script>

    document.querySelector('.header-search-box').addEventListener('submit', function(event) {
        var searchInput = document.getElementById('search-txt').value;
        if (!searchInput) {
            alert('검색어를 입력해주세요!');
            event.preventDefault(); // 폼 제출을 막음
        }
    });

    window.addEventListener('scroll', function() {
        var header = document.querySelector('.fixed-header');
        var logo = document.getElementById('logo');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
            logo.src = '/images/white_logo.png'; // Change the logo to the white version
        } else {
            header.classList.remove('scrolled');
            logo.src = '/images/logo.png'; // Revert back to the original logo
        }
    });

    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7/z6M5D96k4LP0nK3UMg6DsNBSW/Qr4D96ZIpVKVV7Yw5R9ka65lVo9sA2M0CoCa" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9Ah39PzQb6FZYuwM+E2A7sZo1QBIeZTBbE+TpyG5f3e7i4e3wFK1dIw" crossorigin="anonymous"></script>
</body>
</html>
