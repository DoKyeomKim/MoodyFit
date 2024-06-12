-- 유저
CREATE TABLE users (
    user_idx NUMBER PRIMARY KEY,            -- 유저의 고유번호
    id VARCHAR2(100) UNIQUE NOT NULL,        -- 유저 아이디
    pw VARCHAR2(100) NOT NULL,               -- 유저 패스워드
    state NUMBER NOT NULL,                  -- 1일때 사용가능한 회원, 2가 회원 탈퇴, 3이 회원 정지(관리자)
    role VARCHAR2(50) NOT NULL              -- 스프링 시큐리티 위한 설정 
);

-- 유저 상세
CREATE TABLE person (    
    person_idx NUMBER PRIMARY KEY,          -- 일반 회원의 고유번호
    name VARCHAR2(100) NOT NULL,            -- 이름
    nick_name VARCHAR2(100) NOT NULL,       -- 닉네임
    email VARCHAR2(200) NOT NULL,           -- 이메일
    phone VARCHAR2(20),            -- 전화번호
    post_code VARCHAR2(20),        -- 주소들
    address VARCHAR2(300) ,
    detail_address VARCHAR2(300),
    social VARCHAR2(10),                    -- 소셜여부
    social_root VARCHAR2(40),               -- 소셜 로그인한 기업(네이버,카카오 등)
    user_idx NUMBER,                        -- 유저 고유번호 외래키 설정
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 배송지 정보
CREATE TABLE delivery (
    delivery_idx NUMBER PRIMARY KEY,        -- 배송지 정보의 고유번호
    name VARCHAR2(100) NOT NULL,            -- 배송 받는 사람의 이름
    content varchar2(100),					-- 배송 요청사항
    delivery_name VARCHAR2(100) NOT NULL,   -- 배송지 설정할 이름 ex) 집,회사 등등
    email VARCHAR2(100) NOT NULL,           -- 배송 받는 사람의 이메일
    phone VARCHAR2(20) NOT NULL,            -- 배송 받는 사람의 전화번호
    post_code VARCHAR2(20) NOT NULL,        -- 주소들
    address VARCHAR2(200) NOT NULL,
    detail_address VARCHAR2(200) NOT NULL,
    person_idx NUMBER,                      -- 배송지 정보를 저장시킨 일반 회원의 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 고객 상세 정보(신체)
CREATE TABLE person_spec (
    person_spec_idx NUMBER PRIMARY KEY,     -- 신체 정보 고유번호
    gender VARCHAR2(20),                          -- 성별
    height VARCHAR2(20),                          -- 키
    weight VARCHAR2(20),                          -- 몸무게
    foot VARCHAR2(20),                            -- 신발 사이즈
    top VARCHAR2(50),                       -- 상의 사이즈
    bottom VARCHAR2(50),                    -- 하의 사이즈
    person_idx NUMBER,                      -- 신체 정보를 저장시킨 일반회원 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 가맹점
CREATE TABLE store (  
    store_idx NUMBER PRIMARY KEY,            -- 가맹점 고유번호
    store_name VARCHAR2(100) NOT NULL,       -- 가맹점 ex) 나이키 서면점
    manager_name VARCHAR2(30) NOT NULL,      -- 가맹점 관리자 이름
    business_number VARCHAR2(30) NOT NULL,   -- 사업자 등록 번호
    email VARCHAR2(50) NOT NULL,             -- 회사 이메일
    phone VARCHAR2(50) NOT NULL,             -- 회사 전화  
    post_code VARCHAR2(20) NOT NULL,         -- 주소들 
    address VARCHAR2(100) NOT NULL,
    detail_address VARCHAR2(100) NOT NULL,
    user_idx NUMBER,                         -- 유저 고유번호
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 카테고리
CREATE TABLE category (
    category_idx NUMBER PRIMARY KEY,         -- 카테고리 고유번호
    kor_name VARCHAR2(30) NOT NULL,          -- 한글명
    eng_name VARCHAR2(30) NOT NULL           -- 영문명
);

-- 옷 세부분류
CREATE TABLE sub_category (    
    sub_category_idx NUMBER PRIMARY KEY,     -- 세부 카테고리의 고유번호
    kor_name VARCHAR2(30) NOT NULL,          -- 옷의 세부 한글명
    eng_name VARCHAR2(30) NOT NULL,          -- 옷의 세부 영문명
    category_idx NUMBER,                     -- 세부 카테고리의 상위 카테고리 고유번호
    FOREIGN KEY (category_idx) REFERENCES category(category_idx)
);

-- 상품
CREATE TABLE product (
    product_idx NUMBER PRIMARY KEY,          -- 제품번호
    manufacture_name VARCHAR2(100) NOT NULL,     -- 제조사 ex) 나이키
    name VARCHAR2(40) NOT NULL,                  -- 제품 이름
    price NUMBER NOT NULL,                       -- 제품 가격
    sub_category_idx NUMBER,                 -- 옷 세부 분류
    FOREIGN KEY (sub_category_idx) REFERENCES sub_category(sub_category_idx),
    store_idx NUMBER,                        -- 해당 상품을 올린 가맹점 고유번호
    FOREIGN KEY (store_idx) REFERENCES store(store_idx)
);

-- 상품 사이즈
CREATE TABLE product_size (
    product_size_idx NUMBER PRIMARY KEY,     -- 제품 사이즈의 고유번호
    sizes VARCHAR2(10) NOT NULL              -- 제품 사이즈
);

-- 상품 컬러
CREATE TABLE product_color (
    product_color_idx NUMBER PRIMARY KEY,    -- 제품 컬러의 고유번호
    color VARCHAR2(30) NOT NULL              -- 제품 컬러
);

-- 상품 상세 정보
CREATE TABLE product_info (
    product_info_idx NUMBER PRIMARY KEY,         -- 제품 정보의 고유번호
    update_date DATE DEFAULT SYSDATE,            -- 제품 변경 시 변경시점 기록용
    product_color_idx NUMBER,                    -- 색상 번호
    FOREIGN KEY (product_color_idx) REFERENCES product_color(product_color_idx),
    product_size_idx NUMBER,                     -- 사이즈 번호
    FOREIGN KEY (product_size_idx) REFERENCES product_size(product_size_idx),
    product_idx NUMBER,                          -- 제품의 고유번호
    FOREIGN KEY (product_idx) REFERENCES product(product_idx)
);

-- 재고
CREATE TABLE product_quantity(
    product_quantity_idx NUMBER PRIMARY KEY,     -- 제품 수량의 고유번호
    quantity NUMBER,                             -- 제품 수량
    update_date DATE DEFAULT SYSDATE,            -- 제품 변경시 변경시점 기록용
    product_info_idx NUMBER,                     -- 제품 정보 고유번호
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 상품 이미지 파일
CREATE TABLE product_file(
    product_file_idx NUMBER PRIMARY KEY,         -- 상품 이미지 고유번호
    original_name VARCHAR2(100) NOT NULL,        -- 파일의 원래 이름
    file_path VARCHAR2(100) NOT NULL,            -- 파일 위치+변경된 파일명(클라이언트가 올린 파일명이 겹치는걸 방지하기 위해 변경시킴)
    file_size VARCHAR2(100) NOT NULL,            -- 파일 크기
    product_info_idx NUMBER,                     -- 파일이 해당하는 상품 정보의 이미지를 나타내기 위한 idx
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 상품 공고: 판매 게시글
CREATE TABLE posting (
    posting_idx NUMBER PRIMARY KEY,              -- 상품 판매글의 고유번호
    title VARCHAR2(30) NOT NULL,                 -- 상품 판매글 제목
    content VARCHAR2(3000) NOT NULL,             -- 판매글 내용
    update_date DATE DEFAULT SYSDATE NOT NULL,   -- 등록일
    state NUMBER NOT NULL                       -- 제품 등록 상태 (0: 등록 심사중, 1: 게시글 등록 완료 2: 게시글 삭제 3: 게시글 수정)
);

-- 판매 공고 제품
CREATE TABLE posting_product (
    posting_product_idx NUMBER PRIMARY KEY,      -- 공고에 담을 제품 정보
    posting_idx NUMBER,                          -- 해당하는 판매글 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    product_info_idx NUMBER,                     -- 갖고 올 해당 제품 정보
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 판매공고 리뷰
CREATE TABLE posting_review (
    posting_review_idx NUMBER PRIMARY KEY,       -- 판매글에 해당하는 리뷰글 고유번호
    title VARCHAR2(30) NOT NULL,                 -- 리뷰글 제목
    content VARCHAR2(500) NOT NULL,              -- 리뷰글 내용
    rating NUMBER(3, 1) NOT NULL,                -- 리뷰 평점
    create_date DATE DEFAULT SYSDATE NOT NULL,   -- 생성 일자
    posting_idx NUMBER,                          -- 해당하는 판매글 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    person_idx NUMBER,                           -- 리뷰를 쓴 사람의 고유번호(일반회원만 되게 person_idx를 갖고옴)
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 리뷰 파일
CREATE TABLE posting_review_file (
    posting_review_file_idx NUMBER PRIMARY KEY,  -- 리뷰에 쓸 파일 고유번호
    file_path VARCHAR2(100) NOT NULL,            -- 저장될 파일 위치+변경된 파일명(파일명 중복방지하고 불러오기 위해서)
    original_name VARCHAR2(100) NOT NULL,        -- 기존 파일명
    file_size VARCHAR2(100) NOT NULL,            -- 파일크기
    posting_review_idx NUMBER,                   -- 해당하는 리뷰 고유번호
    FOREIGN KEY (posting_review_idx) REFERENCES posting_review(posting_review_idx)
);

-- 판매공고 질문
CREATE TABLE posting_question (  
    posting_question_idx NUMBER PRIMARY KEY,     -- 상품문의 고유번호
    title VARCHAR2(30) NOT NULL,                 -- 상품문의 제목
    content VARCHAR2(200) NOT NULL,              -- 상품문의 내용
    create_date DATE DEFAULT SYSDATE,            -- 상품문의 등록일
    posting_idx NUMBER,                          -- 상품문의 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    person_idx NUMBER,                           -- 상품문의 작성자
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 상품 문의 답글
CREATE TABLE posting_answer (    
    posting_answer_idx NUMBER PRIMARY KEY,       -- 상품 문의 답변글 고유번호
    content VARCHAR2(200) NOT NULL,              -- 답변글 내용
    create_date DATE DEFAULT SYSDATE,            -- 답변글 작성일
    posting_question_idx NUMBER,                 -- 문의 고유번호
    FOREIGN KEY (posting_question_idx) REFERENCES posting_question(posting_question_idx)
);

-- 장바구니
CREATE TABLE cart (  
    cart_idx NUMBER PRIMARY KEY,                 -- 장바구니 고유번호
    state varchar2(50) default '진행중' not null, -- 장바구니 태
    product_idx NUMBER,                    		 -- 제품 정보 고유번호
    FOREIGN KEY (product_idx) REFERENCES product(product_idx),
    posting_idx NUMBER,							 -- 상품글의 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    person_idx NUMBER,                           -- 장바구니의 주인 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx),
    product_info_idx NUMBER,                           -- 제품 상세 고유번호
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 주문 상세 정보
CREATE TABLE order_detail (
    order_detail_idx NUMBER PRIMARY KEY,       -- 주문 상세 정보 고유번호
    state VARCHAR2(50) DEFAULT '진행중' NOT NULL, -- 주문 상태
    quantity NUMBER NOT NULL,                  -- 주문 수량
    price NUMBER NOT NULL,                     -- 가격
    cart_idx NUMBER,                           -- 장바구니 고유번호
    FOREIGN KEY (cart_idx) REFERENCES cart(cart_idx)
);

-- 주문
CREATE TABLE orders (
    order_idx NUMBER PRIMARY KEY,                -- 주문 고유번호
    amount NUMBER,                        		 -- 주문할 당시 제품 가격(결제내역의 가격이 amount라서 같게 설정함)
    merchant_uid VARCHAR2(100),					 -- 주문번호(결제내역의 주문번호)
    delivery_price NUMBER,                       -- 배송비
    total_price NUMBER,                          -- 제품 가격+배송비
    order_date DATE DEFAULT SYSDATE,             -- 주문일자
    imp_uid	VARCHAR2(100) UNIQUE,			 -- 결제시 결제내역 확인하는 번호
    person_idx NUMBER,                           -- 주문한 사람
    FOREIGN KEY (person_idx) REFERENCES person(person_idx),
    delivery_idx NUMBER,                         -- 배송지
    FOREIGN KEY (delivery_idx) REFERENCES delivery(delivery_idx),
    order_detail_idx NUMBER,                         -- 주문상세 물품
    FOREIGN KEY (order_detail_idx) REFERENCES order_detail(order_detail_idx)
);

-- 결제 내역
CREATE TABLE payment (
    payment_idx NUMBER PRIMARY KEY,              -- 결제 내역 고유번호
    pg VARCHAR2(20) NOT NULL,					 -- 결제 대행사 고유 코드
    pay_method NUMBER NOT NULL,                  -- 결제 수단(0: 카드, 1: 무통장입금, 2: 카카오페이 등)
    imp_uid VARCHAR2(100),						 -- 결제 내역확인하는 고유 코드번호
    FOREIGN KEY (imp_uid) REFERENCES orders(imp_uid)
);

-- 고객센터
CREATE TABLE cs (
    cs_idx NUMBER PRIMARY KEY,   -- 고객센터 고유번호(근데 이게 있어야하나? 하나뿐인데?)
    user_idx NUMBER,
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 고객센터 FAQ
CREATE TABLE cs_faq (
    faq_idx NUMBER PRIMARY KEY,  -- FAQ 고유번호
    title VARCHAR2(30) NOT NULL, -- FAQ 제목
    content VARCHAR2(300) NOT NULL, -- FAQ 내용
    cs_idx NUMBER, -- 고객센터 고유번호
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

-- 고객센터 Q&A
CREATE TABLE cs_qna (
    qna_idx NUMBER PRIMARY KEY,  -- QNA 고유번호
    cs_idx NUMBER, -- 고객센터 고유번호
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

-- Q&A 질문
CREATE TABLE cs_question (
    question_idx NUMBER PRIMARY KEY, -- 질문 고유번호
    title VARCHAR2(30) NOT NULL, -- 질문 제목
    content VARCHAR2(1000) NOT NULL, -- 질문 내용
    create_date DATE DEFAULT SYSDATE NOT NULL, -- 생성일
    update_date DATE DEFAULT SYSDATE, -- 수정일
    state NUMBER NOT NULL, -- 상태 (1일땐 등록 2일땐 삭제)
    qna_idx NUMBER, -- 질문을 쓸 QNA 게시판의 고유번호
    FOREIGN KEY (qna_idx) REFERENCES cs_qna(qna_idx),
    user_idx NUMBER, -- 질문을 쓴 유저 고유번호
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- Q&A 답변
CREATE TABLE cs_answer (
    answer_idx NUMBER PRIMARY KEY, -- 답변 고유번호
    title VARCHAR2(30) NOT NULL, -- 답변 제목
    content VARCHAR2(300) NOT NULL, -- 답변 내용
    create_date DATE DEFAULT SYSDATE NOT NULL, -- 답변 생성일
    update_date DATE DEFAULT SYSDATE NOT NULL, -- 수정일
    question_idx NUMBER, -- 해당 답변의 질문 고유번호
    FOREIGN KEY (question_idx) REFERENCES cs_question(question_idx)
);



-----------------------------------------
관리자
카테고리 추가/수정/삭제
서브카테고리 추가/수정/삭제
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

CREATE SEQUENCE store_seq
	START WITH 1
	INCREMENT BY 1;
	
CREATE SEQUENCE person_spec_seq
	START WITH 1
	INCREMENT BY 1;

CREATE SEQUENCE delivery_seq
	START WITH 1
	INCREMENT BY 1;
    
CREATE SEQUENCE category_seq
	START WITH 1
	INCREMENT BY 1;
    
CREATE SEQUENCE sub_category_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE product_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE product_size_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE product_color_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE product_info_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE product_quantity_seq 
	START WITH 1
	INCREMENT BY 1;
    
    
    CREATE SEQUENCE product_file_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE posting_seq
	START WITH 1
	INCREMENT BY 1;
   
    CREATE SEQUENCE posting_product_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE posting_review_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE posting_review_file_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE  posting_question_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE posting_answer_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cart_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE order_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE order_detail_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE payment_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cs_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cs_faq_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cs_qna_seq
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cs_question_seq 
	START WITH 1
	INCREMENT BY 1;
    
    CREATE SEQUENCE cs_answer_seq
	START WITH 1
	INCREMENT BY 1;
	
	
