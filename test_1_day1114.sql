--DB정규화
--한마디로 DB서버의 메모리를 낭비하지 않기위해서 어떤 테이블을 식별자를 가지는 여러개의 테이블로
--나누는 과정을 정규화 라고 한다
--정규화된 데이타베이스는 중복이 최소화되도록 설계된 DB이다

--on Delete Cascade: 외부키로 연결이 되어있다 하더라도 부모테이블의 데이터를 삭제하면
--자식테이블의 데이타 까지도 자동삭제 시켜주는 기능


--첫번째 DB정규화
--시퀀스를 만들고 shop테이블,cart테이블을 만들어 조회해볼것임


--시퀀스
create sequence seq_shop;

--shop테이블(상품번호:기본키,상품명,색상)
create table shop(num number(5) primary key,
sangpum varchar2(30),color varchar2(20));

--shop테이블에 최소 5개만 추가
insert into shop values(seq_shop.nextval,'텀블러','핑크');
insert into shop values(seq_shop.nextval,'핸들컵','화이트');
insert into shop values(seq_shop.nextval,'키링','보라');
insert into shop values(seq_shop.nextval,'핸드크림','화이트');
insert into shop values(seq_shop.nextval,'핸드워시','핑크');
commit;


--cart1테이블(주문번호:기본키,shop의 num:외부키,갯수,구입할날짜)
--create table cart1(idx number(5) primary key,
--num number(5) CONSTRAINT cart_fk_num REFERENCES shop(num),
--cnt number(5),guipday date);


create table cart1(idx number(5) primary key,
num number(5),
cnt number(5),guipday date,
CONSTRAINT cart_fk_num  FOREIGN key(num) REFERENCES shop(num));

--cart2 shop테이블의 num을 외부키지정하고  on delete cascade(부모테이블지우면 그상품과 연결된 카트를 자동으로 지워준다)
create table cart2(idx number(5) primary key,
num number(5) CONSTRAINT cart_fk2_num REFERENCES shop(num) on DELETE CASCADE,
cnt number(5),guipday date);

--cart1에 상품추가,1번상품 담기
insert into cart1 values(seq_shop.nextval,1,2,sysdate);--1번 2개 텀블러 추가
insert into cart1 values(seq_shop.nextval,4,1,sysdate);--4번 1개 추가

--shop에 없는 상품담아보기
insert into cart1 values(seq_shop.nextval,6,1,sysdate);--무결성 제약조건(TEST.CART_FK_NUM)이 위배되었습니다- 부모 키가 없습니다


--cart2에 상품추가,3번2개,4번3개
insert into cart2 values(seq_shop.nextval,3,2,sysdate);
insert into cart2 values(seq_shop.nextval,4,3,sysdate);

--부모테이블의 1번상품 삭제
delete from shop where num=1;--무결성 제약조건(TEST.CART_FK_NUM)이 위배되었습니다- 자식 레코드가 발견되었습니다

delete from shop where num=5;

--아까워서 롤백으로 되돌리기
rollback;


--cart2에 담긴  3번은 shop에서 지워질까???
--yes:cascade설정으로 부모테이블 데이타 지우면 자식테이블의 데이타도 같이 지워진다
delete from shop where num=3;--cart2의 3번담은 상품이 사라짐

--join위해서 cart2에 데이타 더 추가해보기
insert into cart2 values(seq_shop.nextval,1,4,sysdate);
insert into cart2 values(seq_shop.nextval,5,2,sysdate);


commit;

--cart1에 담긴 상품을 shop과 join해서 자세히 출력
--주문번호    상품번호     상품명     상품색상   주문갯수   구입한날짜
select cart1.idx 주문번호,shop.num 상품번호,shop.sangpum 상품명,shop.color 상품색상,cart1.cnt 주문갯수,cart1.guipday 구입한날짜
from shop,cart1
where shop.num=cart1.num;

--cart2에 담긴 상품을 shop과 join해서 자세히 출력
--join하는 테이블에 중복되지 않은 컬럼명은 앞에 테이블명 생략가능
--주문번호    상품번호     상품명     상품색상   주문갯수   구입한날짜
select idx 주문번호,s.num 상품번호,sangpum 상품명,color 상품색상,cnt 주문갯수,guipday 구입한날짜
from shop s,cart2 c
where s.num=c.num;


