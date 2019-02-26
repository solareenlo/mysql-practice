drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

-- nameをuser_nameに名称変更しつつ, 属性も持たせた
alter table users change name user_name varchar(80) default 'nobody';

desc users;
