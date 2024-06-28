<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
 <%@include file="/WEB-INF/layouts/adminheader.jsp"%> 
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        body {
            font: 16px Pretendard, 맑은 고딕, Nanum Gothic, Verdana, Dotum, AppleGothic, sans-serif;
            margin: 0;
            padding: 0;
        }

        #gnb {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .nav {
            list-style: none;
            padding: 0;
            margin: 20px auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px; /* 박스 사이의 간격 */
            max-width: 1200px; /* 중앙 정렬을 위해 전체 너비 설정 */
        }

        .nav li {
            margin: 0; /* 박스 사이의 간격 제거 */
        }

        .nav a {
            text-decoration: none;
            color: #000;
            width: 200px; /* 박스의 너비 */
            height: 200px; /* 박스의 높이 */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 8px; /* 모서리 둥글게 */
            transition: background-color 0.3s ease, color 0.3s ease;
            box-sizing: border-box;
            padding: 20px;
            font-size: 14px;
        }

        .nav a:hover {
            background-color: #f8f8f8;
            color: #333;
        }

        .nav a.active {
            background-color: #333;
            color: #fff;
        }

        .nav-link {
            display: block;
            color: #000;
            text-align: center;
            padding: 10px; /* 텍스트 주변 여백 */
        }

        .nav-link .bold {
            font-weight: bold;
        }

        .nav-link .light {
            color: #666; /* 연한 색상 */
            font-size: 0.9em; /* 약간 작은 글씨 */
        }
      
        #sales {
            text-align: center;
            margin-top: 20px;
        }

        #sales h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
            </style>
</head>
<body>
<div id = "sales">

            <h3>총 판매 건수: 건</h3>
            <h3>총 주문 수익: 원</h3>
        </div>

<ul class="nav">
    <li><a href="/adminEditorPick" class="nav-link">
        <br><span class="bold">Editor's Pick</span></br>에디터 픽<br><br>
        <span class="light">메인에 띄울 공고를 관리할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminCategoryUpdate" class="nav-link">
        <br><span class="bold">Category</span></br>카테고리 관리<br><br>
        <span class="light">카테고리를 관리 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminApply" class="nav-link">
        <br><span class="bold">Apply</span></br>가맹점 공고 관리<br><br>
        <span class="light">가맹점의 공고를 승인 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminOrder" class="nav-link">
        <br><span class="bold">Order</span></br>주문내역 관리<br><br>
        <span class="light">고객의 주문 내역을 관리 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminPuser" class="nav-link">
        <br><span class="bold">Personal</span></br>개인회원 관리<br><br>
        <span class="light">개인 회원을 관리 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminCuser" class="nav-link">
        <br><span class="bold">Franchisee</span></br>가맹점 관리<br><br>
        <span class="light">가맹점 회원을 관리 할 수 있습니다.</span>
    </a></li>
      <li><a href="/adminSales" class="nav-link">
        <br><span class="bold">Sales</span></br>판매수익 관리<br><br>
        <span class="light">가맹점별 판매수익을 확인 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminReview" class="nav-link">
        <br><span class="bold">Review</span></br>리뷰 관리<br><br>
        <span class="light">고객의 리뷰를 관리 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminQnA" class="nav-link">
        <br><span class="bold">Q&A</span></br>Q&A 관리<br><br>
        <span class="light">Q&A를 관리 할 수 있습니다.</span>
    </a></li>
    <li><a href="/adminFAQWrite" class="nav-link">
        <br><span class="bold">FAQ</span></br>FAQ 관리<br><br>
        <span class="light">FAQ를 관리 할 수 있습니다.</span>
    </a></li>
  
</ul>
</body>
</html>