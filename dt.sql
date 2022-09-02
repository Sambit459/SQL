create database dt;
use dt;
create table users(
name varchar(30),
birth_date date,
birth_time time,
birth datetime);
insert  into users values("harry","1995-02-20","06:15:33","1995-02-20 06:15:33");
insert into users values("Alana",curdate(),curtime(),now());
select * from users;

insert into users values("raju",curdate(),curtime(),now());
select name,dayofweek(birth_date) from users;
select name,dayname(birth_date) from users;
select name,dayofmonth(birth_date) from users;
select name,dayofyear(birth_date) from users;
select date_format(birth,'%Y %M %D') from users;
select concat(name,' was registered  on ',date_format(birth,'%D %M %Y at %H:%i')) as details
from users;

-- --Date math --------
select * from users;
select datediff(now(),birth) as age from users;
select date_add(now(),interval 1 day);
select date_add(now(),interval 1 year);
select date_add(now(),interval 1 quarter);

select date_sub(now(),interval 1 day);

-- timestamp-- -------

create table comments(
content varchar(30),
commented_at timestamp default now());


insert into comments(content) values("this is amazing");
insert into comments(content) values("i am fine");
insert into comments(content) values("looks beautiful");
insert into comments(content) values("its natural");
insert into comments(content) values("We should follow it");

select * from comments;
select * from comments order by commented_at desc;

select current_date();
select current_timestamp();