drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

desc users;

-- tableの名称を変更する
alter table users rename persons;
show tables;
