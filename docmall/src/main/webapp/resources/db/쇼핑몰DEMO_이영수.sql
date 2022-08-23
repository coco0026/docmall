/*
작성자 : 이영수
편집일 : 2022-07-12
프로젝트명 : 쇼핑몰(공통)
*/



--관리자에서 생성
CREATE USER SPRING IDENTIFIED BY SPRING;

GRANT CONNECT, RESOURCE, DBA TO SPRING;

--회원 테이블
CREATE TABLE MEMBER_TBL (
    MBR_ID              VARCHAR2(15)            CONSTRAINT PK_MEMBER_ID PRIMARY KEY, --회원아이디
    MBR_NM              VARCHAR2(30)            NOT NULL, --회원이름
    MBR_PW              VARCHAR2(60)            NOT NULL, --회원패스워드
    MBR_ZIP             CHAR(5)                 NOT NULL,  -- 회원의 우편번호
    MBR_ADDR            VARCHAR2(50)            NOT NULL, -- 기본주소
    MBR_DADDR           VARCHAR2(50)            NOT NULL, -- 상세주소
    MBR_TELNO           VARCHAR2(15)            NOT NULL UNIQUE, -- 휴대폰번호
    MBR_EML_ADDR        VARCHAR2(15)            NOT NULL UNIQUE, -- 이메일
    MBR_EML_ADDR_YN     CHAR(1)                 NOT NULL, -- 이메일 수신여부 Y,N  
    MBR_REG_DATE        DATE                    , -- 가입일
    MBR_UPDATE_DATE     DATE                    , -- 수정일
    MBR_CNTN_DATE       DATE                    -- 최근 접속시간(로그인시간)    
);

--drop table MEMBER_DETAIL_TBL;
--drop table MEMBER_TBL;

SELECT * FROM MEMBER_TBL;
SELECT * FROM MEMBER_DETAIL_TBL;

commit;

call P_MEMBER_ADD( 'test', '테스트', '$2a$10$TMUDw1sfcTNbu6tl5PodFuPkFqQI3jdM1uDFWLCBfNQk.NH1hx1we', 
'12627', '경기 여주시 세종로 40', '이젠빌딩', '010-1234-1234', 'coco0026@naver.com', 'N','OUT','OUT');

--회원 상세 테이블
CREATE TABLE MEMBER_DETAIL_TBL (
    MBR_ID              VARCHAR2(15)            PRIMARY KEY, --회원아이디
    MBR_POINT_NY        number                  DEFAULT 0 NOT NULL, -- 적립금
    MBR_GRADE_CODE      VARCHAR2(15)            DEFAULT 'A01' NOT NULL, -- A01 : 일반회원3% , A02 : 실버5% , A03 : 골드7% , A04 다이아10%
    MBR_ACCUMULATE_MY   number                  DEFAULT 0 NOT NULL -- 회원 주문 누적 금액  할인율 적용은 컬럼을 생성해서 관리자가 등급별 할인율을 변경가능하게 할지, 그냥 자바단에서 처리할지 고민중
);

INSERT INTO MEMBER_DETAIL_TBL(MBR_ID)
VALUES('test');

SELECT GDS_CODE, CATE_CODE, CATE_CODE_CHILD, GDS_NM, GDS_CN, GDS_IMG, GDS_IMG_FOLDER, GDS_PRICE, 
GDS_DSCNT, GDS_CNT, GDS_PRCHS_YN, GDS_SALE_CNT, GDS_REG_DATE, GDS_UPDATE_DATE FROM GOODS_TBL 
WHERE GDS_CODE = 124;


--공통 코드 테이블
CREATE TABLE COMMON_CODE_TBL (
    COMMON_CODE           VARCHAR2(15)            PRIMARY KEY, -- 그룹코드
    COMMON_CODE_NM        VARCHAR2(50)            NOT NULL, -- 코 드 명
    COMMON_CODE_USE_YN    CHAR(1)                 NOT NULL --코드 사용 여부
);

