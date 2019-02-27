drop table if exists posts;
create table posts (
  id int unsigned primary key auto_increment,
  title varchar(255),
  body text
);

drop table if exists comments;
create table comments (
  id int unsigned primary key auto_increment,
  post_id int not null,
  body text
);

insert into posts (title, body) values ('title 1', 'body 1');
insert into posts (title, body) values ('title 2', 'body 2');
insert into posts (title, body) values ('title 3', 'body 3');

insert into comments (post_id, body) values (1, 'first comment for post 1');
insert into comments (post_id, body) values (1, 'second comment for post 1');
insert into comments (post_id, body) values (3, 'first comment for post 3');
insert into comments (post_id, body) values (4, 'first comment for post 4');

select * from posts;
/*
> +----+---------+--------+
> | id | title   | body   |
> +----+---------+--------+
> |  1 | title 1 | body 1 |
> |  2 | title 2 | body 2 |
> |  3 | title 3 | body 3 |
> +----+---------+--------+
*/
select * from comments;
/*
> +----+---------+---------------------------+
> | id | post_id | body                      |
> +----+---------+---------------------------+
> |  1 |       1 | first comment for post 1  |
> |  2 |       1 | second comment for post 1 |
> |  3 |       3 | first comment for post 3  |
> |  4 |       4 | first comment for post 4  |
+----+---------+---------------------------+
*/

-- inner join = 2つの table に共通の data だけを取得する方法
-- posts の id と comments の post_id を inner join で結びつけて条件が合致する data だけ抽出する
select * from posts inner join comments on posts.id = comments.post_id; -- inner は省略することもできる.
/*
> +----+---------+--------+----+---------+---------------------------+
> | id | title   | body   | id | post_id | body                      |
> +----+---------+--------+----+---------+---------------------------+
> |  1 | title 1 | body 1 |  1 |       1 | first comment for post 1  |
> |  1 | title 1 | body 1 |  2 |       1 | second comment for post 1 |
> |  3 | title 3 | body 3 |  3 |       3 | first comment for post 3  |
> +----+---------+--------+----+---------+---------------------------+
*/

-- inner join で特定の field だけ取得したい場合
select posts.id, posts.title, posts.body, comments.body from posts inner join comments on posts.id = comments.post_id;
-- field 名が自明の場合は省略することができる.
-- 例えば title は posts にしかないので,
-- select posts.id, title, posts.body, comments.body from posts inner join comments on posts.id = comments.post_id;
-- と書ける.
/*
> +----+---------+--------+---------------------------+
> | id | title   | body   | body                      |
> +----+---------+--------+---------------------------+
> |  1 | title 1 | body 1 | first comment for post 1  |
> |  1 | title 1 | body 1 | second comment for post 1 |
> |  3 | title 3 | body 3 | first comment for post 3  |
> +----+---------+--------+---------------------------+
*/
