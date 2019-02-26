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

-- 全てのフィールドを抽出する
select * from users;

-- idとnameのフィールドを抽出する
select id, name from users;

-- 条件付きで抽出する
-- 使える条件は
-- <, >, <=, >=, =, <>(not =), !=
-- is null(nullかどうか), is not null(nullでないかどうか)
-- and, or, not(論理演算子)
select * from users where score >= 3.0 and score <= 8.0;
-- もしくは同様のことは
select * from users where score between 3.0 and 8.0;

-- 名前で抽出する
select * from users where name = 'taguchi' or name = 'taro';
-- 同様のことをするには
select * from users where name in ('taguchi', 'taro');
