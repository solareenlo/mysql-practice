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

-- 抽出条件に名前を付けて table の用に扱える view
-- 新しい table を作っているわけではない.
drop view if exists top3; -- top3というviewが文字存在するならば削除してね
-- select 以下の抽出条件を top3 として保存している.
create view top3 as select * from users order by score desc limit 3;
select * from top3;
/*
> +----+---------+-------+
> | id | name    | score |
> +----+---------+-------+
> |  3 | github  |  10.1 |
> |  2 | taro    |   8.2 |
> |  1 | taguchi |   5.8 |
> +----+---------+-------+
*/

-- view は table と同じ扱いにので,
show tables;
/*
> +-----------------+
> | Tables_in_myapp |
> +-----------------+
> | persons         |
> | top3            |
> | users           |
> | users_copy      |
> | users_empty     |
> +-----------------+
*/
-- と表示される.

-- どうやって top3 という view が作られたのかを見るには,
show create view top3;
/*
+------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
| View | Create View                                                                                                                                                                                                                        | character_set_client | collation_connection |
+------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
| top3 | CREATE ALGORITHM=UNDEFINED DEFINER=`myapp_user`@`localhost` SQL SECURITY DEFINER VIEW `top3` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`score` AS `score` from `users` order by `users`.`score` desc limit 3 | utf8                 | utf8_general_ci      |
+------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
*/
-- AS 以降が抽出条件になっている.
