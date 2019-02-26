drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

insert into users (name, score) values ('taguchi', 5.8);
insert into users (name, score) values ('taro', 8.8);
insert into users (name, score) values ('github', 10.1);
insert into users (name, score) values ('Tanaka', 0.2);
insert into users (name, score) values ('Yamada', null);
insert into users (name, score) values ('vim', 7.9);
select * from users;

-- scoreを全部5.9に更新する
update users set score = 5.9;
select * from users;

-- idが1のscoreを3.0に更新する
update users set score = 3.0 where id = 1;
select * from users;

-- 複数のrecordを変更するには, 区切りで書く
update users set name = 'sasaki', score = 2.0 where name = 'taro';
select * from users;

-- socreが5.0未満は削除
delete from users where score < 5.0;
select * from users;

-- table内のデータを全件削除
delete from users;
select * from users;
