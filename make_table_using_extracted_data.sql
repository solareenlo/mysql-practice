drop table if exists users;
drop table if exists users_copy;
drop table if exists users_with_team;
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

-- users tableのコピーを作成する
create table users_copy as select * from users; -- asは省略可能
select * from users_copy;
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

-- users tableの構造だけをコピーしたtableを作成する
create table users_empty like users;
desc users_empty;
/*
> +-------+------------------+------+-----+---------+----------------+
> | Field | Type             | Null | Key | Default | Extra          |
> +-------+------------------+------+-----+---------+----------------+
> | id    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
> | name  | varchar(20)      | YES  |     | NULL    |                |
> | score | float            | YES  |     | NULL    |                |
> +-------+------------------+------+-----+---------+----------------+
*/
select * from users_empty;
-- > Empty set (0.00 sec)
