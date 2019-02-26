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

-- 文字列の長さを抽出する
select length('Hello'); -- 5

-- 文字列の途中以降を抽出する
select substr('Hello', 2); -- ello

-- 文字列の２文字目から３文字を抽出する
select substr('Hello', 2, 3); -- ell

-- 文字列を全て大文字にする
select upper('Hello'); -- HELLO

-- 文字列を全て小文字にする
select lower('Hello'); -- hello

-- 文字列を結合する
select concat('Hello', 'world'); -- Helloworld

-- nameの文字数順で昇順に並べ替える
select length(name), name from users order by length(name);

-- nameの文字数順で降順に並べ替える
select length(name), name from users order by length(name) desc;

-- asを使って, 上記のlength(name)をlenと表記させる
select length(name) as len, name from users order by len desc;
