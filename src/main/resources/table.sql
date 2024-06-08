-- 유저
CREATE TABLE users (
    user_idx NUMBER PRIMARY KEY,		-- 유저의 고유번호
    id VARCHAR2(30) UNIQUE NOT NULL,	-- 유저 아이디
    pw VARCHAR2(80) NOT NULL,		-- 유저 패스워드
    state NUMBER NOT NULL,        		-- 1일때 사용가능한 회원, 2가 회원 탈퇴, 3이 회원 정지(관리자)
    role VARCHAR2(50) NOT NULL	  	-- 스프링 시큐리티 위한 설정 
);

--유저상세
CREATE TABLE person (    
    person_idx NUMBER PRIMARY KEY,		-- 일반 회원의 고유번호
    name VARCHAR2(100) NOT NULL, 		-- 이름
    nick_name VARCHAR2(100) NOT NULL, 	-- 닉네임
    email VARCHAR2(200) NOT NULL,		-- 이메일
    phone VARCHAR2(20) NOT NULL,		-- 전화번호
    post_code VARCHAR2(20) NOT NULL,	-- 주소들
    address VARCHAR2(300) NOT NULL,
    detail_address VARCHAR2(300) NOT NULL,
    social varchar2(10), 			-- 소셜여부
    social_root varchar2(40), 			-- 소셜 로그인한 기업(네이버,카카오 등)
    user_idx NUMBER			-- 유저 고유번호 외래키 설정
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

--배송지정보
CREATE TABLE delivery (
    delivery_idx NUMBER PRIMARY KEY,	-- 배송지 정보의 고유번호
    name VARCHAR2(100) NOT NULL, 		-- 배송 받는 사람의 이름
    delivery_name varchar2(100) not null, 	-- 배송지 설정할 이름 ex) 집,회사 등등
    email VARCHAR2(100) NOT NULL,		-- 배송 받는 사람의 이메일
    phone VARCHAR2(20) NOT NULL,		-- 배송 받는 사람의 전화번호
    post_code VARCHAR2(20) NOT NULL,	-- 주소들
    address VARCHAR2(200) NOT NULL,
    detail_address VARCHAR2(200) NOT NULL,
    person_idx NUMBER			-- 배송지 정보를 저장시킨 일반 회원의 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);