--공통 코드 테이블
CREATE TABLE COMMON_CODE_DETAIL_TBL (
    COMMON_CODE_CHILD     VARCHAR2(15)            PRIMARY KEY, -- 자식코드
    COMMON_CODE           VARCHAR2(15)            , -- 그룹코드
    COMMON_CODE_CHILD_NM  VARCHAR2(50)            NOT NULL, -- 코 드 명
    COMMON_CODE_CHILD_USE_YN   CHAR(1)            NOT NULL --코드 사용 여부
);

select * from COMMON_CODE_TBL;
select * from COMMON_CODE_DETAIL_TBL;

-- drop table COMMON_CODE_TBL;
-- drop table COMMON_CODE_DETAIL_TBL;

SELECT COMMON_CODE,
			   COMMON_CODE_NM
		FROM COMMON_CODE_TBL
        WHERE SUBSTR(COMMON_CODE, 1, 1) = 'C';
        
SELECT * FROM COMMON_CODE_DETAIL_TBL;

SELECT COMMON_CODE,
			   COMMON_CODE_CHILD_NM,
			   COMMON_CODE_CHILD
		FROM COMMON_CODE_DETAIL_TBL		
		WHERE COMMON_CODE = 'C000';
        

/*
회원 등급
그룹코드 : A00
A01:일반회원3% , A02:실버5% , A03:골드7% , A04:다이아10%

배송 프로세스
그룹코드 : B00
B01:배송준비 B02:배송중 B03:배송완료 B04:보류 B05:배송대기

결제상태 프로세스 :  B10
입금전 : B11  추가입금대기 : B12  입금완료(수동) : B13 입금완료(자동) : B14   결제완료 : B15

CS상태 프로세스 : B20
취소 : B21 교환 : B22 반품 B23 환분 B24

- 주문상태 컬럼 : 상품준비중 / 배송준비중 / 배송보류 / 배송대기 /배송중 / 배송완료
  - 결제상태 컬럼 : 입금전 / 추가입금대기 / 입금완료(수동) / 입금완료(자동) / 결제완료
  - CS상태 : 취소 / 교환 / 반품 / 환불

결제방법 코드




상품코드
상의 : C000
C001:반팔티, C002:긴팔티, C003:셔츠, C004:자켓, C005:코트, C006:패팅

하의 : C100
C101:반바지, C102:청바지 C103:면바지, C104:트레이닝바지

...




*/



INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('C000','TOP','Y');
INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('C100','PANTS','Y');
INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('C200','OUTER','Y');


INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C001','C000','반팔티','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C002','C000','긴팔티','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C003','C000','셔츠','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C004','C000','후드티&#38;맨투맨','Y');

INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C101','C100','반바지','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C102','C100','청바지','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C103','C100','면바지','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C104','C100','트레이닝바지','Y');

INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C201','C200','코트','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C202','C200','패딩','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('C203','C200','자켓','Y');



commit;


