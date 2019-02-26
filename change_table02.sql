drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

-- usersにemailというcolumnをnameの後に追加する. varchar(255)の型で.
alter table users add column email varchar(255) after name;

desc users;