고객 상세 정보(신체)
CREATE TABLE person_spec (
    person_spec_idx NUMBER PRIMARY KEY,	-- 신체 정보 고유번호
    gender NUMBER,			-- 성별
    height NUMBER, 			-- 키
    weight NUMBER,			-- 몸무게
    foot NUMBER,				-- 신발 사이즈
    top VARCHAR2(50),			-- 상의 사이즈
    bottom VARCHAR2(50),			-- 하의 사이즈
    person_idx NUMBER			-- 신체 정보를 저장시킨 일반회원 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

--가맹점 이름 store로 변경
CREATE TABLE STORE(  
    store_idx NUMBER PRIMARY KEY,			-- 가맹점 고유번호
    store_name             VARCHAR2(100) NOT NULL,	-- 가맹점 ex) 나이키 서면점
    manager_name VARCHAR2(30) NOT NULL,		-- 가맹점 관리자 이름 manager_name 
    business_number VARCHAR2(30) NOT NULL,  	-- 사업자 등록 번호
    email VARCHAR2(50) NOT NULL,           		-- 회사 이메일
    phone VARCHAR2(50) NOT NULL,           		-- 회사 전화  
    post_code VARCHAR2(20) NOT NULL,       		-- 주소들 
    address VARCHAR2(100) NOT NULL,
    detail_address VARCHAR2(100) NOT NULL,
    user_idx NUMBER				-- 유저 고유번호
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 카테고리 (옷 종류, 아우터, 악세서리, 신발, 셔츠, 바지, ...) 미리 더미데이터 입력 + 관리자 페이지에서 추가/수정/삭제
CREATE TABLE category (
    category_idx NUMBER PRIMARY KEY,	-- 카테고리 고유번호
    kor_name VARCHAR2(30) NOT NULL,	-- 한글명
    eng_name VARCHAR2(30) NOT NULL	-- 영문명
);

 //  옷 세부분류 (아우터 -> 코트,바람막이,패딩,....)  미리 더미데이터 입력 + 관리자 페이지에서 추가/수정/삭제
CREATE TABLE sub_category (    
    sub_category_idx NUMBER PRIMARY KEY,	-- 세부 카테고리의 고유번호
    kor_name VARCHAR2(30) NOT NULL,	-- 옷의 세부 한글명
    eng_name VARCHAR2(30) NOT NULL,	-- 옷의 세부 영문명
    category_idx NUMBER			-- 세부 카테고리의 상위 카테고리 고유번호
    FOREIGN KEY (category_idx) REFERENCES category(category_idx)
);

-- 상품
CREATE TABLE product (
    product_idx NUMBER PRIMARY KEY,	-- 제품번호
    sub_category_idx NUMBER,		-- 옷 세부 분류
    FOREIGN KEY (sub_category_idx) REFERENCES sub_category(sub_category_idx),
    store_idx NUMBER,			-- 해당 상품을 올린 가맹점 고유번호
    FOREIGN KEY (store_idx) REFERENCES store(store_idx)

);

--상품 사이즈 // 사이즈들을 미리 입력 해놓고 선택했을때 해당 idx를 상세정보로 넘겨주게
CREATE TABLE product_size (
    product_size_idx NUMBER PRIMARY KEY,	-- 제품 사이즈의 고유번호
    sizes VARCHAR2(10) NOT NULL,		-- 제품 사이즈
);

-- 상품 컬러 // 컬러들을 미리 입력해놓고 선택했을 시 해당 idx를 상세정보로 넘겨주게
CREATE TABLE product_color (
    product_color_idx NUMBER primary key	-- 제품 컬러의 고유번호
    color VARCHAR2(30) NOT NULL,		-- 제품 컬러
);

-- 상품 상세 정보. product에서 빼내서 테이블을 추가한 이유(색상, 컬러등이 다르더라도 제품번호가 동일하게 유지시키기 위해서)
-- 제품 변경시 update가 아니라 기록이 남게 새로운 내용을 하나 더 추가
-- 설명추가 : 만약 상품의 정보가 변경되더라도 예전에 있던 내용은 그대로 포스팅에 남아있고, 새로 작성하게.
CREATE TABLE product_info (
    product_info_idx NUMBER PRIMARY KEY,		-- 제품 정보의 고유번호
    manufacture_name VARCHAR2(100) NOT NULL,	-- 제조사 ex) 나이키
    name VARCHAR2(40) NOT NULL,			-- 제품 이름
    price NUMBER NOT NULL,			-- 제품 가격
    update_date date default sysdate,			-- 제품 변경 시 변경시점 기록용
    product_color_idx number,			-- 색상 번호
    FOREIGN KEY (product_color_idx) REFERENCES product_color(product_color_idx)
    product_size_idx number,				-- 사이즈 번호
    FOREIGN KEY (product_size_idx) REFERENCES product_size(product_size_idx)
    product_idx NUMBER,				-- 제품의 고유번호
    FOREIGN KEY (product_idx) REFERENCES product_quantity(product_idx)

);

-- 재고 // 인포에서 저장된 정보를 토대로 해당 수량 입력받음. 위와 마찬가지로 새로운 기록 추가
-- 재고 수량은 변경 되더라도 별도의 테이블에서 관리중이기에 posting이랑 연관은 없을거 같음
-- 대신 갑자기 클라이언트가 posting 등록 후 내용을 변경시 어떻게 할건지? 신청을 따로 만들어야하나?
CREATE TABLE product_quantity(
    product_quantity_idx NUMBER PRIMARY KEY,		-- 제품 수량의 고유번호
    quantity NUMBER,				-- 제품 수량
    update_date date default sysdate,			-- 제품 변경시 변경시점 기록용
    product_info_idx NUMBER			--
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);

