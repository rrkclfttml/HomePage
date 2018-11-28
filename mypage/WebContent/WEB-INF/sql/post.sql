drop table post

create table post(
	postno		number(7)		not null,
	pname		varchar(20)		not null,
	title		varchar(100)	not null,
	content		varchar(4000)	not null,
	passwd		varchar(15)		not null,
	viewcnt		number(7)		default 0,
	wdate		date			not null,
	grpno		number(7)		default 0,
	indent		number(7)		default 0,
	ansnum		number(7)		default 0,
	refnum		number			default 0,
	filename	varchar(30),
	filesize	number			default 0,
	primary key(postno)
);

select *from post
where postno=2;

--create
select nvl(max(postno),0)+1 as max from post;

insert into post(postno,pname,title,content,passwd,wdate,grpno)
values((select nvl(max(postno),0)+1 as postno from post),
'이름','제목','내용들입니다.','123',sysdate,
(select nvl(max(grpno),0)+1 as postno from post));


--list

select postno,pname,title,viewcnt,wdate,
	   prpno,indent,ansnum,r
from(
	select postno,pname,title,viewcnt,wdate,
		   grpno,indent,ansnum,rownum as r
	from(
		select postno,pname,title,viewcnt,to_char(wdate,'yyyy-mm-dd')as wdate,
		grpno,indent,ansnum
		from post
		order by postno desc
	)
)where r>=6 and r<=10


--delete
delete from post
where postno=2;

select postno,pname,title,content,viewcnt,wdate,grpno,indent,ansnum,filename,filesize
from post
where postno=4;


select *from post