drop table if exists users;
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
+----+---------+-------+
| id | name    | score |
+----+---------+-------+
|  1 | taguchi |   5.8 |
|  2 | taro    |   8.2 |
|  3 | github  |  10.1 |
|  4 | Yamada  |  NULL |
|  5 | test    |   1.1 |
+----+---------+-------+
*/

select
  name,
  score,
  if (score > 5.0, 'OK', 'NG') as result
from
  users;
/*
+---------+-------+--------+
| name    | score | result |
+---------+-------+--------+
| taguchi |   5.8 | OK     |
| taro    |   8.2 | OK     |
| github  |  10.1 | OK     |
| Yamada  |  NULL | NG     |
| test    |   1.1 | NG     |
+---------+-------+--------+
*/

select
  name,
  score,
  case floor(score) % 2 -- 小数点以下を切り捨てて, 2で割った余りが
    when 0 then 'even' -- 0のときはevenと表示
    when 1 then 'odd' -- 1のときはoddと表示
    else null -- 0と1以外ならnullと表示
  end as type -- それらをtypeのfieldで表示する
from
  users;
/*
+---------+-------+------+
| name    | score | type |
+---------+-------+------+
| taguchi |   5.8 | odd  |
| taro    |   8.2 | even |
| github  |  10.1 | even |
| Yamada  |  NULL | NULL |
| test    |   1.1 | odd  |
+---------+-------+------+
*/

-- scoreの別の書き方
select
  name,
  score,
  case
    when score > 10.0 then 'Team-A'
    when score > 8.0 then 'Team-B'
    else 'Team-C'
  end as team
from
  users;
/*
+---------+-------+--------+
| name    | score | team   |
+---------+-------+--------+
| taguchi |   5.8 | Team-C |
| taro    |   8.2 | Team-B |
| github  |  10.1 | Team-A |
| Yamada  |  NULL | Team-C |
| test    |   1.1 | Team-C |
+---------+-------+--------+
*/
