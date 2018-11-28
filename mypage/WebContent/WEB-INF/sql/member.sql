create table mymember(
	id			varchar(30)		not null,
	passwd		varchar(30)		not null,
	mname 		varchar(40)		not null,
	tel			varchar(20)		null,
	email		varchar(50)		not null UNIQUE,
	address1	varchar(150)	null,
	address2	varchar(50)		null,
	mdate		date			not null,
	grade		char(1)			default 'H',
	primary key(id)
);

alter table mymember
add(fname  VARCHAR(50)	 DEFAULT 'member.jpg')

--회원보기
select *from MYMEMBER;


delete from MYMEMBER;


--회원 추가
insert into mymember(id,passwd,mname,tel,email,address1,address2,mdate,grade)
values('user1','1234','신혜인','01062865810','email1@email.com',
		'서울특별시 강북구 인수동','극동아파트 1105동 1508호',
		sysdate,'H');
		

insert into mymember(id,passwd,mname,tel,email,address1,address2,mdate,grade)
values('admin','321','최지원','01099993333','jwchoi0506@email.com',
		'경기도 파주시 동패동',' 207동 206호',
		sysdate,'A');
		
--id중복검사(1 : 중복)
select count(id) from mymember
where id='user1';

--email중복검사
select count(email) from mymember
where email='email2@email.com';
