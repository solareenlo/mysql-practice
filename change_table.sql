drop table if exists users;
drop table if exists persons;

create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

-- usersにemailというcolumnを追加する. varchar(255)の型で.
alter table users add column email varchar(255);
desc users;

-- usersにemail2というcolumnをnameの後に追加する. varchar(255)の型で.
alter table users add column email2 varchar(255) after name;
desc users;

-- usersというtableのscoreというfieldを削除する場合
alter table users drop column score;
desc users;

-- nameをuser_nameに名称変更しつつ, 属性も持たせた
alter table users change name user_name varchar(80) default 'nobody';
desc users;

-- tableの名称を変更する
alter table users rename persons;
show tables;
