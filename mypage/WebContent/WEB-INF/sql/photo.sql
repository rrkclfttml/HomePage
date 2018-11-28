create table photo(

	photono		number			not null,
	title		varchar(90)		not null,
	name		varchar(90)		not null,
	photo		varchar(30)		not null,
	grpno		number			default 0,
	indent		number			default 0,
	ansnum		number			default 0,
	passwd		varchar(30)		default 0,
	viewcnt		number			default 0,
	mdate		date			not null,

primary key(photono)
)