--[두번째 테이블은 게시판에 원글을 작성시 댓글을 남기는 경우를 예상해서 작성]

--시퀀스(seq_board):원글,댓글 모두 사용
create sequence seq_board;

--원글: board(기본키,작성자,제목,원글작성날짜)
create table board(bno number(3) CONSTRAINT board_pk_bno primary key,
writer varchar2(30),
subject varchar2(100),
writeday date);


--board에 5개이상 데이타 insert,commit
insert into board values(seq_board.nextval,'마징가','오늘 금요일 모임',sysdate);
insert into board values(seq_board.nextval,'오늘도 난','스터디 카페 강남위치',sysdate);
insert into board values(seq_board.nextval,'코딩맨','이번주도 프로젝트중',sysdate);
insert into board values(seq_board.nextval,'늘 피곤해','주말 콘도 있어요',sysdate);
insert into board values(seq_board.nextval,'사랑해요','우리 복돌이 돌봐주실분~~~',sysdate);

--시퀀스 변경
insert into board values(seq_shop.nextval,'선릉옆앞 모임','오늘 드레스 코드는~~~',sysdate);

commit;



--댓글 테이블  answer  _ bno를 외부키로 설정
--부모글을 지우면 그글에 달린 댓글도 자동으로 삭제할수 있다
--answer(기본키,외부키,닉네임,댓글내용,댓글단 날짜)
create table answer(ano number(5) CONSTRAINT answer_pk_ano primary key,
bno number(3) CONSTRAINT answer_fk_bno REFERENCES board(bno) on DELETE CASCADE,
nickname varchar2(30),content varchar2(200),writeday date);

--원하는 원글에 댓글을 최소5개 넣어보기

insert into answer values(seq_board.nextval,2,'영자언니','강남역 12번 출구 바로있어요',sysdate);
insert into answer values(seq_board.nextval,2,'철수','강남역에 널렸어요',sysdate);
insert into answer values(seq_board.nextval,2,'영희','예약 힘들던데~~~',sysdate);
insert into answer values(seq_board.nextval,5,'러브복돌','복돌이이름이 갔네요 제가 봐줄게요',sysdate);
insert into answer values(seq_board.nextval,2,'철수','제가 잘봅니다',sysdate);

--변경한 시퀀스 seq_shop 글에 댓글 2개만 달아봅시다
insert into answer values(seq_board.nextval,14,'철수','오늘 못갈듯요 ㅜㅜ',sysdate);
insert into answer values(seq_board.nextval,14,'영희','오늘을 위해 옷 샀어요 ㅎ',sysdate);


--join으로 출력
--글번호(원글) 작성자  작성내용   댓글단사람   댓글내용    원글작성날짜   댓글작성날짜
select b.bno 글번호,writer 작성자,subject 작성내용,nickname 댓글단사람,content 댓글내용,b.writeday 원글작성날짜,a.writeday 댓글작성날짜
from board b,answer a
where b.bno=a.bno;

--나중에 단 원글 삭제 가능(댓글도 삭제 되는거 확인하세요~~~)
delete from board where bno=14;

drop table board; -- 외래키에 의해 참조되는 고유/기본키가 테이블에 이습니다
 -- 자식테이블을 먼저지우자
drop table answer; --성공
drop table board; -- 외부키로 연결된 경우 자식테이블 먼저 지우고 부모테이블 삭제해야 성공


select * from board;
select * from answer;

rollback;

COMMIT;


--[조인, 외부키 문제]
--시퀀스: seq_4 이용해서 기본키에 활용하세요
--테이블: foodshop
--기본키(fno:seq_4),foodname(문자열),foodprice(숫자),shopname(가게이름문자열),shoploc(위차문자열)
--최소 데이터 10개 insert
create SEQUENCE seq_4;
create table foodshop(fno number primary key, foodname varchar2(50), foodprice number, shopname varchar2(50), shaploc varchar2(100));