-- 상품 이미지 파일
CREATE TABLE product_file(
   product_file_idx NUMBER PRIMARY KEY,	-- 상품 이미지 고유번호
   original_name VARCHAR2(100) NOT NULL,	-- 파일의 원래 이름
   file_path VARCHAR2(100) NOT NULL,	-- 파일 위치+변경된 파일명(클라이언트가 올린 파일명이 겹치는걸 방지하기 위해 변경시킴)
   file_size VARCHAR2(100) NOT NULL,	-- 파일 크기
   product_info_idx NUMBER			-- 파일이 해당하는 상품 정보의 이미지를 나타내기 위한 idx
   FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx)
);



-- 상품공고: 판매 게시글
-- 판매글을 수정하게 되면 바로 update를 쓰는게 아니라 
-- 판매글이 하나 새로 추가 되고(다시 허가 받아야함), 기존 게시글의 정보는 유지하기 위해서
CREATE TABLE posting (
    posting_idx NUMBER PRIMARY KEY,	    -- 상품 판매글의 고유번호
    title VARCHAR2(30) NOT NULL,		    -- 상품 판매글 제목
    content VARCHAR2(3000) NOT NULL,	    -- 판매글 내용
    update_date date DEFAULT SYSDATE NOT NULL, -- 등록일
    state NUMBER NOT NULL,		    -- 제품 등록 상태 ( 0 : 등록 심사중, 1: 게시글 등록 완료 2: 게시글 삭제 3: 게시글 수정)
    product_info_idx NUMBER,		    -- 갖고 올 해당 제품 정보
    FOREIGN KEY (product_info_idx) REFERENCES product(product_info_idx)
);


