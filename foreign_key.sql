drop table if exists posts;
create table posts (
  id int unsigned primary key auto_increment,
  title varchar(255),
  body text
);

drop table if exists comments;
create table comments (
  id int unsigned primary key auto_increment,
  post_id int unsigned not null,
  body text
);

-- comments の post_id には, posts の id にある値しか挿入できないようにする書き方.
-- 紐付ける値同士の型は一致していないといけない.
-- fk_comments という名の外部キー制約.
alter table comments add constraint fk_comments foreign key (post_id) references posts (id);

insert into posts (title, body) values ('title 1', 'body 1');
insert into posts (title, body) values ('title 2', 'body 2');
insert into posts (title, body) values ('title 3', 'body 3');

insert into comments (post_id, body) values (1, 'first comment for post 1');
insert into comments (post_id, body) values (1, 'second comment for post 1');
insert into comments (post_id, body) values (3, 'first comment for post 3');
insert into comments (post_id, body) values (4, 'first comment for post 4'); -- ここはエラーになって挿入されない.

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

-- 外部キー制約を設定すると, 関連する data がある場合には data の削除や更新が簡単にはできなくなる.
delete from posts where id = 1;
-- > ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`myapp`.`comments`, CONSTRAINT `fk_comments` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`))
-- のように外部キー制約エラーは発生して delete できない.

-- 外部キー制約削除
alter table comments drop foreign key fk_comments;

-- 外部キーはもっと奥が深いです.