INSERT INTO foodshop VALUES(seq_4.nextval, '알리오올리오', 18000, '쏘렌토', '강남구 역삼동');
INSERT INTO foodshop VALUES(seq_4.nextval, '까르보나라', 17000, '쏘렌토', '강남구 역삼동');
INSERT INTO foodshop VALUES(seq_4.nextval, '마르게리따 피자', 22000, '피자키친', '서초구 서초동');
INSERT INTO foodshop VALUES(seq_4.nextval, '고르곤졸라 피자', 21000, '피자키친', '서초구 서초동');
INSERT INTO foodshop VALUES(seq_4.nextval, '돈카츠정식', 13000, '카츠모토', '강남구 논현동');
INSERT INTO foodshop VALUES(seq_4.nextval, '치킨마요', 8000, '한솥도시락', '강남구 대치동');
INSERT INTO foodshop VALUES(seq_4.nextval, '참치김밥', 4500, '김밥천국', '잠실본동');
INSERT INTO foodshop VALUES(seq_4.nextval, '불고기덮밥', 11000, '봉추찜닭', '강남구 삼성동');
INSERT INTO foodshop VALUES(seq_4.nextval, '짬뽕', 9000, '홍콩반점', '강남구 도곡동');
INSERT INTO foodshop VALUES(seq_4.nextval, '짜장면', 8000, '홍콩반점', '강남구 도곡동');

select * from foodshop;
select * from orderapp;

--테이블:orderapp (부모데이터 삭제시 자동삭제되도록 만들것!)_
--기본키(onum:seq_4),clientname(주문자문자열),음식번호(fno)-외부키,clientaddr(주문자주소:문자열)
--최소 데이터 10개 넣는데 가게 주소랑 주문자 주소가 너무 어긋나지 않도록 insert

CREATE TABLE orderapp(
    onum       NUMBER PRIMARY KEY,
    clientname VARCHAR2(50),
    fno        NUMBER(3) REFERENCES foodshop(fno) ON DELETE CASCADE,
    clientaddr VARCHAR2(100));
--CONSTRAINT orderapp_fk_fno	제약조건 이름 (원하면 생략 가능하지만, 명시하면 관리가 쉬움)
--FOREIGN KEY(fno)	외래키 지정 — 이 컬럼은 다른 테이블의 키를 참조함
--REFERENCES foodshop(fno)	foodshop 테이블의 fno 컬럼을 참조
--ON DELETE CASCADE	부모 테이블(foodshop)의 데이터가 삭제되면, 자식 테이블(orderapp)의 관련 행도 자동 삭제됨

INSERT INTO orderapp VALUES(seq_4.nextval, '손흥민', 1, '강남구 역삼동 쌍용교육센터 7층');
INSERT INTO orderapp VALUES(seq_4.nextval, '김민재', 2, '강남구 역삼동 현대오피스텔');
INSERT INTO orderapp VALUES(seq_4.nextval, '황희찬', 3, '서초구 서초동 센트럴빌딩');
INSERT INTO orderapp VALUES(seq_4.nextval, '이강인', 4, '서초구 서초동 아크로리버파크');
INSERT INTO orderapp VALUES(seq_4.nextval, '정우영', 5, '강남구 논현동 푸르지오');
INSERT INTO orderapp VALUES(seq_4.nextval, '조규성', 6, '강남구 대치동 은마아파트');
INSERT INTO orderapp VALUES(seq_4.nextval, '박지성', 7, '잠실본동 리센츠아파트');
INSERT INTO orderapp VALUES(seq_4.nextval, '차범근', 8, '강남구 삼성동 아이파크');
INSERT INTO orderapp VALUES(seq_4.nextval, '김연아', 9, '강남구 도곡동 타워팰리스');
INSERT INTO orderapp VALUES(seq_4.nextval, '아이유', 10, '강남구 도곡동 LH오피스텔');


--최종출력 .. 주문자 이름에 오른차순으로 출력 
SELECT 
    o.onum AS 주문번호,
    o.clientname AS 주문자이름,
    f.foodname AS 음식명,
    f.foodprice AS 음식가격,
    f.shopname AS 상호명,
    f.shaploc AS 가게위치,
    o.clientaddr AS 주문자주소
FROM orderapp o
JOIN foodshop f
    ON o.fno = f.fno
ORDER BY o.clientname ASC;



--순서
--주문번호 주문자이름   음식명      음식가격    상호명     가게위치      주문자 주소
--시퀀스번호 손흥민   알리오올리오 18000  쏘렌토 강남구역삼동 역상2동 쌍용교육센터 7충