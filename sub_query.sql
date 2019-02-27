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

-- 一時的にしか使わない tabale だと sub query を用いて, 新たな table を作らずに表示できる.
select
  sum(t.score),
  t.team
from
  (select
    id,
    name,
    score,
    case
      when score > 10.0 then 'Team-A'
      when score > 8.0 then 'Team-B'
      else 'Team-C'
    end as team
  from users) as t -- t という sub query として一時的に作成する
group by t.team;
/*
> +--------------------+--------+
> | sum(t.score)       | team   |
> +--------------------+--------+
> | 10.100000381469727 | Team-A |
> |  8.199999809265137 | Team-B |
> |  6.900000214576721 | Team-C |
> +--------------------+--------+
*/
