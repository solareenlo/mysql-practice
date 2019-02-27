drop table if exists users; -- 練習用に前のusers tableを消している
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

insert into users (name ,score) values ('taguchi', 5.8);
insert into users (name ,score) values ('taro', 8.2);
insert into users (name ,score) values ('github', 10.1);
insert into users (name ,score) values ('Yamada', null);
insert into users (name ,score) values ('test', 1.1);

select * from users;
/*
> +----+---------+-------+
> | id | name    | score |
> +----+---------+-------+
> |  1 | taguchi |   5.8 |
> |  2 | taro    |   8.2 |
> |  3 | github  |  10.1 |
> |  4 | Yamada  |  NULL |
> |  5 | test    |   1.1 |
> +----+---------+-------+
*/

-- scoreの別の書き方
-- で抽出されたデータで新たにtableを作成する
drop table if exists users_with_team; -- 練習用に前のusers_with_team tableを消している
create table users_with_team as
select
  id,
  name,
  score,
  case
    when score > 10.0 then 'Team-A'
    when score > 8.0 then 'Team-B'
    else 'Team-C'
  end as team
from
  users;
select * from users_with_team;
/*
> +----+---------+-------+--------+
> | id | name    | score | team   |
> +----+---------+-------+--------+
> |  1 | taguchi |   5.8 | Team-C |
> |  2 | taro    |   8.2 | Team-B |
> |  3 | github  |  10.1 | Team-A |
> |  4 | Yamada  |  NULL | Team-C |
> |  5 | test    |   1.1 | Team-C |
> +----+---------+-------+--------+
*/

-- tableの中のnull以外のdataの個数を調べる
select count(score) from users_with_team;
/*
> +--------------+
> | count(score) |
> +--------------+
> |            4 |
> +--------------+
*/

-- tableの中の全てのdataの個数を調べる
select count(*) from users_with_team;
/*
> +--------------+
> | count(score) |
> +--------------+
> |            5 |
> +--------------+
*/

select sum(score) from users_with_team; -- scoreの合計を算出
select min(score) from users_with_team; -- scoreの最小値を抽出
select max(score) from users_with_team; -- scoreの最大値を抽出
select avg(score) from users_with_team; -- scoreの平均値を算出

-- 重複する値以外=一意な値 のみを抽出する
select distinct team from users_with_team;
/*
> +--------+
> | team   |
> +--------+
> | Team-C |
> | Team-B |
> | Team-A |
> +--------+
*/

-- 重複する値以外=一意な値 の個数を調べる
select count(distinct team) from users_with_team;
/*
> +----------------------+
> | count(distinct team) |
> +----------------------+
> |                    3 |
> +----------------------+
*/
