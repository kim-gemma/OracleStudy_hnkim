create table MyCarrot (cnum number(5) primary key, csangpum VARCHAR2(30), cprice number(5),cscore number(5), caddr VARCHAR2(100)); 

INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '아이폰13 미개봉', 550, 98, '서울시 강남구 역삼동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '다이슨 청소기 V11', 320, 95, '서울시 송파구 잠실동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '캠핑 의자 2개 세트', 45, 87, '경기도 성남시 분당구 정자동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '닌텐도 스위치 OLED', 380, 92, '서울시 마포구 합정동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '전자레인지 삼성', 60, 90, '서울시 구로구 구로동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '책상 + 의자 세트', 80, 85, '서울시 관악구 봉천동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '에어팟 프로2', 190, 96, '경기도 수원시 영통구');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '게이밍 키보드 기계식', 55, 88, '서울시 동작구 사당동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '원목 선반', 35, 93, '경기도 고양시 일산동구');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '스탠드 조명', 25, 89, '서울시 노원구 중계동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '그릇세트 10p', 15, 90, '서울시 강서구 화곡동');
INSERT INTO MyCarrot VALUES(seq_4.NEXTVAL, '중형 반려견 하네스', 20, 91, '서울시 은평구 불광동');


select * from mycarrot;
commit;

