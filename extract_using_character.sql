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

-- taguchiさんを抽出する
select * from users where name = 'taguchi';

-- tから始まる任意の文字列を抽出する
-- %は0文字以上の任意の文字列を表すワイルドカード
select * from users where name like 't%';

-- aを含む任意の文字列を抽出する
select * from users where name like '%a%';

-- aで終わる任意の文字列を抽出する
select * from users where name like '%a';

-- 大文字のTから始まる任意の文字列を抽出する
select * from users where name like binary 'T%';

-- ６文字の任意の文字列を抽出する
select * from users where name like '______';

-- ２文字目がaの任意の文字列を抽出する
select * from users where name like '_a%';
