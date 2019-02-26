drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

-- usersというtableのscoreというfieldを削除する場合
alter table users drop column score;

desc users;
