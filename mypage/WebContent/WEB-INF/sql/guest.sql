create table guest(
	gno  number(6)			not null,
	title	varchar(100)	not null,
	content varchar(4000)	not null,
	wdate	date			not null,
	viewcnt	number(5)		default 0,
	grpno	number			default 0,
	indent	number			default 0,
	ansnum	number			default 0,
	primary key(gno)
);

select *from guest