select * from COMMON_CODE_TBL;
select * from COMMON_CODE_DETAIL_TBL;
INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('A00','회원등급','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('A01','A00','일반회원','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('A02','A00','실버','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('A03','A00','골드','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('A04','A00','다이아','Y');

INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('B00','배송프로세스','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B01','B00','배송준비','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B02','B00','배송중','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B03','B00','배송완료','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B04','B00','배송보류','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B05','B00','배송대기','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B06','B00','취소','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B07','B00','교환','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B08','B00','반품','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B09','B00','환불','Y');


delete from COMMON_CODE_DETAIL_TBL where COMMON_CODE_CHILD = 'B05'; 
select * from COMMON_CODE_DETAIL_TBL  where COMMON_CODE = 'B00';

INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('B10','결제프로세스','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B11','B10','입금전','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B12','B10','추가입금대기','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B13','B10','입금완료(수동)','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B14','B10','결제완료(자동)','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B15','B10','결제완료','Y');
--입금전 : B11  추가입금대기 : B12  입금완료(수동) : B13 입금완료(자동) : B14   결제완료 : B15


INSERT INTO COMMON_CODE_TBL(COMMON_CODE,COMMON_CODE_NM,COMMON_CODE_USE_YN)VALUES('B20','CS상태 프로세스','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B21','B20','취소','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B22','B20','교환','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B23','B20','반품','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B24','B20','환불','Y');
--CS상태 프로세스 : B20
--취소 : B21 교환 : B22 반품 B23 환분 B24


select * from COMMON_CODE_DETAIL_TBL where common_code = '2000';
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_NM)
VALUES(2005,2000,'변경');

select A.COMMON_CODE, A.COMMON_CODE_NM, B.COMMON_CODE_CHILD, B.COMMON_CODE_NM as  COMMON_CODE_CHILD_NM
FROM COMMON_CODE_TBL A, COMMON_CODE_DETAIL_TBL B
WHERE a.common_code = B.common_code and
       a.COMMON_CODE = '1000';
      




--카테고리 코드 테이블
--CREATE TABLE CATE_CODE_TBL (
--    CATE_CODE           NUMBER                  PRIMARY KEY, -- 코드1
--    CATE_CODE_DTL       NUMBER                  , --코드 2
--    CATE_CODE_NM        VARCHAR2(50)            NOT NULL -- 코 드 명
--);


drop table GOODS_TBL;
--상품 테이블
CREATE TABLE GOODS_TBL (
    GDS_CODE            NUMBER                  CONSTRAINT PK_GDS_CODE PRIMARY KEY, --상품번호
    CATE_CODE           VARCHAR2(15)            NOT NULL, -- 카테고리 코드1
    CATE_CODE_CHILD       VARCHAR2(15)            NOT NULL, -- 카테고리 코드 2
    GDS_NM              VARCHAR2(50)            NOT NULL, --상품명
    GDS_CN              VARCHAR2(3000)          NOT NULL, -- 상품소개
    GDS_IMG             VARCHAR2(50)            NOT NULL, -- 상품이미지명
    GDS_IMG_FOLDER      VARCHAR2(200)            NOT NULL, -- 날짜폴더명
    GDS_PRICE           NUMBER                  NOT NULL, --가격
    GDS_DSCNT           NUMBER                  NOT NULL, --할인율
    GDS_CNT             NUMBER                  NOT NULL, --상품수
    GDS_PRCHS_YN        CHAR(1)                 NOT NULL, --구매가능 여부
    GDS_SALE_CNT        NUMBER                  DEFAULT 0 NOT NULL, --판매수량
    GDS_REG_DATE        DATE                    DEFAULT SYSDATE NOT NULL, -- 등록날짜
    GDS_UPDATE_DATE     DATE                    DEFAULT SYSDATE NOT NULL -- 수정일
);

select * from GOODS_TBL;

SELECT A.CART_CODE, A.MBR_ID, A.CART_PRCHS_CNT, B.GDS_NM, B.GDS_PRICE, B.GDS_DSCNT, B.GDS_SALE_CNT, 
B.GDS_IMG, B.GDS_IMG_FOLDER FROM CART_TBL A, GOODS_TBL B WHERE A.GDS_CODE = B.GDS_CODE AND 
A.MBR_ID = 'test' ;

commit;

--시퀀스
CREATE SEQUENCE SEQ_GOODS_GDS_CODE;


INSERT INTO GOODS_TBL(
    GDS_CODE,           
    CATE_CODE,           
    CATE_CODE_PRT,      
    GDS_NM,              
    GDS_CN,              
    GDS_IMG,           
    GDS_IMG_FOLDER,     
    GDS_PRICE,          
    GDS_DSCNT,           
    GDS_CNT,           
    GDS_PRCHS_YN  
)VALUES(

);


--상품 재고 테이블
--CREATE TABLE GOODS_STOCK_TBL (
--    GDS_CODE            NUMBER                  PRIMARY KEY, --상품번호
--    GDS_PRICE           NUMBER                  NOT NULL, --가격
--    GDS_DSCNT           MEMBER                  NOT NULL, --할인율
--    GDS_CNT             NUMBER                  NOT NULL, --상품수
--    GDS_PRCHS_YN        char(1)                 NOT NULL, --구매가능 여부
--    GDS_SALE_CNT        NUMBER                  DEFAULT 0 NOT NULL --판매수량
--);

--장바구니 테이블
CREATE TABLE CART_TBL (
    CART_CODE             NUMBER                  PRIMARY KEY, --장바구니 상품 코드
    GDS_CODE            NUMBER                  NOT NULL, -- 상품번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원ID
    CART_PRCHS_CNT        NUMBER                  NOT NULL --구매수량
);
select *  from CART_TBL;

CREATE SEQUENCE SEQ_CART_CODE;


SELECT A.CART_CODE, 
       A.MBR_ID,
       A.CART_PRCHS_CNT
       B.GDS_NM
       B.GDS_PRICE
       B.GDS_DSCNT
       B.GDS_SALE_CNT
       B.GDS_IMG
       B.GDS_IMG_FOLDER
FROM CART_TBL A, GOODS_TBL B
WHERE A.GDS_CODE = B.GDS_CODE AND
      A.MBR_ID = '11';


--insert into MEMBER_TBL
--select 'test', 'test', MBR_PW, MBR_ZIP, MBR_ADDR, MBR_DADDR, '123-6545-1212', 'cccc@nate.com', MBR_EML_ADDR_YN, sysdate, sysdate, sysdate 
--from MEMBER_TBL;

--insert into MEMBER_DETAIL_TBL
--select 'test', MBR_POINT_NY, MBR_GRADE_CODE, MBR_ACCUMULATE_MY
--from MEMBER_DETAIL_TBL;

commit;


MERGE INTO CART_TBL
USING DUAL
ON (MBR_ID = 'test' AND GDS_CODE = '124')
WHEN MATCHED THEN
    UPDATE SET CART_PRCHS_CNT = CART_PRCHS_CNT +
WHEN NOT MATCHED THEN
    INSERT(  CART_CODE, 
             GDS_CODE, 
             MBR_ID, 
             CART_PRCHS_CNT
    )VALUES(
            SEQ_CART_CODE.NEXTVAL,
			#{gds_code},
			#{mbr_id},
			#{cart_prchs_cnt}
    )


--주문 정보 테이블
CREATE TABLE ORDER_TBL (
    ORDER_CODE          NUMBER                  CONSTRAINT PK_ORDER_CODE PRIMARY KEY, --주문번호
    MBR_ID              VARCHAR2(30)            NOT NULL,    
    ORDER_MBR_NM        VARCHAR2(30)            NOT NULL, --회원이름
    ORDER_MBR_ZIP       CHAR(5)                 NOT NULL,  -- 회원의 우편번호
    ORDER_MBR_ADDR      VARCHAR2(50)            NOT NULL, -- 기본주소
    ORDER_MBR_DADDR     VARCHAR2(50)            NOT NULL, -- 상세주소
    ORDER_MBR_TELNO     VARCHAR2(15)            NOT NULL, -- 전화번호
    ORDER_TOT_AMT       NUMBER                  NOT NULL, --주문가격
    ORDER_DATE          DATE                    DEFAULT SYSDATE NOT NULL, --주문날짜
    ORDER_PROCESS       VARCHAR2(15)            DEFAULT 'B01' NOT NULL,--주문상태 프로세스
    PAYMENT_PROCESS     VARCHAR2(15)            NOT NULL,--결제상태 프로세스
    CS_PROCESS          VARCHAR2(15)            NULL--CS상태 프로세스
);

--drop table ORDER_TBL;
--drop SEQUENCE SEQ_ORDER_CODE;
create SEQUENCE SEQ_ORDER_CODE;

--주문 상세 테이블 (ORDER_TBL : ORDER_DETAIL_TBL  1:N)
CREATE TABLE ORDER_DETAIL_TBL (
    ORDER_CODE          NUMBER                 NOT NULL,  --주문번호
    GDS_CODE            NUMBER                 NOT NULL, --상품번호
    ORDER_DTL_CNT       VARCHAR2(15)           NOT NULL, --주문수량
    ORDER_DTL_AMT       NUMBER                 NOT NULL --주문가격
);
select * from ORDER_TBL;
select * from ORDER_DETAIL_TBL;
select * from PAYMENT_TBL;
select * from CART_TBL;
--drop table ORDER_DETAIL_TBL;
--drop table ORDER_TBL;
--drop SEQUENCE SEQ_ORDER_CODE;
create SEQUENCE SEQ_ORDER_CODE;
 commit;


--결제 테이블
CREATE TABLE PAYMENT_TBL(
    PAY_CODE                NUMBER          CONSTRAINT PK_PAYMENT_CODE PRIMARY KEY, --결제 코드
    ORDER_CODE              NUMBER          NOT NULL,--주문번호
    PAY_METHOD              VARCHAR2(20)    NOT NULL,--결제수단 무통장/신용카드/페이코/휴대폰/카카오페이 등
    PAY_DATE                DATE            NOT NULL,--결제(입금)일자
    PAY_TOT_PRICE           NUMBER          NOT NULL,--총 결제금액
    PAY_REST_PRICE          NUMBER          NULL,--추가입금액
    PAY_NOBANK_PRICE        NUMBER          NULL,--입금액
    PAY_NOBANK_USER_NM      VARCHAR2(20)    NULL,--입금자명
    PAY_NOBANK              VARCHAR2(20)    NULL--입금은행
);
CREATE SEQUENCE SEQ_PAY_CODE;
select * from PAYMENT_TBL;

--CREATE TABLE ORDER_PROCESS_TBL (
--    ORDER_CODE          NUMBER                  PRIMARY KEY, --주문번호
--    GDS_CODE            NUMBER                  NOT NULL, --상품번호
--    ORDR_PROC_CODE      NUMBER                  NOT NULL --코드 번호 정한 후 디폴트 배송전코드로 설정
--);

--주문 프로세스 코드 테이블 배송전-배송중-배송완료
--CREATE TABLE ORDR_CODE_TBL (
--    ORDR_CODE           NUMBER                  PRIMARY KEY, -- 코드1
--    ORDR_CODE_DTL       NUMBER                  , --코드 2
--    ORDR_CODE_NM        VARCHAR2(50)            NOT NULL -- 코 드 명
--);

--주문 내역&문의 게시판 테이블
CREATE TABLE ORDER_BOARD_TBL (
    ORDER_BRD_NO        NUMBER                  CONSTRAINT PK_ORDER_BRD_NO PRIMARY KEY, --게시글 번호
    ORDER_CODE          NUMBER                  NOT NULL, --주문번호
    GDS_CODE            NUMBER                  NOT NULL, --상품번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원 ID
    ORDER_BRD_TTL       VARCHAR2(100)           NOT NULL, --게시글 제목  
    ORDER_BRD_CN        VARCHAR2(4000)          NOT NULL, --게시글 내용
    ORDER_BRD_REG_DATE  DATE                    DEFAULT SYSDATE NOT NULL, -- 게시글등록일
    ORDER_BRD_UPDATE_DATE DATE                  DEFAULT SYSDATE NOT NULL -- 게시글수정일
);

--상품 문의 게시판 테이블
CREATE TABLE GOODS_BOARD_TBL (
    GOODS_BRD_NO        NUMBER                  CONSTRAINT PK_GOODS_BRD_NO PRIMARY KEY, --게시글 번호
    GDS_CODE            NUMBER                  NOT NULL, --상품번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원 ID
    GOODS_BRD_TTL       VARCHAR2(100)           NOT NULL, --게시글 제목  
    GOODS_BRD_CN        VARCHAR2(4000)          NOT NULL, --게시글 내용
    GOODS_BRD_REG_DATE  DATE                    DEFAULT SYSDATE NOT NULL, -- 게시글등록일
    GOODS_BRD_UPDATE_DATE DATE                  DEFAULT SYSDATE NOT NULL -- 게시글수정일
);
--변경&취소 게시판

--배송문의 게시판


--리뷰 테이블
CREATE TABLE REVIEW_TBL (
    REVIEW_NO            NUMBER                  CONSTRAINT PK_REVIEW_NO PRIMARY KEY, --리뷰 번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원 ID
    GDS_CODE            NUMBER                  NOT NULL, --상품 번호
    REVIEW_CN            VARCHAR2(200)           NOT NULL, --리뷰글 내용
    REVIEW_SCORE         NUMBER                  NOT NULL,--평점
    REVIEW_REG_DATE      DATE                    DEFAULT SYSDATE NOT NULL, -- 글 등록일
    REVIEW_UPDATE_DATE   DATE                    DEFAULT SYSDATE NOT NULL -- 글 수정일
);

INSERT INTO REVIEW_TBL( REVIEW_NO, MBR_ID, GDS_CODE, REVIEW_SCORE, REVIEW_CN )VALUES( SEQ_REVIEW_NUM.NEXTVAL, 
'test', 124, 5, '123' );


select * from REVIEW_TBL;

create SEQUENCE SEQ_REVIEW_NUM;


drop table REVIEW_TBL;


--관리자 테이블
CREATE TABLE MANAGER_TBL (
    MNGR_ID             VARCHAR2(15)            PRIMARY KEY, --관리자 아이디
    MNGR_PW             VARCHAR2(60)            NOT NULL, --관리자 패스워드
    MNGR_NM             VARCHAR2(30)            NOT NULL, --관리자
    MNGR_CNTN_DATE      DATE                    NOT NULL -- 최근 접속시간
);
--ORDER_CODE, MBR_ID, ORDER_MBR_NM, ORDER_MBR_ZIP, ORDER_MBR_ADDR, ORDER_MBR_DADDR, 
--ORDER_MBR_TELNO, ORDER_TOT_AMT, ORDER_DATE, ORDER_PROCESS, PAYMENT_PROCESS, CS_PROCESS
--주문테이블 기록
CREATE TABLE ORDER_HISTORY_TBL(
    ORDER_CODE          NUMBER                  PRIMARY KEY,       --주문번호                     
    MBR_ID              VARCHAR2(50)            NOT NULL REFERENCES MEMBER_TBL(MBR_ID), --주문자아이디
    ORDER_MBR_NM        VARCHAR2(30)            NOT NULL, --수령인
    ORDER_MBR_ZIP       CHAR(5)                 NOT NULL, --수령인 우편번호
    ORDER_MBR_ADDR      VARCHAR2(50)            NOT NULL, --수령인 기본주소
    ORDER_MBR_DADDR     VARCHAR2(50)            NOT NULL, --수령인 상세주소
    ORDER_MBR_TELNO     VARCHAR2(15)            NOT NULL, --수령인 연락처
    ORDER_TOT_AMT       NUMBER                  NOT NULL, --주문 총 금액
    ORDER_DATE          DATE DEFAULT SYSDATE    NOT NULL, --주문날짜
    ORDER_PROCESS       VARCHAR2(50)            , --주문상태
    ORDER_EVENT_DATE    DATE DEFAULT SYSDATE    NOT NULL, --변경사항 등록일
    EVENT_NAME          VARCHAR2(50)            not null -- 종류 : 주문상품삭제/주문취소
);
select * from ORDER_HISTORY_TBL;
-- 주문상세 기록
CREATE TABLE ORDER_DETAIL_HISTORY_TBL(
    ORDER_CODE          NUMBER              NOT NULL, --주문번호
    GDS_CODE             NUMBER              NOT NULL, --상품번호
    ORDER_DTL_CNT          NUMBER              NOT NULL, --상품수
    ORDER_DTL_AMT           NUMBER              NOT NULL, --가격
    CONSTRAINTS ORDER_DETAIL_HISTORY_PK PRIMARY KEY(ORDER_CODE, GDS_CODE)
);
select * from ORDER_DETAIL_HISTORY_TBL;

--주문테이블에서 삭제(전체주문 취소) 
--ORDER_TBL에서 DELETE 작업이 실행되고, 테이블에 반영이 된 이후 호출되는 트리거
--임시테이블 : OLD - >삭제된 데이터 행이 저장
CREATE OR REPLACE TRIGGER TRG_ORDER_HISTORY
    AFTER DELETE 
    ON ORDER_TBL
    FOR EACH ROW
DECLARE
    v_EVENT_NAME VARCHAR2(50) := '주문취소';

BEGIN
    INSERT INTO ORDER_HISTORY_TBL(
    ORDER_CODE, 
    MBR_ID, 
    ORDER_MBR_NM, 
    ORDER_MBR_ZIP, 
    ORDER_MBR_ADDR, 
    ORDER_MBR_DADDR, 
    ORDER_MBR_TELNO, 
    ORDER_TOT_AMT,
    ORDER_DATE, 
    ORDER_PROCESS, 
    ORDER_EVENT_DATE, 
    EVENT_NAME
    )VALUES(
    :OLD.ORDER_CODE, 
    :OLD.MBR_ID, 
    :OLD.ORDER_MBR_NM, 
    :OLD.ORDER_MBR_ZIP, 
    :OLD.ORDER_MBR_ADDR, 
    :OLD.ORDER_MBR_DADDR,
    :OLD.ORDER_MBR_TELNO,
    :OLD.ORDER_TOT_AMT,
    :OLD.ORDER_DATE,
    :OLD.ORDER_PROCESS,
    SYSDATE,
    v_EVENT_NAME
    );
    
    -- 스프링에서 처리 권장
    --주문상세테이블 삭제
    --결제테이블삭제
END;


--주문상세테이블 주문상품 개별삭제
CREATE OR REPLACE TRIGGER TRG_ORDER_DETAIL_HISTORY
    AFTER DELETE
    ON ORDER_DETAIL_TBL
    FOR EACH ROW -- 테이블의 작업한 행수만큼 트리거 동작
BEGIN
    INSERT INTO ORDER_DETAIL_HISTORY_TBL(
    ORDER_CODE, 
    GDS_CODE,
    ORDER_DTL_CNT, 
    ORDER_DTL_AMT
    )VALUES(
    :OLD.ORDER_CODE, 
    :OLD.GDS_CODE,
    :OLD.ORDER_DTL_CNT, 
    :OLD.ORDER_DTL_AMT
    );
END;




INSERT INTO MANAGER_TBL(MNGR_ID,MNGR_PW,MNGR_NM,MNGR_CNTN_DATE)
VALUES('admin','$2a$10$lMX0lTdK2dAxpIR8B3KVQepSjirIkne0l79JDQfMJHUNkazSOivp.','관리자',sysdate);

commit;







create or replace PROCEDURE P_MEMBER_ADD (
    P_MBR_ID           IN MEMBER_TBL.MBR_ID%TYPE,
    P_MBR_NM           IN MEMBER_TBL.MBR_NM%TYPE,
    P_MBR_PW           IN MEMBER_TBL.MBR_PW%TYPE,
    P_MBR_ZIP          IN MEMBER_TBL.MBR_ZIP%TYPE,
    P_MBR_ADDR         IN MEMBER_TBL.MBR_ADDR%TYPE,
    P_MBR_DADDR        IN MEMBER_TBL.MBR_DADDR%TYPE,
    P_MBR_TELNO        IN MEMBER_TBL.MBR_TELNO%TYPE,
    P_MBR_EML_ADDR     IN MEMBER_TBL.MBR_EML_ADDR%TYPE,
    P_MBR_EML_ADDR_YN  IN MEMBER_TBL.MBR_EML_ADDR_YN%TYPE,
    P_ERRCODE          OUT VARCHAR2,
    P_ERRMSG           OUT VARCHAR2
    --MBR_REG_DATE        
    --MBR_UPDATE_DATE     
    --MBR_CNTN_DATE       
) IS
    -------------------------------------
    -- Ver      Date              Author
    -- 1.0      2022/07/12        이영수
    -------------------------------------

    INSERT_ERR EXCEPTION;

    V_MBR_POINT_NY       NUMBER     := 0;       -- 적립금
    V_MBR_GRADE_CODE     VARCHAR2(15)     := 'A01';    -- 일반등급
    V_MBR_ACCUMULATE_MY  NUMBER     := 0;       -- 회원 주문 누적 금액

    BEGIN


       BEGIN -- 단일트랜잭션
            DBMS_OUTPUT.PUT_LINE('============================================START============================================');
            P_ERRCODE := 'N'; -- 에러코드값 디폴트N
            P_ERRMSG := 'SUCCESS'; --   에러메시지 값 디폴트 SUCCESS


            -- 회원테이블 INSERT
            INSERT INTO MEMBER_TBL (
                MBR_ID,           
                MBR_NM,          
                MBR_PW,           
                MBR_ZIP,          
                MBR_ADDR,         
                MBR_DADDR,        
                MBR_TELNO,        
                MBR_EML_ADDR,    
                MBR_EML_ADDR_YN,
                MBR_REG_DATE,
                MBR_UPDATE_DATE
                --MBR_CNTN_DATE      
            ) VALUES (
                P_MBR_ID,           
                P_MBR_NM,          
                P_MBR_PW,           
                P_MBR_ZIP,          
                P_MBR_ADDR,         
                P_MBR_DADDR,        
                P_MBR_TELNO,        
                P_MBR_EML_ADDR,    
                P_MBR_EML_ADDR_YN,
                SYSDATE,
                SYSDATE
            );

            -- 회원등급테이블 INSERT
            INSERT INTO MEMBER_DETAIL_TBL (
                MBR_ID,              
                MBR_POINT_NY,        
                MBR_GRADE_CODE,      
                MBR_ACCUMULATE_MY   
            ) VALUES (
                P_MBR_ID,
                V_MBR_POINT_NY, -- 적립금
                V_MBR_GRADE_CODE,-- 1001 : 일반회원3% , 1002 : 실버5% , 1003 : 골드7% , 1004 다이아10%
                V_MBR_ACCUMULATE_MY -- 회원 주문 누적 금액 
            );

            COMMIT; -- 2개테이블 모두 입력이 되면 COMMIT처리함
       EXCEPTION -- 예외발생시 EXCEPTION 
        WHEN NO_DATA_FOUND THEN --SELECT 결과 없을때
            RAISE INSERT_ERR;
            P_ERRCODE := 'Y';
        WHEN OTHERS THEN
            RAISE INSERT_ERR;
            P_ERRCODE := 'Y';
       END;
    DBMS_OUTPUT.PUT_LINE('============================================END============================================');
   EXCEPTION
     WHEN INSERT_ERR THEN
       ROLLBACK;
       DBMS_OUTPUT.PUT_LINE('============================================START============================================');
      --P_ERRCODE := 'Y'; -- 에러코드값 디폴트N
      P_ERRMSG  := '회원가입정보 입력 오류 발생' || SQLCODE || SUBSTR( SQLERRM, 1, 200 ); --SQLCODE 에러코드 /SQLERRM 에러코드 내용
       RETURN;
     WHEN OTHERS THEN
       --P_ERRCODE := 'Y'; -- 에러코드값 디폴트N
      P_ERRMSG  := '그 외 오류 발생' || SQLCODE || SUBSTR( SQLERRM, 1, 200 );
       RETURN;
END P_MEMBER_ADD;

 call P_MEMBER_ADD( 'test', '테스트', '$2a$10$lMX0lTdK2dAxpIR8B3KVQepSjirIkne0l79JDQfMJHUNkazSOivp.', 
'11900', '경기 구리시 담터길32번길 111', '이젠빌딩', '010-1234-1234', 'coco0026@naver.com', 'Y', '', 
'' );
