-- 판매공고 리뷰
CREATE TABLE posting_review (
    posting_review_idx NUMBER PRIMARY KEY, 	  -- 판매글에 해당하는 리뷰글 고유번호
    title VARCHAR2(30) NOT NULL,		  -- 리뷰글 제목
    content VARCHAR2(500) NOT NULL,	  -- 리뷰글 내용
    rating NUMBER(3, 1) NOT NULL,		  -- 리뷰 평점
    create_date date default sysdate NOT NULL,	  -- 생성 일자
    posting_idx NUMBER   			  -- 해당하는 판매글 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    person_idx NUMBER			  -- 리뷰를 쓴 사람의 고유번호(일반회원만 되게 person_idx를 갖고옴)
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 리뷰 파일
CREATE TABLE posting_review_file (
    posting_review_file_idx NUMBER PRIMARY KEY,	-- 리뷰에 쓸 파일 고유번호
    file_path VARCHAR2(100) NOT NULL,		-- 저장될 파일 위치+변경된 파일명(파일명 중복방지하고 불러오기 위해서)
    original_name VARCHAR2(100) NOT NULL,		-- 기존 파일명
    file_size VARCHAR2(100) NOT NULL,		-- 파일크기
    posting_review_idx NUMBER,			-- 해당하는 리뷰 고유번호
    FOREIGN KEY (posting_review_idx) REFERENCES posting_review(posting_review_idx)
);

-- 판매공고 질문
CREATE TABLE posting_question (  
    posting_question_idx NUMBER PRIMARY KEY,	-- 판매공고 질문 고유번호
    title VARCHAR2(30) NOT NULL,			-- 질문 제목
    content VARCHAR2(500) NOT NULL,		-- 질문 내용
    create_date default sysdate NOT NULL,		-- 생성일자
    posting_idx NUMBER				-- 해당하는 판매글 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    user_idx NUMBER				-- 질문을 쓴 사람의 고유번호(일반회원이 아니더라도 작성가능하게 user_idx로)
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 판매공고 답변
CREATE TABLE posting_answer (
    posting_answer_idx NUMBER PRIMARY KEY,		-- 답변 고유번호
    title VARCHAR2(30) NOT NULL,			-- 답변 제목
    content VARCHAR2(500) NOT NULL,		-- 답변 내용
    create_date default sysdate NOT NULL,		-- 생성일자
    posting_question_idx NUMBER			-- 해당하는 질문의 고유번호
    FOREIGN KEY (posting_question_idx) REFERENCES posting_question(posting_question_idx),
    user_idx NUMBER				-- 답변을 작성한 사람의 고유번호(일반회원이 아니더라도 작성가능하게 user_idx로)
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 장바구니
CREATE TABLE cart (
    cart_idx NUMBER PRIMARY KEY,		--장바구니 내 고유번호
    count NUMBER, 			-- 주문 수량
    delivery_pay NUMBER 			-- 배송료 정보
    product_info_idx NUMBER,		-- 장바구니에 담은 상품의 정보에 대한 고유번호
    FOREIGN KEY (product_info_idx) REFERENCES product_info(product_info_idx),
    person_idx NUMBER,			-- 해당 장바구니를 갖고 있는 일반유저의 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx)
);

-- 찜
CREATE TABLE wish (
    wish_idx NUMBER PRIMARY KEY,	-- 찜 고유 번호
    person_idx NUMBER,		-- 해당 일반 유저의 고유번호
    FOREIGN KEY (person_idx) REFERENCES person(person_idx),
    posting_idx NUMBER,		-- 찜한 판매공고
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx)
);

-- 주문목록 - 결제 완료 후
-- !!!아직 미완성!!!
-- 주문 목록인데 판매글을 연결 시키는건 아닌거 같은 느낌? 제품 자체랑 연결 시켜야하지않나
-- 배송 상태와 주문 상태가 한 테이블에 있어도 되는지 잘 모르겠음
CREATE TABLE orders (
    order_idx NUMBER PRIMARY KEY,		-- 주문 고유번호
    count NUMBER NOT NULL,		-- 주문수량
    price NUMBER NOT NULL,		-- 주문가격
    create_date default sysdate NOT NULL,  	-- 주문일
    delivery_state VARCHAR2(20) NOT NULL, 	-- 배송 상태(배송준비중, 배송중, 배송완료)
    update_date date default sysdate not null,	-- 배송 상태 변경일 ex) 배송중 -> 배송완료일 때 변경되게
    order_state varchar2(20), 			-- 주문상태 : 취소, 교환, 환불
    posting_idx NUMBER			-- 주문시킨 판매공고 고유번호
    FOREIGN KEY (posting_idx) REFERENCES posting(posting_idx),
    cart_idx NUMBER			-- 넘어온 장바구니 고유번호
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
    cs_idx NUMBER PRIMARY KEY,	 	-- 고객센터 고유번호(근데 이게 있어야하나? 하나뿐인데?)
    user_idx number
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- 고객센터 faq
CREATE TABLE cs_faq (
    faq_idx NUMBER PRIMARY KEY,		--FAQ 고유번호
    title VARCHAR2(30) NOT NULL,		--FAQ 제목
    content VARCHAR2(300) NOT NULL,	--FAQ 내용
    cs_idx NUMBER,				--고객센터 고유번호
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

-- 고객센터 qna
CREATE TABLE cs_qna (
    qna_idx NUMBER PRIMARY KEY,		-- QNA 고유번호
    cs_idx NUMBER				-- 고객센터 고유번호
    FOREIGN KEY (cs_idx) REFERENCES cs(cs_idx)
);

-- qna 질문
CREATE TABLE cs_question (
    question_idx NUMBER PRIMARY KEY,	-- 질문 고유번호
    title VARCHAR2(30) NOT NULL,		-- 질문 제목
    content VARCHAR2(1000) NOT NULL,	-- 질문 내용
    create_date default sysdate NOT NULL,	-- 생성일
    update_date default sysdate,		-- 수정일
    state NUMBER NOT NULL,		-- 상태 (1일땐 등록 2일땐 삭제)
    qna_idx NUMBER,			-- 질문을 쓸 qna 게시판의 고유번호
    FOREIGN KEY (qna_idx) REFERENCES cs_qna(qna_idx),
    user_idx NUMBER,			-- 질문을 쓴 유저 고유번호
    FOREIGN KEY (user_idx) REFERENCES users(user_idx)
);

-- qna 답변
CREATE TABLE cs_answer (
    answer_idx NUMBER PRIMARY KEY,		-- 답변 고유번호
    title VARCHAR2(30) NOT NULL,		-- 답변 제목
    content VARCHAR2(300) NOT NULL,	-- 답변 내용
    create_date default sysdate NOT NULL,	-- 답변 생성일
    update_date default sysdate NOT NULL,		-- 수정일
    question_idx NUMBER,			-- 해당 답변의 질문 고유번호
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

