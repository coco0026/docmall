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

INSERT INTO MEMBER_TBL(MBR_ID, MBR_NM, MBR_PW, MBR_ZIP, MBR_ADDR, MBR_DADDR, MBR_TELNO, MBR_EML_ADDR, MBR_EML_ADDR_YN)
VALUES(#{MBR_ID},#{MBR_NM},#{MBR_PW},#{MBR_ZIP},#{MBR_ADDR},#{MBR_DADDR},#{MBR_TELNO},#{MBR_EML_ADDR},#{MBR_EML_ADDR_YN});



--회원 상세 테이블
CREATE TABLE MEMBER_DETAIL_TBL (
    MBR_ID              VARCHAR2(15)            PRIMARY KEY, --회원아이디
    MBR_POINT_NY        number                  DEFAULT 0 NOT NULL, -- 적립금
    MBR_GRADE_CODE      VARCHAR2(15)            DEFAULT 'A01' NOT NULL, -- A01 : 일반회원3% , A02 : 실버5% , A03 : 골드7% , A04 다이아10%
    MBR_ACCUMULATE_MY   number                  DEFAULT 0 NOT NULL -- 회원 주문 누적 금액  할인율 적용은 컬럼을 생성해서 관리자가 등급별 할인율을 변경가능하게 할지, 그냥 자바단에서 처리할지 고민중
);

INSERT INTO MEMBER_DETAIL_TBL(MBR_ID)
VALUES('test');


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
B01:배송준비 B02:배송중 B03:배송완료 B04:주문취소 B05:변경



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
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B04','B00','주문취소','Y');
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_CHILD_NM,COMMON_CODE_CHILD_USE_YN)VALUES('B05','B00','변경','Y');

select * from COMMON_CODE_DETAIL_TBL where common_code = '2000';
INSERT INTO COMMON_CODE_DETAIL_TBL(COMMON_CODE_CHILD,COMMON_CODE,COMMON_CODE_NM)
VALUES(2005,2000,'변경');

select A.COMMON_CODE, A.COMMON_CODE_NM, B.COMMON_CODE_CHILD, B.COMMON_CODE_NM as  COMMON_CODE_CHILD_NM
FROM COMMON_CODE_TBL A, COMMON_CODE_DETAIL_TBL B
WHERE a.common_code = B.common_code and
       a.COMMON_CODE = '1000';
      




/*
회원 등급
그룹코드 : A00
A01:일반회원3% , A02:실버5% , A03:골드7% , A04:다이아10%

배송 프로세스
그룹코드 : B00
B01:배송준비 B02:배송중 B03:배송완료 B04:주문취소 B05:변경



상품코드
상의 : C000
C001:반팔티, C002:긴팔티, C003:셔츠, C004:자켓, C005:코트, C006:패팅

하의 : C100
C101:반바지, C102:청바지 C103:면바지, C104:트레이닝바지

...



*/




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

commit;

--시퀀스
CREATE SEQUENCE SEQ_GOODS_GDS_CODE;
CREATE SEQUENCE PK_GDS_CODE;


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
CREATE TABLE SHOPPING_CART_TBL (
    CART_CODE             NUMBER                  PRIMARY KEY, --장바구니 상품 코드
    GDS_CODE            NUMBER                  NOT NULL, -- 상품번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원ID
    CART_PRCHS_CNT        NUMBER                  NOT NULL --구매수량
);


CREATE SEQUENCE SEQ_CART_CODE;

--주문 정보 테이블
CREATE TABLE ORDER_TBL (
    ORDER_CODE          NUMBER                  CONSTRAINT PK_ORDER_CODE PRIMARY KEY, --주문번호
    MBR_ID              VARCHAR2(30)            NOT NULL,    
    ORDER_MBR_NM        VARCHAR2(30)            NOT NULL, --회원이름
    ORDER_MBR_ZIP       CHAR(5)                 NOT NULL,  -- 회원의 우편번호
    ORDER_MBR_ADDR      VARCHAR2(50)            NOT NULL, -- 기본주소
    ORDER_MBR_DADDR     VARCHAR2(50)            NOT NULL, -- 상세주소
    ORDER_MBR_TELNO     VARCHAR2(15)            NOT NULL, -- 전화번호
    ORDR_DATE           DATE                    DEFAULT SYSDATE NOT NULL --주문날짜
);

--주문 상세 테이블 (ORDER_TBL : ORDER_DETAIL_TBL  1:N)
CREATE TABLE ORDER_DETAIL_TBL (
    GDS_CODE            NUMBER                  PRIMARY KEY, --상품번호
    ORDER_CODE          NUMBER                  NOT NULL, --주문번호
    ORDR_DTL_CNT        VARCHAR2(15)            NOT NULL, --주문수량
    ORDR_DTL_TOT_AMT    NUMBER                  NOT NULL, --주문가격
    ORDR_DTL_TOT_AMT    NUMBER                  NOT NULL, --총금액
    ORDR_DTL_PROCESS    VARCHAR2(15)            NOT NULL, -- 주문 처리 상태
);

--주문 프로세스 테이블 배송전-배송중-배송완료 1001:배송전 1002:배송중 1003:배송완료 1004:주문취소 1005:변경
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
CREATE TABLE REPLY_TBL (
    REPLY_NO            NUMBER                  CONSTRAINT PK_REPLY_NO PRIMARY KEY, --리뷰 번호
    MBR_ID              VARCHAR2(15)            NOT NULL, --회원 ID
    GDS_CODE            NUMBER                  NOT NULL, --상품 번호
    REPLY_CN            VARCHAR2(200)           NOT NULL, --리뷰글 내용
    REPLY_GRADE         NUMBER                  NOT NULL,--평점
    REPLY_REG_DATE      DATE                    DEFAULT SYSDATE NOT NULL, -- 글 등록일
    REPLY_UPDATE_DATE   DATE                    DEFAULT SYSDATE NOT NULL -- 글 수정일
);

--관리자 테이블
CREATE TABLE MANAGER_TBL (
    MNGR_ID             VARCHAR2(15)            PRIMARY KEY, --관리자 아이디
    MNGR_PW             VARCHAR2(60)            NOT NULL, --관리자 패스워드
    MNGR_NM             VARCHAR2(30)            NOT NULL, --관리자
    MNGR_CNTN_DATE      DATE                    NOT NULL -- 최근 접속시간
);

INSERT INTO MANAGER_TBL(MNGR_ID,MNGR_PW,MNGR_NM,MNGR_CNTN_DATE)
VALUES('admin','$2a$10$lMX0lTdK2dAxpIR8B3KVQepSjirIkne0l79JDQfMJHUNkazSOivp.','관리자',sysdate);

commit;


--회원 테이블, 회원상세 테이블 생성 프로시저
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
                V_MBR_GRADE_CODE,-- A01 : 일반회원3% , A02 : 실버5% , A03 : 골드7% , A04 다이아10%
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
























