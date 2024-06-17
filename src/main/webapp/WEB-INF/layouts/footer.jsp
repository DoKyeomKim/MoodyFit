<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
    font-family: '맑은 고딕', 'Nanum Gothic', Verdana, Dotum, AppleGothic, sans-serif;
    margin: 0;
    padding: 0;
    font-size: 11px; /* 기본 폰트 크기를 11px로 설정 */
}
footer {
    background-color: #f8f8f8;
    border-top: 1px solid #e7e7e7;
    padding: 40px 0;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    font-size: 11px; /* 푸터 폰트 크기를 11px로 설정 */
}
.footer-column {
    flex: 1;
    padding: 10px;
    box-sizing: border-box;
    border-right: 1px solid #e7e7e7; /* 세로줄 추가 */
    margin-left : 70px;
}
.footer-column:last-child {
    border-right: none; /* 마지막 열의 세로줄 제거 */
}
.footer-column h3 {
    margin-top: 0;
    font-size: 13px; /* 헤딩 크기를 약간 더 크게 설정 */
}
.footer-column p,
.footer-column a {
    margin: 5px 0;
    color: #333;
    text-decoration: none;
    font-size: 11px; /* 본문 폰트 크기를 11px로 설정 */
}
.footer-column a:hover {
    text-decoration: underline;
}
.footer-column .bold {
    font-weight: bold;
}
.footer .bottom-links {
    text-align: center;
    padding: 10px 0;
    background-color: #f1f1f1;
    width: 100%;
    font-size: 11px; /* 하단 링크 폰트 크기를 11px로 설정 */
}
.footer .bottom-links a {
    margin: 0 10px;
    color: #333;
    text-decoration: none;
    font-size: 11px; /* 하단 링크 폰트 크기를 11px로 설정 */
}
.footer .bottom-links a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>
 <footer>
    <div class="footer-column">
        <h3 class="bold">C/S CENTER</h3>
        <p class="bold">T. 041-579-3720</p>
        <p>평일 am 11:00 - pm 05:00 · 점심 pm 01:00 - pm 02:00</p>
        <p>토,일,공휴일 휴무</p>
        <p>* 고객센터가 연결되지 않는 경우 게시판으로 문의주세요.</p>
        <a href="/qna" class="text-dark" style="text-decoration: none;">Q&A게시판 바로가기</a>
        <h3>ACCOUNT</h3>
        <p>농협 356-1087-7215-43</p>
        <p>예금주: 주식회사 무디핏</p>
    </div>
    <div class="footer-column">
        <img src="/images/logo.png" alt="GOPEOPLE 로고" style="width: 100px;">
        <p>COMPANY. 주식회사 무디핏</p>
        <p>OWNER. 96&97s</p>
        <p>TEL. 041-579-3720</p>
        <p>ADDRESS. 13561 경기 성남시 분당구 정자일로 95</p>
        <p>BUSINESS LICENSE. 720-88-00965</p>
        <p>ONLINE ORDER LICENSE. 제 2018-부산-0990 호 [사업자정보확인]</p>
        <p>CHIEF PRIVACY OFFICER. 96&97s</p>
        <p>E-MAIL. e8014@naver.com</p>
        <p>HOSTING BY 카페24(주)</p>
    </div>
    <div class="footer-column">
        <h3 class="bold">교환/반품주소</h3>
        <p>(13561) 경기 성남시 분당구 정자일로 95</p>
        <p>* 고객센터에 접수 후 상품 보내주셔야 하며, 지정택배사를 이용해주시기 바랍니다.</p>
        <a href="#" class="text-dark" style="text-decoration: none;">우체국택배 배송조회하기</a>
        <h3>SNS</h3>
        <p><a href="https://www.instagram.com/shnmje" class="text-dark" style="text-decoration: none;">INSTAGRAM @shnmje</a></p>
        <p><a href="https://www.facebook.com/moodyfit" class="text-dark" style="text-decoration: none;">FACEBOOK @moodyfit</a></p>
    </div>
 </footer>
 <div class="bottom-links">
    <a href="/">홈으로</a>
    <a href="/company">회사소개</a>
    <a href="/terms">이용약관</a>
    <a href="/privacy">개인정보처리방침</a>
    <a href="/faq">이용안내</a>
</div>
</body>
</html>
