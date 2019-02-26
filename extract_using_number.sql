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

-- scoreの小さい順に並び替える
select * from users order by score;

-- scoreの大きい順に並び替える
select * from users order by score desc;

-- scoreのnullを省いてsocreの大きい順に並び替える
select * from users where score is not null order by score desc;

-- 最初の３件だけを抽出する
select * from users limit 3;

-- 最初の３件を除外してから次の３件を抽出する
select * from users limit 3 offset 3;

-- scoreの上位３名だけ抽出する
select * from users order by score desc limit 3;
