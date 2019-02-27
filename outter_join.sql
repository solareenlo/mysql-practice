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

-- outer join (外部結合) = 2つの table で一致しない data も含めて data を取得する方法
-- 2つの内どちらを軸にするかを決める必要がある.
-- 左の posts を軸にして data を抽出する.
select * from posts left outer join comments on posts.id = comments.post_id; -- outer は省略することもできる.
-- ので posts にある data は全て抽出され, 関連する data がないところは null になる.
/*
+----+---------+--------+------+---------+---------------------------+
| id | title   | body   | id   | post_id | body                      |
+----+---------+--------+------+---------+---------------------------+
|  1 | title 1 | body 1 |    1 |       1 | first comment for post 1  |
|  1 | title 1 | body 1 |    2 |       1 | second comment for post 1 |
|  3 | title 3 | body 3 |    3 |       3 | first comment for post 3  |
|  2 | title 2 | body 2 | NULL |    NULL | NULL                      |
+----+---------+--------+------+---------+---------------------------+
*/

-- 右の comments を軸にして data を抽出する.
select * from posts right outer join comments on posts.id = comments.post_id; -- outer は省略することもできる.
-- ので comments にある data は全て抽出され, 関連する data がないところは null になる.
/*
+------+---------+--------+----+---------+---------------------------+
| id   | title   | body   | id | post_id | body                      |
+------+---------+--------+----+---------+---------------------------+
|    1 | title 1 | body 1 |  1 |       1 | first comment for post 1  |
|    1 | title 1 | body 1 |  2 |       1 | second comment for post 1 |
|    3 | title 3 | body 3 |  3 |       3 | first comment for post 3  |
| NULL | NULL    | NULL   |  4 |       4 | first comment for post 4  |
+------+---------+--------+----+---------+---------------------------+
/*

-- もっと細かいルールもあります.
