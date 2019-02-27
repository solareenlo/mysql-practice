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

-- teamごとの合計点を算出するには group by を用いる.
select sum(score), team from users_with_team group by team;
/*
> +--------------------+--------+
> | sum(score)         | team   |
> +--------------------+--------+
> | 10.100000381469727 | Team-A |
> |  8.199999809265137 | Team-B |
> |  6.900000214576721 | Team-C |
> +--------------------+--------+
*/

-- 上記を逆順に算出する
select sum(score), team from users_with_team group by team desc;
/*
> +--------------------+--------+
> | sum(score)         | team   |
> +--------------------+--------+
> |  6.900000214576721 | Team-C |
> |  8.199999809265137 | Team-B |
> | 10.100000381469727 | Team-A |
> +--------------------+--------+
*/

-- group by で集計した後のdataに対して条件を付ける場合はwhereではなくhavingを用いる.
-- having はグループ化に使った値や集計した値しか条件に使えない.
select sum(score), team from users_with_team group by team having sum(score) > 10.0;
/*
> +--------------------+--------+
> | sum(score)         | team   |
> +--------------------+--------+
> | 10.100000381469727 | Team-A |
> +--------------------+--------+
*/

-- where と group by を一緒に使った場合は,
-- where の条件でデータの抽出を行った後に group by でその集計を行うことになる.
-- 下記はidが3より大きいデータを抽出した後, teamのscoreの合計を算出している.
select sum(score), team from users_with_team where id > 3 group by team;
/*
> +-------------------+--------+
> | sum(score)        | team   |
> +-------------------+--------+
> | 1.100000023841858 | Team-C |
> +-------------------+--------+
*/
