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

-- 演算は
-- +, -, *, /, %
update users set score = score * 1.2 where id % 2 = 0;
select * from users;

-- 四捨五入は
-- round
select round(5.355); -- 5
select round(5.355, 1); -- 5.4

-- 小数点以下切り捨て
select floor(6.832); -- 6

-- 小数点以下切り上げ
select ceil(6.28); -- 7

-- 乱数発生
select rand();

-- 乱数を使って並べ替える
select * from users order by rand();

-- 乱数を使って抽選を行う
select * from users order by rand() limit 1;

-- その他三角関数や対数もある
