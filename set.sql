drop table if exists users;
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float,
  coins set('gold', 'silver', 'bronze')
  -- goldは2^0=1が, silverは2^1=2が, bronzeは2^2=4という数値が割り当てられてる.
  -- ので, goldとsilverを含むrecordを抽出したい場合は1+2=3を抽出すれば良い.
);

insert into users (name, score, coins) values ('taguchi', 5.8, 'gold,silver');
insert into users (name, score, coins) values ('taro', 10.1, 'bronze,gold'); -- coinsが抽出されるとgold,bronzeの並びになる
insert into users (name, score, coins) values ('test', 9.9, 'red'); -- coinsがredなので弾かれてtableに保存されない.
insert into users (name, score, coins) values ('Tak', 1.1, 'silver');
insert into users (name, score, coins) values ('sola', 1.1, 'gold');

select * from users;
/*
+----+---------+-------+-------------+
| id | name    | score | coins       |
+----+---------+-------+-------------+
|  1 | taguchi |   5.8 | gold,silver |
|  2 | taro    |  10.1 | gold,bronze |
|  3 | Tak     |   1.1 | silver      |
|  4 | sola    |   1.1 | gold        |
+----+---------+-------+-------------+
*/

-- silverの行(record)だけ抽出する
select * from users where coins = 'silver';
/*
+----+------+-------+--------+
| id | name | score | coins  |
+----+------+-------+--------+
|  3 | Tak  |   1.1 | silver |
+----+------+-------+--------+
*/

-- gold,silverを持つrecordを抽出する
select * from users where coins = 'gold,silver';
/*
+----+---------+-------+-------------+
| id | name    | score | coins       |
+----+---------+-------+-------------+
|  1 | taguchi |   5.8 | gold,silver |
+----+---------+-------+-------------+
*/

-- goldを持つrecordを全て抽出する
select * from users where coins like '%gold%';
/*
+----+---------+-------+-------------+
| id | name    | score | coins       |
+----+---------+-------+-------------+
|  1 | taguchi |   5.8 | gold,silver |
|  2 | taro    |  10.1 | gold,bronze |
|  4 | sola    |   1.1 | gold        |
+----+---------+-------+-------------+
*/

-- goldだけを持つrecordを抽出する
select * from users where coins = 1;
/*
+----+------+-------+-------+
| id | name | score | coins |
+----+------+-------+-------+
|  4 | sola |   1.1 | gold  |
+----+------+-------+-------+
*/

-- silverだけを持つrecordを抽出する
select * from users where coins = 2;
/*
+----+------+-------+--------+
| id | name | score | coins  |
+----+------+-------+--------+
|  3 | Tak  |   1.1 | silver |
+----+------+-------+--------+
*/

-- gold,silverを持つrecordを抽出する
select * from users where coins = 3;
/*
+----+---------+-------+-------------+
| id | name    | score | coins       |
+----+---------+-------+-------------+
|  1 | taguchi |   5.8 | gold,silver |
+----+---------+-------+-------------+
*/
