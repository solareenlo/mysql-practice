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

-- transaction(ひとまとまりの処理)を実行
-- taroさんのscoreからtaguchiさんのscoreへ1.2を移動させる.
-- start から commit; までが1つの transaction として実行される.
start transaction;
update users set score = score - 1.2 where name = 'taro';
update users set score = score + 1.2 where name = 'taguchi';
commit;

select * from users;
/*
+----+---------+-------+
| id | name    | score |
+----+---------+-------+
|  1 | taguchi |     7 |
|  2 | taro    |     7 |
|  3 | github  |  10.1 |
|  4 | Yamada  |  NULL |
|  5 | test    |   1.1 |
+----+---------+-------+
*/

-- rollback; を使うと transaction の中身が破棄される.
start transaction;
update users set score = score - 1.2 where name = 'taro';
update users set score = score + 1.2 where name = 'taguchi';
rollback;

select * from users;
/*
+----+---------+-------+
| id | name    | score |
+----+---------+-------+
|  1 | taguchi |     7 |
|  2 | taro    |     7 |
|  3 | github  |  10.1 |
|  4 | Yamada  |  NULL |
|  5 | test    |   1.1 |
+----+---------+-------+
*/
