-- 유저
CREATE TABLE users (
    user_idx NUMBER PRIMARY KEY,
    id VARCHAR2(30) UNIQUE NOT NULL,
    pw VARCHAR2(80) NOT NULL,
    state NUMBER NOT NULL,        -- 1일때 회원 유지,2가 회원 탈퇴, 3이 회원 정지(관리자)
    role VARCHAR2(50) NOT NULL	  -- 스프링 시큐리티 위한 설정 
);

--유저상세
CREATE TABLE person (    
    person_idx NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    nick_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(200) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    post_code VARCHAR2(20) NOT NULL,
    address VARCHAR2(300) NOT NULL,
    detail_address VARCHAR2(300) NOT NULL,
    social varchar2(30),
    social_root varchar2(40),
    user_idx NUMBER
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

--배송지정보
CREATE TABLE delivery (
    delivery_idx NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL, -- 배송지정보
    delivery_name varchar2(100) not null,
    email VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    post_code VARCHAR2(20) NOT NULL,
    address VARCHAR2(200) NOT NULL,
    detail_address VARCHAR2(200) NOT NULL,
    person_idx NUMBER
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

고객 상세 정보(신체)
CREATE TABLE person_spec (
    person_idx NUMBER,
    person_spec_idx NUMBER PRIMARY KEY,
    gender NUMBER,
    height NUMBER,
    weight NUMBER,
    foot NUMBER,
    top VARCHAR2(50),
    bottom VARCHAR2(50),
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

// 가맹점
CREATE TABLE store (  
    store_idx NUMBER PRIMARY KEY,          
    manufacture_name VARCHAR2(100) NOT NULL,    // 제조사
    store_name             VARCHAR2(100) NOT NULL,    // 가맹점
    manager_name VARCHAR2(30) NOT NULL,     // 가맹점 관리자 이름 manager_name 
    business_number VARCHAR2(30) NOT NULL,  // 사업자 등록 번호
    email VARCHAR2(50) NOT NULL,            // 회사 이메일
    phone VARCHAR2(50) NOT NULL,            // 회사 전화  
    post_code VARCHAR2(20) NOT NULL,        // 주소들 
    address VARCHAR2(100) NOT NULL,
    detail_address VARCHAR2(100) NOT NULL,
    user_idx NUMBER
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 카테고리 (옷 종류, 아웃터, 악세서리, 신발, 셔츠, 바지, ...)
CREATE TABLE category (
    category_idx NUMBER PRIMARY KEY,
    kor_name VARCHAR2(30) NOT NULL,
    eng_name VARCHAR2(30) NOT NULL
);

 //  옷 세부분류 
CREATE TABLE sub_category (    
    sub_category_idx NUMBER PRIMARY KEY,
    kor_name VARCHAR2(30) NOT NULL,
    eng_name VARCHAR2(30) NOT NULL,
    category_idx NUMBER
    FOREIGN KEY (category_idx) REFERENCES category(category_idx)
);

-- 상품
CREATE TABLE product (
    product_idx NUMBER PRIMARY KEY,  // 제품번호
    sub_category_idx NUMBER,         // 옷 세부분류  
    store_idx NUMBER,              // 가맹점 정보
  // 제거    state VARCHAR2(10) NOT NULL,     // 관리자 인증 -> posting
    FOREIGN KEY (sub_category_idx) REFERENCES sub_category(sub_category_idx),
    FOREIGN KEY (store_idx) REFERENCES store(store_idx)
);

-- 상품 사이즈
CREATE TABLE product_size (
    product_info_idx NUMBER,
    product_size_idx NUMBER PRIMARY KEY,
    sizes VARCHAR2(10) NOT NULL,
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 상품 색상
CREATE TABLE product_color (
    product_info_idx NUMBER,
    product_color_idx NUMBER PRIMARY KEY,
    color VARCHAR2(30) NOT NULL,
    eng_color VARCHAR2(30) NOT NULL,
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 상품 상세 정보
CREATE TABLE product_info (
    product_idx NUMBER,
    product_info_idx NUMBER PRIMARY KEY,
    name VARCHAR2(40) NOT NULL,
    price NUMBER NOT NULL,
    FOREIGN KEY (product_idx) REFERENCES product(product_idx)
    size_idx NUMBER NOT NULL
    FOREIGN KEY (size_idx) REFERENCES product(product_idx)
    color_idx NUMBER NOT NULL
    FOREIGN KEY (color_idx) REFERENCES product(product_idx)
    가맹점 정보
);

// 수정필요
-- 상품 수량(재고) : 입고/출력
CREATE TABLE product_quantity (
    product_quantity_idx NUMBER PRIMARY KEY,
    quantity NUMBER,
    product_info_idx
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx),    
);
// 수정

-- 상품공고: 판매 게시긒 - 전체수정
CREATE TABLE posting (
    posting_idx NUMBER PRIMARY KEY,    
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_date VARCHAR2(30) DEFAULT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') NOT NULL, // 등록일
    state NUMBER NOT NULL,
    product_info_idx NUMBER,
    FOREIGN KEY (product_info_idx) REFERENCES product(product_info_idx)
);

?* 전체 변경
CREATE TABLE posting_file (
    posting_idx NUMBER,
    posting_file_idx NUMBER PRIMARY KEY,
    file_path VARCHAR2(100) NOT NULL,
    file_size VARCHAR2(100) NOT NULL,
    original_name VARCHAR2(100) NOT NULL,
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx)
);
*/

CREATE TABLE posting_review (
    posting_review_idx NUMBER PRIMARY KEY, 
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    rating NUMBER(3, 1) NOT NULL,
    create_date VARCHAR2(30) NOT NULL,
    posting_idx NUMBER   
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    person_idx NUMBER
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

CREATE TABLE posting_review_file (
    posting_review_file_idx NUMBER PRIMARY KEY,
    file_path VARCHAR2(100) NOT NULL,
    original_name VARCHAR2(100) NOT NULL,
    file_size VARCHAR2(100) NOT NULL,
    posting_review_idx NUMBER,
    FOREIGN KEY (posting_review_idx) REFERENCES posting_review(posting_review_idx)
);

CREATE TABLE posting_question (  --  qna
    posting_question_idx NUMBER PRIMARY KEY,
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_date VARCHAR2(30) NOT NULL,
    posting_idx NUMBER
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    user_idx NUMBER
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

CREATE TABLE posting_answer (
    posting_answer_idx NUMBER PRIMARY KEY,
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_date VARCHAR2(30) NOT NULL,
    posting_question_idx NUMBER
    FOREIGN KEY (posting_question_idx) REFERENCES posting_question(posting_question_idx),
    user_idx NUMBER
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 장바구니
CREATE TABLE cart (
    cart_idx NUMBER PRIMARY KEY,
    person_idx NUMBER,
    posting_idx NUMBER,
    주문 수량
    배송료정보
    FOREIGN KEY (person_idx) REFERENCES person(person_idx),
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx)
);

-- 찜
CREATE TABLE wish (
    wish_idx NUMBER PRIMARY KEY,
    person_idx NUMBER,
    posting_idx NUMBER,
    FOREIGN KEY (person_idx) REFERENCES person(person_idx),
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx)
);

-- 주문목록 - 결재 완료후
CREATE TABLE orders (
    order_idx NUMBER PRIMARY KEY,
    count NUMBER NOT NULL,
    price NUMBER NOT NULL,
    create_date VARCHAR2(30) NOT NULL,  -- 주문일
    배송state VARCHAR2(20) NOT NULL, -- 배송상태( 배송준비중, 배송중, 배송완료) -배송정보
    주문상태 : 취소, 교환, 환불
    상태변환날짜
    posting_idx NUMBER
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    cart_idx NUMBER
    FOREIGN KEY (cart_idx) REFERENCES cart(cart_idx)
);

-- 결제(토스연계)
CREATE TABLE payment (   
    payment_idx NUMBER PRIMARY KEY,
    pg    VARCHAR2(30) NOT NULL DEFAULT tosspayments,
    pay_method VARCHAR2(30) NOT NULL,
    state VARCHAR2(20) NOT NULL DEFAULT 결제중,
    notice_url VARCHAR2(30),
    vbank_due NUMBER DEFAULT 6,
    order_idx NUMBER
    FOREIGN KEY (order_idx) REFERENCES orders(order_idx)
);

-- 고객센터
CREATE TABLE cs (
    cs_idx NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    eng_name VARCHAR2(20) NOT NULL,
    전화번호
    담당자 이름
    주소(우편번호, 주소, 상세주소)
);

CREATE TABLE cs_faq (
    cs_idx NUMBER,
    faq_idx NUMBER PRIMARY KEY,
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

CREATE TABLE cs_qna (
    cs_idx NUMBER,
    qna_idx NUMBER PRIMARY KEY,
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

CREATE TABLE cs_question (
    question_idx NUMBER PRIMARY KEY,
    qna_idx NUMBER,
    user_idx NUMBER,
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_date VARCHAR2(30) NOT NULL,
    update_date VARCHAR2(30),
    state NUMBER NOT NULL,
    FOREIGN KEY (qna_idx) REFERENCES cs_qna(qna_idx),
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

CREATE TABLE cs_answer (
    answer_idx NUMBER PRIMARY KEY,
    question_idx NUMBER,
    title VARCHAR2(30) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_date VARCHAR2(30) NOT NULL,
    FOREIGN KEY (question_idx) REFERENCES cs_question(question_idx)
);

sql
-----------------------------------------
관리자
카타고리 추가/수정/삭제
서브카타고리 추가/수정/삭제
회원관리
판매글게시글관리 - 신청하면 승인/반려 한다
리뷰관리         - 신청하면 승인/반려 한다
faq, qna 관리    - 신청하면 승인/반려 한다
가맹점 관리

통계
 주문통계
 판매금액 통계
 
-----------------------------------------

CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE person_seq
    START WITH 1
    INCREMENT BY 1;

