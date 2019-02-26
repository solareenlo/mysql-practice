drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float,
  rank enum('gold', 'silver', 'bronze')
);

insert into users (name, score, rank) values ('taguchi', 5.8, 'silver');
insert into users (name, score, rank) values ('taro', 10.1, 'gold');
insert into users (name, score, rank) values ('test', 9.9, 'red'); -- rankがredなので弾かれてtableに保存されない.
insert into users (name, score, rank) values ('Tak', 1.1, 'silver');

select * from users;

-- silverの行(record)だけ抽出する
select * from users where rank = 'silver';

-- enum型の中身には数値も割当らてる.
-- １番目が１, ２番目が２, ３番目が３...というふうに.
-- なので, 上の抽出は以下のようにしてもかける.
select * from users where rank = 2;
-- この数値は挿入時や更新時にも使える.

-- enumを使うと有効なデータ以外は無効なデータとして扱うことができる.
