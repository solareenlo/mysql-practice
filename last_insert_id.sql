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
+----+---------+---------------------------+
*/

-- posts の id が 2 の record を削除して新たな record を挿入すると
-- 新たに挿入された record の id はどうなるかというと
-- 1番大きな id + 1 の値になる.
delete from posts where id = 2; -- id が 2 の record を削除.
insert into posts (title, body) values ('new title', 'new body'); -- この record の id は 4 になってる.
insert into comments (post_id, body) values (last_insert_id(), 'first comment for new post');
-- last_insert_id() を使うと直前に挿入した record の id を引っ張ってきてくれる.

select * from posts;
/*
> +----+-----------+----------+
> | id | title     | body     |
> +----+-----------+----------+
> |  1 | title 1   | body 1   |
> |  3 | title 3   | body 3   |
> |  4 | new title | new body |
> +----+-----------+----------+
*/
select * from comments;
/*
> +----+---------+----------------------------+
> | id | post_id | body                       |
> +----+---------+----------------------------+
> |  1 |       1 | first comment for post 1   |
> |  2 |       1 | second comment for post 1  |
> |  3 |       3 | first comment for post 3   |
> |  4 |       4 | first comment for new post |
> +----+---------+----------------------------+
*/
